//
//  GONMarkupParser.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland All rights reserved.
//

#import "GONMarkupParser.h"
#import "GONMarkup+Private.h"
#import "GONMarkupDefaultMarkups.h"

#define REGEX                   @"(.*?)(<[^>]+>|\\Z)"
#define LOG_IF_DEBUG(msg, ...)  do {if (_debugEnabled) { NSLog(@"MarkupParser : %@", [NSString stringWithFormat:msg, ##__VA_ARGS__]); }} while(0)

@interface GONMarkupParser ()
// Style
@property (nonatomic, strong) NSMutableDictionary *defaultConfiguration;     // Default attributed string configuration

// Fonts
@property (nonatomic, strong) NSMutableDictionary *dicRegisteredFonts;       // Registered fonts

// Data
@property (nonatomic, strong) NSMutableDictionary *dicCurrentMarkup;         // Dictionary representation of markups
@property (nonatomic, strong) NSRegularExpression *regex;                    // Regular expression to extract tokens

// Ephemeral internal data. Used to prevent from having too much parameters in internal functions
@property (nonatomic, strong) NSMutableArray      *configurationsStack;      // Configurations stack
@property (nonatomic, strong) NSMutableArray      *markupsStack;             // Markups stack
@property (nonatomic, strong) NSMutableDictionary *currentContext;           // Current context
@end

@implementation GONMarkupParser
#pragma mark - Constructor
+ (GONMarkupParser *)defaultMarkupParser
{
    GONMarkupParser *parser = [[GONMarkupParser alloc] init];

    [parser addMarkup:[GONMarkupFont fontMarkup]];
    [parser addMarkup:[GONMarkupColor colorMarkup]];
    [parser addMarkup:[GONMarkupLineBreak lineBreakMarkup]];
    [parser addMarkup:[GONMarkupReset resetMarkup]];
    [parser addMarkup:[GONMarkupParagrap paragraphMarkup]];

    [parser addMarkups:[GONMarkupTextStyle allMarkups]];
    [parser addMarkups:[GONMarkupList allMarkups]];
    [parser addMarkups:[GONMarkupAlignment allMarkups]];
    
    return parser;
}

+ (GONMarkupParser *)emptyMarkupParser
{
    return [[GONMarkupParser alloc] init];
}

- (id)init
{
    if (self = [super init])
    {
        _regex = [[NSRegularExpression alloc] initWithPattern:REGEX
                                                      options:NSRegularExpressionDotMatchesLineSeparators
                                                        error:nil];

        _defaultConfiguration = [[NSMutableDictionary alloc] init];
        _dicCurrentMarkup     = [[NSMutableDictionary alloc] init];
        _dicRegisteredFonts   = [[NSMutableDictionary alloc] init];
    }

    return self;
}

#pragma mark - Markup management
- (void)addMarkup:(GONMarkup *)aMarkup
{
    // Nothing to do if already added to parser
    if (aMarkup.parser == self)
        return;

    if (aMarkup.parser != nil)
        @throw @"Error, a Markup can be used by only one parser at a time";

    // Bind to parser
    aMarkup.parser = self;
    [_dicCurrentMarkup setObject:aMarkup
                          forKey:aMarkup.tag];
}

- (void)addMarkups:(id <NSFastEnumeration>)markups
{
    for (GONMarkup *markup in markups)
        [self addMarkup:markup];
}

- (void)removeMarkup:(GONMarkup *)aMarkup
{
    GONMarkup *currentMarkup = [_dicCurrentMarkup objectForKey:aMarkup.tag];
    if (currentMarkup == aMarkup)
    {
        // Remove parser link
        aMarkup.parser = nil;
        [_dicCurrentMarkup removeObjectForKey:aMarkup.tag];
    }
}

- (void)removeMarkups:(id <NSFastEnumeration>)markups
{
    for (GONMarkup *markup in markups)
        [self removeMarkup:markup];
}

- (void)removeAllMarkups
{
    for (GONMarkup *markup in [_dicCurrentMarkup allValues])
        markup.parser = nil;

    [_dicCurrentMarkup removeAllObjects];
}

#pragma mark - Parser
- (NSMutableAttributedString *)attributedStringFromString:(NSString *)aString error:(NSError **)anError
{
    LOG_IF_DEBUG(@"Input string :\n%@\n", aString);

    // Check for nil values
    if (!aString)
    {
        LOG_IF_DEBUG(@"Input string was <nil>, returning empty string");
        return [[NSMutableAttributedString alloc] init];
    }

    // Make input string mutable
    NSMutableString *inputString = [aString mutableCopy];

    // Handle pre processing
    LOG_IF_DEBUG(@"Preprocessing string");
    if (_preProcessingBlock)
        _preProcessingBlock(inputString);

    // Parse input string
    NSMutableAttributedString *resString = [self parseString:inputString error:anError];

    if (_debugEnabled)
    {
        if (anError)
            LOG_IF_DEBUG(@"Parsing completed with an error <%@>", *anError);
        else
            LOG_IF_DEBUG(@"Parsing completed without error");
    }

    // Handle post processing
    LOG_IF_DEBUG(@"Postprocessing string");
    if (_postProcessingBlock)
        _postProcessingBlock(resString);

    LOG_IF_DEBUG(@"Result string :\n%@\n", resString);

    return resString;
}

- (NSMutableAttributedString *)parseString:(NSString *)inputString error:(NSError **)anError
{
    // Init stack
    _configurationsStack = [[NSMutableArray alloc] init];
    _currentContext      = [[NSMutableDictionary alloc] init];
    _markupsStack        = [[NSMutableArray alloc] init];
    
    // Parse string
    NSArray *results = [_regex matchesInString:inputString
                                       options:0
                                         range:NSMakeRange(0, inputString.length)];

    // Prepare result string
    NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc] init];

    // Browse chunks
    NSString *tmpTag;
    NSMutableString *tag;
    for (NSTextCheckingResult *result in results)
    {
        // Split string
        NSArray *parts = [[inputString substringWithRange:result.range] componentsSeparatedByString:@"<"];

        // Append extracted string
        [resultString appendAttributedString:[self computeFinalExtractedString:[parts firstObject]]];

        // Check if a tag was found
        if (parts.count > 1)
        {
            // Extract tag and clean it
            tmpTag = [[parts objectAtIndex:1] lowercaseString];
            tmpTag = [tmpTag stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

            tag = [tmpTag mutableCopy];
            [tag deleteCharactersInRange:NSMakeRange(tag.length - 1, 1)];

            if ([tag rangeOfString:@"/"].location == 0)
            {
                [resultString appendAttributedString:[self computeSuffixString]];
                [self handleClosingTag:tag error:anError];
            }
            else
            {
                // Look for autoclosing tags
                if ([tag rangeOfString:@"/" options:NSBackwardsSearch].location == (tag.length - 1))
                {
                    // Trim autoclose character
                    [tag deleteCharactersInRange:NSMakeRange(tag.length - 1, 1)];

                    // Opening tag
                    [self handleOpeningTag:tag error:anError];

                    // Append an extracted empty string
                    [resultString appendAttributedString:[self computePrefixString]];
                    [resultString appendAttributedString:[self computeFinalExtractedString:@""]];
                    [resultString appendAttributedString:[self computeSuffixString]];

                    // Close tag
                    [self handleClosingTag:tag error:anError];
                }
                else
                {
                    // Opening tag
                    [self handleOpeningTag:tag error:anError];
                    [resultString appendAttributedString:[self computePrefixString]];
                }
            }
        }
    }

    if (_configurationsStack.count != 0)
    {
        LOG_IF_DEBUG(@"Parsing completed, but stack isn't empty, some closing tags seems missing :\nStack :%@\n", _configurationsStack);
        [self generateError:anError tag:nil];
    }

    // Memory
    _markupsStack        = nil;
    _configurationsStack = nil;
    _currentContext      = nil;

    return resultString;
}

#pragma mark - Tag content managements
- (NSAttributedString *)computePrefixString
{
    GONMarkup *currentMarker = [_markupsStack lastObject];
    if (currentMarker && ![currentMarker isKindOfClass:[NSNull class]])
    {
        return [[NSAttributedString alloc] initWithString:[currentMarker prefixStringForContext:_currentContext]
                                               attributes:[self currentConfiguration]];
    }

    return [[NSAttributedString alloc] initWithString:@"" attributes:[self currentConfiguration]];
}

- (NSAttributedString *)computeSuffixString
{
    GONMarkup *currentMarker = [_markupsStack lastObject];
    if (currentMarker && ![currentMarker isKindOfClass:[NSNull class]])
    {
        return [[NSAttributedString alloc] initWithString:[currentMarker suffixStringForContext:_currentContext]
                                               attributes:[self currentConfiguration]];
    }

    return [[NSAttributedString alloc] initWithString:@"" attributes:[self currentConfiguration]];
}

- (NSAttributedString *)computeFinalExtractedString:(NSString *)inputString
{
    GONMarkup *currentMarker = [_markupsStack lastObject];
    if (currentMarker && ![currentMarker isKindOfClass:[NSNull class]])
    {
        return [[NSAttributedString alloc] initWithString:[currentMarker updatedContentString:inputString
                                                                                      context:_currentContext]
                                               attributes:[self currentConfiguration]];
    }

    return [[NSAttributedString alloc] initWithString:inputString attributes:[self currentConfiguration]];
}

#pragma mark - Tag managements
- (void)handleClosingTag:(NSString *)tag error:(NSError **)anError
{
    // Look for full style closing tag
    if ([tag rangeOfString:@"//"].location == 0)
    {
        if (!_configurationsStack.count)
        {
            LOG_IF_DEBUG(@"Trying to close all tags, but stack is empty");
            [self generateError:anError tag:tag];
        }
        else
        {
            GONMarkup *markup;
            NSMutableDictionary *currentTagConfiguration;
            for (NSInteger i=_markupsStack.count - 1; i>=0; i--)
            {
                markup = [_markupsStack objectAtIndex:i];
                currentTagConfiguration = [_configurationsStack objectAtIndex:i];

                [markup closingMarkupFound:tag
                             configuration:currentTagConfiguration
                                   context:_currentContext];
            }

            [_configurationsStack removeAllObjects];
            [_markupsStack removeAllObjects];

            LOG_IF_DEBUG(@"Closing all tags\nStack : %@\n", _configurationsStack);
        }
    }
    else
    {
        // Check if available tags
        if (!_configurationsStack.count)
        {
            // Closing a tag, but tags stack is empty
            LOG_IF_DEBUG(@"Trying to close last tag, but stack is empty");
            [self generateError:anError tag:tag];
        }
        else
        {
            
            // Extract current markup
            GONMarkup *markup =[_markupsStack lastObject];

            // Present error when closing an unkwnow markup
            if (markup && ![markup isKindOfClass:[NSNull class]])
            {
                [markup closingMarkupFound:tag
                             configuration:[_configurationsStack lastObject]
                                   context:_currentContext];
            }

            // Remove last tag objet
            [_configurationsStack removeLastObject];
            [_markupsStack removeLastObject];

            LOG_IF_DEBUG(@"Closing tag (%@)\nStack : %@\n", tag, _configurationsStack);
        }
    }
}

- (void)handleOpeningTag:(NSString *)tag error:(NSError **)anError
{
    // Prepare tag configuration
    NSMutableDictionary *currentTagConfiguration;
    if (!_configurationsStack.count)
        currentTagConfiguration = [_defaultConfiguration mutableCopy];
    else
        currentTagConfiguration = [[_configurationsStack lastObject] mutableCopy];
    
    // Retrieve rule
    GONMarkup *markup = [_dicCurrentMarkup objectForKey:tag];
    if (!markup)
    {
        // Look up throught all markups
        for (GONMarkup *tmpMarkup in [_dicCurrentMarkup allValues])
        {
            if ([tmpMarkup canHandleTag:tag])
            {
                // Rule found
                markup = tmpMarkup;
                break;
            }
        }
    }

    // Ensure a markup was found
    if (!markup)
    {
        LOG_IF_DEBUG(@"No markup found for tag <%@>\n", tag);
        [self generateError:anError
                        tag:tag];

        [_markupsStack addObject:[NSNull null]];
    }
    else
    {
        [markup openingMarkupFound:tag
                     configuration:currentTagConfiguration
                           context:_currentContext];

        [_markupsStack addObject:markup];
    }

    // Hold configuration
    [_configurationsStack addObject:currentTagConfiguration];

    LOG_IF_DEBUG(@"Opening tag (%@)\nStack : %@\n", tag, _configurationsStack);
}

- (NSDictionary *)currentConfiguration
{
    if (!_configurationsStack.count)
        return [_defaultConfiguration copy];

    return [[_configurationsStack lastObject] copy];
}

#pragma mark - Fonts management
- (void)registerFont:(UIFont *)aFont forKey:(NSString *)aKey
{
    [_dicRegisteredFonts setObject:aFont
                            forKey:aKey];
}

- (UIFont *)fontForKey:(NSString *)aKey
{
    return [_dicRegisteredFonts objectForKey:aKey];
}

- (void)unregisterFontForKey:(NSString *)aKey
{
    [_dicRegisteredFonts removeObjectForKey:aKey];
}

#pragma mark - Error handling
- (void)generateError:(NSError **)anError tag:(NSString *)aTag
{
    if (anError)
    {
        // Initialize user info
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:@"Input string is malformed. Ouput attributed string may not display correctly"
                                                                           forKey:NSLocalizedDescriptionKey];

        // Add tag if avalaible
        if (aTag)
        {
            [userInfo setObject:aTag
                         forKey:GONMarkupParser_incorrectClosingTag_KEY];
        }

        // Build error
        *anError = [NSError errorWithDomain:GONMarkupParser_ERROR_DOMAIN
                                       code:GONMarkupParser_StringMalformed_ERROR_CODE
                                   userInfo:userInfo];
    }
}

#pragma mark - Getters
- (NSArray *)markups
{
    return [[_dicCurrentMarkup allValues] copy];
}

- (NSDictionary *)registeredFonts
{
    return [_dicRegisteredFonts copy];
}

@end

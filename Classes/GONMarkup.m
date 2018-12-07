//
//  GONMarkup.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland All rights reserved.
//

#import "GONMarkup.h"
#import "GONMarkupParser.h"

@interface GONMarkup()
// Data
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *testedTag;

// Parser link
@property (nonatomic, weak) GONMarkupParser *parser;
@end

@implementation GONMarkup
#pragma mark - Constructors
+ (instancetype)markupForTag:(NSString *)tag
{
    return [[self alloc] initWithTag:tag];
}

- (id)initWithTag:(NSString *)tag
{
    if (self = [super init])
    {
        _tag = [[tag lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _testedTag = [_tag stringByAppendingString:@" "];
    }

    return self;
}

- (id)init
{
    @throw @"Error, - init constructor is not allowed. Markup MUST have a tag";
}

#pragma mark - Test
- (NSAttributedString *)updatedContentString:(NSString *)string
                                     context:(NSMutableDictionary *)context
                                  attributes:(NSDictionary *)dicAttributes
                            stringAttributes:(NSDictionary *)stringAttributes
                                resultString:(NSAttributedString *)resultString
{
    return [[NSAttributedString alloc] initWithString:string attributes:stringAttributes];
}

- (NSAttributedString *)updatedContentString:(NSString *)string
                                     context:(NSMutableDictionary *)context
                                  attributes:(NSDictionary *)dicAttributes
                            stringAttributes:(NSDictionary *)stringAttributes
{
    NSLog(@"WARNING : This method will be deleted in next release. Use updatedContentString:context:attributes:stringAttributes:resultString: instead");

    return [self updatedContentString:string
                              context:context
                           attributes:dicAttributes
                     stringAttributes:stringAttributes
                         resultString:nil];
}

- (NSAttributedString *)prefixStringForContext:(NSMutableDictionary *)context
                                    attributes:(NSDictionary *)dicAttributes
                              stringAttributes:(NSDictionary *)stringAttributes
                                  resultString:(NSAttributedString *)resultString
{
    return [[NSAttributedString alloc] initWithString:@""];
}

- (NSAttributedString *)prefixStringForContext:(NSMutableDictionary *)context
                                    attributes:(NSDictionary *)dicAttributes
                              stringAttributes:(NSDictionary *)stringAttributes
{
    NSLog(@"WARNING : This method will be deleted in next release. Use prefixStringForContext:attributes:stringAttributes:resultString: instead");
    
    return [self prefixStringForContext:context
                             attributes:dicAttributes
                       stringAttributes:stringAttributes
                           resultString:nil];
}

- (NSAttributedString *)suffixStringForContext:(NSMutableDictionary *)context
                                    attributes:(NSDictionary *)dicAttributes
                              stringAttributes:(NSDictionary *)stringAttributes
{
    NSLog(@"WARNING : This method will be deleted in next release. Use suffixStringForContext:attributes:stringAttributes:resultString: instead");

    return [self suffixStringForContext:context
                             attributes:dicAttributes
                       stringAttributes:stringAttributes
                           resultString:nil];
}

- (NSAttributedString *)suffixStringForContext:(NSMutableDictionary *)context
                                    attributes:(NSDictionary *)dicAttributes
                              stringAttributes:(NSDictionary *)stringAttributes
                                  resultString:(NSAttributedString *)resultString
{
    return [[NSAttributedString alloc] initWithString:@""];
}

#pragma mark - Style
- (void)openingMarkupFound:(NSString *)tag
             configuration:(NSMutableDictionary *)configurationDictionary
                   context:(NSMutableDictionary *)context
                attributes:(NSDictionary *)dicAttributes
              resultString:(NSAttributedString *)resultString {}

- (void)openingMarkupFound:(NSString *)tag
             configuration:(NSMutableDictionary *)configurationDictionary
                   context:(NSMutableDictionary *)context
                attributes:(NSDictionary *)dicAttributes {

    NSLog(@"WARNING : This method will be deleted in next release. Use openingMarkupFound:configuration:context:attributes:resultString: instead");
    
    [self openingMarkupFound:tag
               configuration:configurationDictionary
                     context:context
                  attributes:dicAttributes
                resultString:nil];
}

- (void)closingMarkupFound:(NSString *)tag
             configuration:(NSMutableDictionary *)configurationDictionary
                   context:(NSMutableDictionary *)context
                attributes:(NSDictionary *)dicAttributes {

    NSLog(@"WARNING : This method will be deleted in next release. Use closingMarkupFound:configuration:context:attributes:resultString: instead");

    [self closingMarkupFound:tag
               configuration:configurationDictionary
                     context:context
                  attributes:dicAttributes
                resultString:nil];
}

- (void)closingMarkupFound:(NSString *)tag
             configuration:(NSMutableDictionary *)configurationDictionary
                   context:(NSMutableDictionary *)context
                attributes:(NSDictionary *)dicAttributes
              resultString:(NSAttributedString *)resultString {}

@end
    

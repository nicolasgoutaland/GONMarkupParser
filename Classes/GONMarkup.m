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
+ (instancetype)markupForTag:(NSString *)aTag
{
    return [[self alloc] initWithTag:aTag];
}

- (id)initWithTag:(NSString *)aTag
{
    if (self = [super init])
    {
        _tag = [[aTag lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _testedTag = [_tag stringByAppendingString:@" "];
    }

    return self;
}

- (id)init
{
    @throw @"Error, - init constructor is not allowed. Markup MUST have a tag";
}

#pragma mark - Test
- (BOOL)canHandleTag:(NSString *)aTag
{
    return ([aTag rangeOfString:_testedTag].location == 0);
}

- (NSString *)updatedContentString:(NSString *)aString context:(NSMutableDictionary *)aContext
{
    return aString;
}

- (NSString *)prefixStringForContext:(NSMutableDictionary *)aContext
{
    return @"";
}

- (NSString *)suffixStringForContext:(NSMutableDictionary *)aContext;
{
    return @"";
}

#pragma mark - Style
- (void)openingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext {}
- (void)closingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext {}
@end
    
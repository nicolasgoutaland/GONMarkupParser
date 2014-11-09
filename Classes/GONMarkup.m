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
- (BOOL)canHandleTag:(NSString *)tag
{
    return ([tag rangeOfString:_testedTag].location == 0);
}

- (NSString *)updatedContentString:(NSString *)string context:(NSMutableDictionary *)context
{
    return string;
}

- (NSString *)prefixStringForContext:(NSMutableDictionary *)context
{
    return @"";
}

- (NSString *)suffixStringForContext:(NSMutableDictionary *)context;
{
    return @"";
}

#pragma mark - Style
- (void)openingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context {}

- (void)closingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context {}

@end
    
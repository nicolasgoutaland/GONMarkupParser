//
//  GONMarkupList.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupList.h"
#import "GONMarkupListItem.h"
#import "GONMarkup+Private.h"

@interface GONMarkupList ()
// Data
@property (nonatomic, assign) BOOL isOrdered;
@end

@implementation GONMarkupList
#pragma mark - Markup list
+ (NSArray *)allMarkups
{
    return @[[self listMarkup], [self orderedListMarkup], [GONMarkupListItem listItemMarkup]];
}

#pragma mark - Constructor
+ (instancetype)listMarkup
{
    GONMarkupList *markupList = [self markupForTag:GONMarkupList_unordered_TAG];

    markupList.isOrdered = NO;

    return markupList;
}

+ (instancetype)orderedListMarkup
{
    GONMarkupList *markupList = [self markupForTag:GONMarkupList_ordered_TAG];

    markupList.isOrdered =YES;

    return markupList;
}

#pragma mark - Markup lifecycle
- (void)openingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext
{
    // Compute indentation level
    NSInteger indentationLevel = 0;
    NSDictionary *currentConfiguration = [self currentContextConfiguration:GONMarkupList_CONFIGURATIONS_KEY
                                                               fromContext:aContext];
    if (currentConfiguration)
        indentationLevel = [[currentConfiguration objectForKey:GONMarkupList_INDENTATION_KEY] intValue] + 1;

    NSDictionary *configuration = [@{
                                     GONMarkupList_ORDERED_KEY       : @(_isOrdered),
                                     GONMarkupList_INDENTATION_KEY   : @(indentationLevel)
                                    } mutableCopy];

    [self pushConfiguration:configuration
                  toContext:aContext
                     forKey:GONMarkupList_CONFIGURATIONS_KEY];
}

- (NSString *)updatedContentString:(NSString *)aString context:(NSMutableDictionary *)aContext
{
    return @"";
}

- (void)closingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext
{
    [self popContextConfiguration:GONMarkupList_CONFIGURATIONS_KEY
                      fromContext:aContext];
}

@end

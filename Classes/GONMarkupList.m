//
//  GONMarkupList.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupList.h"
#import "GONMarkupListItem.h"

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
    NSMutableDictionary *listConfiguration = [self pushedConfiguration:aContext];

    [listConfiguration setObject:@(_isOrdered)
                          forKey:GONMarkupList_ORDERED_KEY];
}

- (NSString *)updatedContentString:(NSString *)aString context:(NSMutableDictionary *)aContext
{
    return @"";
}

- (void)closingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext
{
    [self popCurrentConfiguration:aContext];
}

#pragma mark - Utils
- (NSMutableDictionary *)pushedConfiguration:(NSMutableDictionary *)aContext
{
    // Retrieve lists configuration
    NSMutableArray *listsConfigurations = [aContext objectForKey:GONMarkupList_CONFIGURATIONS_KEY];
    if (!listsConfigurations)
    {
        // Create configurations array
        listsConfigurations = [[NSMutableArray alloc] init];
        [aContext setObject:listsConfigurations
                     forKey:GONMarkupList_CONFIGURATIONS_KEY];
    }

    // Create configuration
    NSMutableDictionary *listConfiguration = [[NSMutableDictionary alloc] init];

    // Hold current indentation
    [listConfiguration setObject:@(listsConfigurations.count)
                          forKey:GONMarkupList_INDENTATION_KEY];

    // Hold current configuration
    [listsConfigurations addObject:listConfiguration];

    return listConfiguration;
}

- (NSMutableDictionary *)popCurrentConfiguration:(NSMutableDictionary *)aContext
{
    // Retrieve lists configuration
    NSMutableArray *listsConfigurations = [aContext objectForKey:GONMarkupList_CONFIGURATIONS_KEY];

    // Retrieve current list configuration
    NSMutableDictionary *listConfiguration = [listsConfigurations lastObject];

    // Remove last configuration
    [listsConfigurations removeLastObject];

    // Check if list is empty
    if (!listsConfigurations.count)
    {
        // Remove lists configurations
        [aContext removeObjectForKey:GONMarkupList_CONFIGURATIONS_KEY];
    }

    return listConfiguration;
}

@end

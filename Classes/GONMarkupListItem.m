//
//  GONMarkupListItem.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupListItem.h"
#import "GONMarkupList.h"

@implementation GONMarkupListItem
#pragma mark - Constructor
+ (instancetype)listItemMarkup
{
    return [self markupForTag:GONMarkupListItem_TAG];
}

#pragma mark - Internal configuration
+ (NSString *)bulletForIndentation:(NSInteger)anIndentation
{
    static NSArray *bullets = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bullets = @[@"\u2022"];
    });

    return [bullets objectAtIndex:MIN(anIndentation, bullets.count - 1)];
}

- (NSString *)unorderedListItemPrefixForIndentation:(NSInteger)anIndentationLevel position:(NSInteger)aPosition listConfiguration:(NSDictionary *)aListConfiguration context:(NSMutableDictionary *)aContext
{
    NSString *indentation = [self listItemIndentation:anIndentationLevel];
    NSString *bullet = [[self class] bulletForIndentation:anIndentationLevel];

    return [NSString stringWithFormat:@"%@%@ ", indentation, bullet];
}

- (NSString *)orderedListItemPrefixForIndentation:(NSInteger)anIndentationLevel position:(NSInteger)aPosition listConfiguration:(NSDictionary *)aListConfiguration context:(NSMutableDictionary *)aContext
{
    NSString *indentation = [self listItemIndentation:anIndentationLevel];
    NSString *bullet = [NSString stringWithFormat:@"%d.", aPosition];

    return [NSString stringWithFormat:@"%@%@ ", indentation, bullet];
}

#pragma mark - Content update
- (void)openingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext
{
    // Retrieve indentation level
    NSMutableDictionary *listConfiguration = [[aContext objectForKey:GONMarkupList_CONFIGURATIONS_KEY] lastObject];
    [listConfiguration setObject:@([[listConfiguration objectForKey:GONMarkupList_POSITION_KEY] intValue] + 1)
                          forKey:GONMarkupList_POSITION_KEY];
}

- (NSString *)prefixStringForContext:(NSMutableDictionary *)aContext
{
    // Retrieve configuration
    NSDictionary *listConfiguration = [[aContext objectForKey:GONMarkupList_CONFIGURATIONS_KEY] lastObject];

    NSInteger indentation = [[listConfiguration objectForKey:GONMarkupList_INDENTATION_KEY] intValue];
    NSInteger position    = [[listConfiguration objectForKey:GONMarkupList_POSITION_KEY] intValue];
    BOOL isOrdered        = [[listConfiguration objectForKey:GONMarkupList_ORDERED_KEY] intValue];

    NSString *prefix;
    if (isOrdered)
        prefix = [self orderedListItemPrefixForIndentation:indentation position:position listConfiguration:listConfiguration context:aContext];
    else
        prefix = [self unorderedListItemPrefixForIndentation:indentation position:position listConfiguration:listConfiguration context:aContext];

    return prefix;
}

- (NSString *)suffixStringForContext:(NSMutableDictionary *)aContext
{
    return @"\n";
}

#pragma mark - Utils
- (NSString *)listItemIndentation:(NSInteger)anIndentation
{
    NSMutableString *indentString = [[NSMutableString alloc] init];

    for (NSInteger i=0; i<anIndentation; i++)
        [indentString appendString:@"\t"];

    return indentString;
}
@end

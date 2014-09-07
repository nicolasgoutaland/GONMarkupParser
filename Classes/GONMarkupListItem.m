//
//  GONMarkupListItem.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupListItem.h"
#import "GONMarkupList.h"
#import "GONMarkup+Private.h"

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
    NSString *bullet = [NSString stringWithFormat:@"%ld.", (long)aPosition];

    return [NSString stringWithFormat:@"%@%@ ", indentation, bullet];
}

#pragma mark - Content update
- (void)openingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext
{
    // Retrieve indentation level
    NSMutableDictionary *currentConfiguration = [self currentContextConfiguration:GONMarkupList_CONFIGURATIONS_KEY fromContext:aContext];
    [currentConfiguration setObject:@([[currentConfiguration objectForKey:GONMarkupList_POSITION_KEY] intValue] + 1)
                          forKey:GONMarkupList_POSITION_KEY];

    // Retrieve and update paragraph style
    NSMutableParagraphStyle *paragraphStyle = [self paragraphStyle:aConfigurationDictionary];

    // Generate prefix string
    NSAttributedString *prefixString = [[NSAttributedString alloc] initWithString:[self prefixStringForContext:aContext]
                                                                       attributes:aConfigurationDictionary];

    // Compute prefix string width
    paragraphStyle.headIndent = CGRectGetWidth([prefixString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 1) options:0 context:nil]);
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
- (NSMutableParagraphStyle *)paragraphStyle:(NSMutableDictionary *)aConfigurationDictionary
{
    NSMutableParagraphStyle *paragraphStyle = [[aConfigurationDictionary objectForKey:NSParagraphStyleAttributeName] mutableCopy];
    if (!paragraphStyle)
        paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];

    // Hold updated paragraph style
    [aConfigurationDictionary setObject:paragraphStyle
                                 forKey:NSParagraphStyleAttributeName];

    return paragraphStyle;
}

- (NSString *)listItemIndentation:(NSInteger)anIndentation
{
    NSMutableString *indentString = [[NSMutableString alloc] init];

    for (NSInteger i=0; i<anIndentation; i++)
        [indentString appendString:@"\t"];

    return indentString;
}
@end

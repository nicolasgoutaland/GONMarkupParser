//
//  GONMarkupSimple.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 18/07/14.
//  Copyright 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupSimple.h"

#define MERGE_ATTRIBUTE(att) (_mergingStrategy == GONMarkupSimpleMergingStrategyMergeAll || _mergingStrategy | att)

@interface GONMarkupSimple ()
// Data
@property (nonatomic, copy)   NSDictionary *style;
@property (nonatomic, assign) GONMarkupSimpleMergingStrategy mergingStrategy;
@end

@implementation GONMarkupSimple
#pragma mark - Constructor
+ (instancetype)simpleMarkup:(NSString *)aTag style:(NSDictionary *)aStyle mergingStrategy:(GONMarkupSimpleMergingStrategy)aStrategy
{
    GONMarkupSimple *markup = [self markupForTag:aTag];

    markup.style = aStyle;
    markup.mergingStrategy = aStrategy;

    return markup;
}

+ (instancetype)simpleMarkup:(NSString *)aTag style:(NSDictionary *)aStyle
{
    if ([aStyle objectForKey:NSParagraphStyleAttributeName])
        @throw @"Critical error. You cannot update NSParagraphStyleAttributeName without setting a merging strategy ";

    GONMarkupSimple *markup = [self markupForTag:aTag];

    markup.style = aStyle;

    return markup;
}

#pragma mark - Style
- (void)openingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext
{
    // No NSParagraphStyleAttributeName update, or set in only one dic, nothing to do
    if ((![_style objectForKey:NSParagraphStyleAttributeName] && ![aConfigurationDictionary objectForKey:NSParagraphStyleAttributeName]) ||
        ( [_style objectForKey:NSParagraphStyleAttributeName] && ![aConfigurationDictionary objectForKey:NSParagraphStyleAttributeName]) ||
        (![_style objectForKey:NSParagraphStyleAttributeName] &&  [aConfigurationDictionary objectForKey:NSParagraphStyleAttributeName]))
    {
        [aConfigurationDictionary addEntriesFromDictionary:_style];
        return;
    }

    // Should apply a defined strategy
    NSMutableDictionary *updatedStyleDic = [_style mutableCopy];
    [updatedStyleDic setObject:[self merge:[_style objectForKey:NSParagraphStyleAttributeName] into:[aConfigurationDictionary objectForKey:NSParagraphStyleAttributeName]]
                        forKey:NSParagraphStyleAttributeName];

    [aConfigurationDictionary addEntriesFromDictionary:_style];
}

- (NSParagraphStyle *)merge:(NSParagraphStyle *)sourceStyle into:(NSParagraphStyle *)destStyle
{
    // On override, nothing to do
    if (_mergingStrategy == GONMarkupSimpleMergingStrategyOverride)
        return [sourceStyle mutableCopy];

    // Merge all strategy
    NSMutableParagraphStyle *mergedStyle = [destStyle mutableCopy];

    if (MERGE_ATTRIBUTE(GONMarkupSimpleMergingStrategyMergeAlignment))              mergedStyle.alignment               = sourceStyle.alignment;
    if (MERGE_ATTRIBUTE(GONMarkupSimpleMergingStrategyMergeFirstLineHeadIndent))    mergedStyle.firstLineHeadIndent     = sourceStyle.firstLineHeadIndent;
    if (MERGE_ATTRIBUTE(GONMarkupSimpleMergingStrategyMergeHeadIndent))             mergedStyle.headIndent              = sourceStyle.headIndent;
    if (MERGE_ATTRIBUTE(GONMarkupSimpleMergingStrategyMergeTailIndent))             mergedStyle.tailIndent              = sourceStyle.tailIndent;
    if (MERGE_ATTRIBUTE(GONMarkupSimpleMergingStrategyMergeLineBreakMode))          mergedStyle.lineBreakMode           = sourceStyle.lineBreakMode;
    if (MERGE_ATTRIBUTE(GONMarkupSimpleMergingStrategyMergeMaximumLineHeight))      mergedStyle.maximumLineHeight       = sourceStyle.maximumLineHeight;
    if (MERGE_ATTRIBUTE(GONMarkupSimpleMergingStrategyMergeMinimumLineHeight))      mergedStyle.minimumLineHeight       = sourceStyle.minimumLineHeight;
    if (MERGE_ATTRIBUTE(GONMarkupSimpleMergingStrategyMergeLineSpacing))            mergedStyle.lineSpacing             = sourceStyle.lineSpacing;
    if (MERGE_ATTRIBUTE(GONMarkupSimpleMergingStrategyMergeParagraphSpacing))       mergedStyle.paragraphSpacing        = sourceStyle.paragraphSpacing;
    if (MERGE_ATTRIBUTE(GONMarkupSimpleMergingStrategyMergeParagraphSpacingBefore)) mergedStyle.paragraphSpacingBefore  = sourceStyle.paragraphSpacingBefore;
    if (MERGE_ATTRIBUTE(GONMarkupSimpleMergingStrategyMergeBaseWritingDirection))   mergedStyle.baseWritingDirection    = sourceStyle.baseWritingDirection;
    if (MERGE_ATTRIBUTE(GONMarkupSimpleMergingStrategyMergeLineHeightMultiple))     mergedStyle.lineHeightMultiple      = sourceStyle.lineHeightMultiple;
    if (MERGE_ATTRIBUTE(GONMarkupSimpleMergingStrategyMergeTabStops))               mergedStyle.tabStops                = sourceStyle.tabStops;
    if (MERGE_ATTRIBUTE(GONMarkupSimpleMergingStrategyMergeDefaultTabInterval))     mergedStyle.defaultTabInterval      = sourceStyle.defaultTabInterval;
    if (MERGE_ATTRIBUTE(GONMarkupSimpleMergingStrategyMergeHyphenationFactor))      mergedStyle.hyphenationFactor       = sourceStyle.hyphenationFactor;

    return mergedStyle;
}
@end

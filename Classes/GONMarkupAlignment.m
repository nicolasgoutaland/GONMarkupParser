//
//  GONMarkupAlignment.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 22/07/14.
//  Copyright 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupAlignment.h"

@interface GONMarkupAlignment ()
// Data
@property (nonatomic, assign) NSTextAlignment alignment;
@end

@implementation GONMarkupAlignment
#pragma mark - Markup list
+ (NSArray *)allMarkups
{
    return @[[self centerMarkup], [self leftMarkup], [self rightMarkup], [self justifiedMarkup], [self naturalMarkup]];
}

#pragma mark - Constructors
+ (instancetype)alignmentMarkup:(NSTextAlignment)alignment tag:(NSString *)atag
{
    GONMarkupAlignment *markupAlignment = [self markupForTag:atag];
    
    markupAlignment.alignment = alignment;
    
    return markupAlignment;
}

+ (instancetype)centerMarkup;
{
    return [self alignmentMarkup:NSTextAlignmentCenter tag:GONMarkupAlignment_center_TAG];
}

+ (instancetype)leftMarkup;
{
    return [self alignmentMarkup:NSTextAlignmentLeft tag:GONMarkupAlignment_left_TAG];
}

+ (instancetype)rightMarkup;
{
    return [self alignmentMarkup:NSTextAlignmentRight tag:GONMarkupAlignment_right_TAG];
}

+ (instancetype)justifiedMarkup;
{
    return [self alignmentMarkup:NSTextAlignmentJustified tag:GONMarkupAlignment_justified_TAG];
}

+ (instancetype)naturalMarkup;
{
    return [self alignmentMarkup:NSTextAlignmentNatural tag:GONMarkupAlignment_natural_TAG];
}

#pragma mark - Markup lifecycle
- (void)openingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext
{
    NSMutableParagraphStyle *style = [[aConfigurationDictionary objectForKey:NSParagraphStyleAttributeName] mutableCopy];
    if (!style)
        style = [[NSMutableParagraphStyle alloc] init];

    // Hold new configuration
    [aConfigurationDictionary setObject:style
                                 forKey:NSParagraphStyleAttributeName];

    // Update alignment
    style.alignment = _alignment;
}
@end
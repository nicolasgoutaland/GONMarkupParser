//
//  GONMarkupColor.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland All rights reserved.
//

#import "GONMarkupColor.h"
#import <NSString+Color.h>

@implementation GONMarkupColor
#pragma mark - Constructor
+ (instancetype)colorMarkup
{
    return [self markupForTag:GONMarkupColor_TAG];
}

#pragma mark - Style
- (void)openingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext attributes:(NSDictionary *)aDicAttributes
{
    UIColor *colorValue = [[aDicAttributes objectForKey:GONMarkupColor_TAG_value_ATT] representedColor];
    if (colorValue)
    {
        [aConfigurationDictionary setObject:colorValue
                                     forKey:NSForegroundColorAttributeName];
    }
}

@end

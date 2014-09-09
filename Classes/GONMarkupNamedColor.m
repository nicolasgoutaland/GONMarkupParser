//
//  GONMarkupNamedColor.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupNamedColor.h"
#import "GONMarkup+Private.h"

@interface GONMarkupNamedColor ()
// Data
@property (nonatomic, strong) UIColor *color;
@end

@implementation GONMarkupNamedColor
#pragma mark - Class constructor
+ (instancetype)namedColorMarkup:(UIColor *)aColor forTag:(NSString *)aTag
{
    GONMarkupNamedColor *markup = [self markupForTag:aTag];

    markup.color = aColor;

    return markup;
}

#pragma mark - Configuration
- (void)openingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext
{
    if (_color)
    {
        [aConfigurationDictionary setObject:_color
                                     forKey:NSForegroundColorAttributeName];
    }
    else
    {
        UIColor *defaultColor = [[self.parser defaultConfiguration] objectForKey:NSForegroundColorAttributeName];
        if (defaultColor)
        {
            [aConfigurationDictionary setObject:defaultColor
                                         forKey:NSForegroundColorAttributeName];
        }
        else
        {
            [aConfigurationDictionary removeObjectForKey:NSForegroundColorAttributeName];
        }
    }
}

@end

//
//  GONMarkupNamedFont.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupNamedFont.h"

@interface GONMarkupNamedFont ()
// Data
@property (nonatomic, strong) UIFont *font;
@end

@implementation GONMarkupNamedFont
#pragma mark - Class constructor
+ (instancetype)namedFontMarkup:(UIFont *)aFont forTag:(NSString *)aTag
{
    GONMarkupNamedFont *markup = [self markupForTag:aTag];

    markup.font = aFont;
    
    return markup;
}

#pragma mark - Configuration
- (void)openingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext
{
    if (_font)
    {
        [aConfigurationDictionary setObject:_font
                                     forKey:NSFontAttributeName];
    }
    else
    {
        [aConfigurationDictionary removeObjectForKey:NSFontAttributeName];
    }
}
@end

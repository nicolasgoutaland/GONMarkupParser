//
//  GONMarkupNamedFont.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
//  Define a tag to set font

#import "GONMarkup.h"

@interface GONMarkupNamedFont : GONMarkup
/* Class constructor */
+ (instancetype)namedFontMarkup:(UIFont *)aFont forTag:(NSString *)aTag;

@property (nonatomic, strong, readonly) UIFont *font;
@end

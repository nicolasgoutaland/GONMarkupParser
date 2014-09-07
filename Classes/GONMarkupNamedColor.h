//
//  GONMarkupNamedColor.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
//  Define a tag to set foreground text color
//  When encountered, contained text will use associated color
//

#import "GONMarkup.h"

@interface GONMarkupNamedColor : GONMarkup
/* Class constructor */
+ (instancetype)namedColorMarkup:(UIColor *)aColor forTag:(NSString *)aTag;

@property (nonatomic, strong, readonly) UIColor *color;
@end

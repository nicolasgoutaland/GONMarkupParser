//
//  UIButton+GONMarkupParser.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 23/08/15.
//  Copyright (c) 2015 Nicolas Goutaland. All rights reserved.
//
#import "GONMarkupParser.h"

@interface UIButton (GONMarkupParser)
/* Update button label with given text, considering it as a marked up string.
 * Given parser will be used to parse string
 * If parser is nil, [GONMarkupParserManager sharedParser] will be used
 */
- (void)setMarkedUpTitle:(NSString *)title forState:(UIControlState)controlState parser:(GONMarkupParser *)parser;

/* Update button with given text, considering it as a marked up string.
 * [GONMarkupParserManager sharedParser] will be used to parse string
 */
- (void)setMarkedUpTitle:(NSString *)title forState:(UIControlState)controlState;
@end

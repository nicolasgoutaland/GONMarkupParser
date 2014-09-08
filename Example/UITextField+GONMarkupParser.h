//
//  UITextField+GONMarkupParser.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 08/09/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
#import "GONMarkupParser.h"

@interface UITextField (GONMarkupParser)
/* Update textfield with given text, considering it as a marked up string.
 * Given parser will be used to parse string
 * If aParser is nil, [GONMarkupParserManager sharedParser] will be used
 */
- (void)setMarkedUpText:(NSString *)aText parser:(GONMarkupParser *)aParser;

/* Update textfield with given text, considering it as a marked up string.
 * [GONMarkupParserManager sharedParser] will be used to parse string
 */
- (void)setMarkedUpText:(NSString *)aText;

@end

//
//  UILabel+GONMarkupParser.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 08/09/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "UILabel+GONMarkupParser.h"
#import "GONMarkupParserManager.h"

@implementation UILabel (GONMarkupParser)
#pragma mark - GONMarkupParser
- (void)setMarkedUpText:(NSString *)text parser:(GONMarkupParser *)parser
{
    GONMarkupParser *selectedParser = parser;
    if (!selectedParser)
        selectedParser = [GONMarkupParserManager sharedParser];

    [self setAttributedText:[selectedParser attributedStringFromString:text
                                                                 error:nil]];
}

- (void)setMarkedUpText:(NSString *)text
{
    [self setMarkedUpText:text
                   parser:nil];
}
@end

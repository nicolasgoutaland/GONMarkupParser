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
- (void)setMarkedUpText:(NSString *)aText parser:(GONMarkupParser *)aParser
{
    GONMarkupParser *parser = aParser;
    if (!aParser)
        parser = [GONMarkupParserManager sharedParser];
    
    [self setAttributedText:[parser attributedStringFromString:aText
                                                         error:nil]];
}

- (void)setMarkedUpText:(NSString *)aText
{
    [self setMarkedUpText:aText
                   parser:nil];
}
@end

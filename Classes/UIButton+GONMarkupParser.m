//
//  UIButton+GONMarkupParser.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 23/08/15.
//  Copyright (c) 2015 Nicolas Goutaland. All rights reserved.
//

#import "UIButton+GONMarkupParser.h"
#import "GONMarkupParserUtils.h"

@implementation UIButton (GONMarkupParser)
#pragma mark - GONMarkupParser
- (void)setMarkedUpTitle:(NSString *)title forState:(UIControlState)controlState parser:(GONMarkupParser *)parser
{
    NSAttributedString *attributedText = [GONMarkupParserUtils attributedString:parser
                                                                     withString:title
                                                                    defautColor:[self titleColorForState:controlState]
                                                                    defaultFont:self.titleLabel.font
                                                               defaultAlignment:self.titleLabel.textAlignment];
    
    [self setAttributedTitle:attributedText
                    forState:controlState];
}

- (void)setMarkedUpTitle:(NSString *)title forState:(UIControlState)controlState
{
    [self setMarkedUpTitle:title
                  forState:UIControlStateNormal
                    parser:nil];
}

@end

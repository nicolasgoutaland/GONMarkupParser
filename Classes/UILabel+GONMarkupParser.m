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

    // Hold initial default configuration
    NSDictionary *defaultConfiguration = [selectedParser.defaultConfiguration copy];

    // Check if parser has default configuration for color / font. If not, use component configuration
    if (![selectedParser.defaultConfiguration objectForKey:NSForegroundColorAttributeName])
    {
        [selectedParser.defaultConfiguration setObject:self.textColor
                                                forKey:NSForegroundColorAttributeName];
    }

    if (![selectedParser.defaultConfiguration objectForKey:NSFontAttributeName])
    {
        if (self.font)
        {
            [selectedParser.defaultConfiguration setObject:self.font
                                                    forKey:NSFontAttributeName];
        }
    }

    // Affect attributed text
    [self setAttributedText:[selectedParser attributedStringFromString:text
                                                                 error:nil]];

    // Reset default configuration
    [selectedParser.defaultConfiguration removeAllObjects];
    [selectedParser.defaultConfiguration addEntriesFromDictionary:defaultConfiguration];
}

- (void)setMarkedUpText:(NSString *)text
{
    [self setMarkedUpText:text
                   parser:nil];
}
@end

//
//  GONMarkupParagrap.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 06/08/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
// Markup to handle <p>. A blank line will be inserted after the paragraph end (\n\n)

#import "GONMarkupParagrap.h"

@implementation GONMarkupParagrap
#pragma mark - Constructor
+ (instancetype)paragraphMarkup
{
    return [self markupForTag:GONMarkupParagrap_TAG];
}

#pragma mark - Content update
- (NSAttributedString *)suffixStringForContext:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes stringAttributes:(NSDictionary *)stringAttributes
{
    return [[NSAttributedString alloc] initWithString:@"\n\n" attributes:stringAttributes];
}

@end
//
//  GONMarkupParagraph.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 06/08/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
// Markup to handle <p>. A blank line will be inserted after the paragraph end (\n\n)

#import "GONMarkupParagraph.h"

@implementation GONMarkupParagraph
#pragma mark - Constructor
+ (instancetype)paragraphMarkup
{
    return [self markupForTag:GONMarkupParagraph_TAG];
}

#pragma mark - Content update
- (NSAttributedString *)prefixStringForContext:(NSMutableDictionary *)context
                                    attributes:(NSDictionary *)dicAttributes
                              stringAttributes:(NSDictionary *)stringAttributes
                                  resultString:(NSAttributedString *)resultString
{
    NSString *prefix = @"";
    
    // Check for previous newline
    if (resultString.string.length > 0)
    {
        // If last char isn't a new line, add a new line
        if (![[NSCharacterSet newlineCharacterSet] characterIsMember:[resultString.string characterAtIndex:resultString.string.length - 1]])
        {
            prefix = @"\n\n";
        } // Last char was a newline, so check if a blank line already exists before paragraph
        else if (resultString.string.length > 1 && ![[NSCharacterSet newlineCharacterSet] characterIsMember:[resultString.string characterAtIndex:resultString.string.length - 2]])
        {
            prefix = @"\n";
        }
    }
    
    return [[NSAttributedString alloc] initWithString:prefix attributes:stringAttributes];
}

@end

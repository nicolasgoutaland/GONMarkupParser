//
//  GONMarkupLineBreak.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupLineBreak.h"
#import "GONMarkupList.h"

#define NEW_LINE            @"\n"
#define CARRIAGE_RETURN     @"\u2028"

@implementation GONMarkupLineBreak
#pragma mark - Constructor
+ (instancetype)lineBreakMarkup
{
    return [self markupForTag:GONMarkupLineBreak_TAG];
}

#pragma mark - Content update
- (NSAttributedString *)updatedContentString:(NSString *)string
                                     context:(NSMutableDictionary *)context
                                  attributes:(NSDictionary *)dicAttributes
                            stringAttributes:(NSDictionary *)stringAttributes
                                resultString:(NSAttributedString *)resultString 
{
    // If in a list, no new lines
    if ([context objectForKey:GONMarkupList_CONFIGURATIONS_KEY])
        return [[NSAttributedString alloc] initWithString:CARRIAGE_RETURN attributes:stringAttributes];

    return [[NSAttributedString alloc] initWithString:NEW_LINE attributes:stringAttributes];
}

@end

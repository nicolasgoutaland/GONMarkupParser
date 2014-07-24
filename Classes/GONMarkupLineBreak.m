//
//  GONMarkupLineBreak.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupLineBreak.h"

@implementation GONMarkupLineBreak
#pragma mark - Constructor
+ (instancetype)lineBreakMarkup
{
    return [self markupForTag:GONMarkupLineBreak_TAG];
}

#pragma mark - Content update
- (NSString *)updatedContentString:(NSString *)aString context:(NSMutableDictionary *)aContext
{
    return @"\n";
}

@end

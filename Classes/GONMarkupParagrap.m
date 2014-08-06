//
//  GONMarkupParagrap.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 06/08/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupParagrap.h"

@implementation GONMarkupParagrap
#pragma mark - Constructor
+ (instancetype)paragraphMarkup
{
    return [self markupForTag:GONMarkupParagrap_TAG];
}

#pragma mark - Content update
- (NSString *)suffixStringForContext:(NSMutableDictionary *)aContext
{
    return @"\n\n";
}

@end
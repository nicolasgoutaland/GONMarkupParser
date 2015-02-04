//
//  GONMarkupLink.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 04/02/15.
//  Copyright 2015 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupLink.h"

@interface GONMarkupLink ()
@end

@implementation GONMarkupLink
#pragma mark - Constructor
+ (instancetype)linkMarkup
{
    return [self markupForTag:GONMarkupLink_TAG];
}

#pragma mark - Style
- (void)openingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    NSString *value = [dicAttributes objectForKey:GONMarkupLink_TAG_value_ATT];
    if (value)
    {
        NSTextAttachment *attachment = [[NSTextAttachment alloc] initWithData:[[value stringByRemovingPercentEncoding] dataUsingEncoding:NSUTF8StringEncoding] ofType:nil];

        [configurationDictionary setObject:attachment
                                    forKey:NSLinkAttributeName];
    }
}

@end
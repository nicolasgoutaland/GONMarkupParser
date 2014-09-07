//
//  GONMarkupReset.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupReset.h"
#import "GONMarkup+Private.h"

@implementation GONMarkupReset
#pragma mark - Constructor
+ (instancetype)resetMarkup
{
    return [self markupForTag:GONMarkupReset_TAG];
}

#pragma mark - Style
- (void)openingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext attributes:(NSDictionary *)aDicAttributes
{
    // Reset configuration
    [aConfigurationDictionary removeAllObjects];

    // Set it back to default if allowed
    if (![[aDicAttributes objectForKey:GONMarkupReset_TAG_all_ATT] boolValue])
        [aConfigurationDictionary addEntriesFromDictionary:self.parser.defaultConfiguration];

    // Copy current context
    NSMutableDictionary *contextCopy = [aContext mutableCopy];

    // Reset it
    [aContext removeAllObjects];

    // Hold saved context
    [aContext setObject:contextCopy
                 forKey:GONMarkupReset_SAVED_CONTEXT_KEY];
}

- (void)closingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext attributes:(NSDictionary *)aDicAttributes
{
    // Copy current context
    NSMutableDictionary *savedContext = [aContext objectForKey:GONMarkupReset_SAVED_CONTEXT_KEY];

    // Reset context
    [aContext removeAllObjects];

    // Reset current context to previously saved one
    [aContext addEntriesFromDictionary:savedContext];
}
@end

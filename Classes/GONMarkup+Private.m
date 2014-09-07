//
//  GONMarkup+Private.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkup+Private.h"

@implementation GONMarkup (Private)
#pragma mark - LIFO shared context management
- (void)pushConfiguration:(id)aConfiguration toContext:(NSMutableDictionary *)aContext forKey:(NSString *)aKey
{
    // Retrieve FIFO
    NSMutableArray *configurationsFIFO = [aContext objectForKey:aKey];
    if (!configurationsFIFO)
    {
        // Create FIFO
        configurationsFIFO = [[NSMutableArray alloc] init];
        [aContext setObject:configurationsFIFO
                     forKey:aKey];
    }

    // Hold current configuration
    [configurationsFIFO addObject:aConfiguration];
}

- (id)currentContextConfiguration:(NSString *)aKey fromContext:(NSMutableDictionary *)aContext
{
    return [[aContext objectForKey:aKey] lastObject];
}

- (id)popContextConfiguration:(NSString *)aKey fromContext:(NSMutableDictionary *)aContext
{
    // Retrieve FIFO
    NSMutableArray *configurationsFIFO = [aContext objectForKey:aKey];

    // Retrieve current configuration
    id currentConfiguration = [configurationsFIFO lastObject];

    // Remove last configuration
    [configurationsFIFO removeLastObject];

    // Check if list is empty
    if (!configurationsFIFO.count)
    {
        // Remove empty list
        [aContext removeObjectForKey:aKey];
    }

    return currentConfiguration;
}

@dynamic parser;
@end
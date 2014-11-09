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
- (void)pushConfiguration:(id)configuration toContext:(NSMutableDictionary *)context forKey:(NSString *)key
{
    // Retrieve FIFO
    NSMutableArray *configurationsFIFO = [context objectForKey:key];
    if (!configurationsFIFO)
    {
        // Create FIFO
        configurationsFIFO = [[NSMutableArray alloc] init];
        [context setObject:configurationsFIFO
                    forKey:key];
    }

    // Hold current configuration
    [configurationsFIFO addObject:configuration];
}

- (id)currentContextConfiguration:(NSString *)key fromContext:(NSMutableDictionary *)context
{
    return [[context objectForKey:key] lastObject];
}

- (id)popContextConfiguration:(NSString *)key fromContext:(NSMutableDictionary *)context
{
    // Retrieve FIFO
    NSMutableArray *configurationsFIFO = [context objectForKey:key];

    // Retrieve current configuration
    id currentConfiguration = [configurationsFIFO lastObject];

    // Remove last configuration
    [configurationsFIFO removeLastObject];

    // Check if list is empty
    if (!configurationsFIFO.count)
    {
        // Remove empty list
        [context removeObjectForKey:key];
    }

    return currentConfiguration;
}

@dynamic parser;
@end
//
//  GONMarkupFont.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland All rights reserved.
//

#import "GONMarkupFont.h"
#import "GONMarkup+Private.h"

@interface GONMarkupFont ()

@end

@implementation GONMarkupFont
#pragma mark - Constructor
+ (instancetype)fontMarkup
{
    return [self markupForTag:GONMarkupFont_TAG];
}

#pragma mark - Style
- (void)openingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext attributes:(NSDictionary *)aDicAttributes
{
    NSString *value;

    // Font code
    value = [aDicAttributes objectForKey:GONMarkupFont_TAG_code_ATT];
    if (value)
    {
        // Retrieve font
        UIFont *font = [self.parser fontForKey:value];

        // Look for size attribute
        NSString *sizeValue = [aDicAttributes objectForKey:GONMarkupFont_TAG_size_ATT];
        if (sizeValue)
            font = [UIFont fontWithDescriptor:font.fontDescriptor size:[sizeValue floatValue]];

        // Update configuration
        [aConfigurationDictionary setObject:font
                                     forKey:NSFontAttributeName];

        return;
    }

    // Font name
    value = [aDicAttributes objectForKey:GONMarkupFont_TAG_name_ATT];
    if (value)
    {
        // Look for size attribute
        CGFloat size;
        NSString *sizeValue = [aDicAttributes objectForKey:GONMarkupFont_TAG_size_ATT];
        if (sizeValue)
        {
            size = [sizeValue floatValue];
        }
        else
        {
            UIFont *currentFont = [aConfigurationDictionary objectForKey:NSFontAttributeName];
            if (currentFont)
                size = currentFont.pointSize;
            else
                size = [UIFont systemFontSize];
        }

        // Try to load font from registered ones
        UIFont *font = [self.parser fontForKey:value];
        if (!font)
        {
            // No matching font found, try to load it by name
            font = [UIFont fontWithName:value size:size];
        }
        else
        {
            // Font found, update its size
            font = [UIFont fontWithDescriptor:font.fontDescriptor size:[sizeValue floatValue]];
        }

        // Update configuration
        [aConfigurationDictionary setObject:font
                                     forKey:NSFontAttributeName];

        return;
    }

    // Font size only
    value = [aDicAttributes objectForKey:GONMarkupFont_TAG_size_ATT];
    if (value)
    {
        // Extract size
        CGFloat size = [value floatValue];

        // Look for current font
        UIFont *currentFont = [aConfigurationDictionary objectForKey:NSFontAttributeName];
        if (currentFont)
        {
            // Current font found, so update it with new size
            currentFont = [UIFont fontWithDescriptor:currentFont.fontDescriptor
                                                size:size];
        }
        else
        {
            // No found defined, use default one with defined size
            currentFont = [UIFont systemFontOfSize:size];
        }

        // Update configuration
        [aConfigurationDictionary setObject:currentFont
                                     forKey:NSFontAttributeName];

        return;
    }

    // Empty font parameter, reset configuration
    [aConfigurationDictionary removeObjectForKey:NSFontAttributeName];
}

@end
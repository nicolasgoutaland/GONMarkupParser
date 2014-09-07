//
//  GONAttributedMarkup.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland All rights reserved.
//

#import "GONAttributedMarkup.h"
#import "GONMarkup+Private.h"

@interface GONAttributedMarkup ()
@end

@implementation GONAttributedMarkup
#pragma mark - Attributes
- (void)openingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext
{
    // Extract attributes
    NSDictionary *attributes = [self extractAttributesFromTag:aTag];

    [self pushConfiguration:attributes
                  toContext:aContext
                     forKey:GONAttributedMarkup_CONFIGURATIONS_KEY];

    // Transfer event configuration
    [self openingMarkupFound:aTag
               configuration:aConfigurationDictionary
                     context:aContext
                  attributes:attributes];
}

- (void)closingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext
{
    [self closingMarkupFound:aTag
               configuration:aConfigurationDictionary
                     context:aContext
                  attributes:[self popContextConfiguration:GONAttributedMarkup_CONFIGURATIONS_KEY
                                               fromContext:aContext]];
}

#pragma mark - Utils
- (NSDictionary *)extractAttributesFromTag:(NSString *)aTag
{
    NSMutableDictionary *dicAttributes = [[NSMutableDictionary alloc] init];
    
    // Split string
    NSArray *attributes = [aTag componentsSeparatedByString:@" "];
    NSArray *valueComponents;
    NSString *attributeKey;
    NSMutableString *attributeValue;
    
    // Skip first attribute, that is tag
    for (NSInteger i=1; i<attributes.count; i++)
    {
        // Split value
        valueComponents = [[attributes objectAtIndex:i] componentsSeparatedByString:@"="];
        
        // Check if parameter was valid
        if (valueComponents.count == 2)
        {
            // Extract string
            attributeKey    = [valueComponents firstObject];
            attributeValue  = [[valueComponents lastObject] mutableCopy];
            
            // Unescape value
            [attributeValue replaceOccurrencesOfString:@"\\\"" withString:@"\"" options:0 range:NSMakeRange(0, attributeValue.length)];
            
            // Remove surrounding double quotes
            [attributeValue deleteCharactersInRange:NSMakeRange(0, 1)];
            [attributeValue deleteCharactersInRange:NSMakeRange(attributeValue.length - 1, 1)];
            
            // Store value
            [dicAttributes setObject:attributeValue
                              forKey:attributeKey];
        }
    }

    // Hold attributes for reuse
    return dicAttributes;
}

#pragma mark - Behavior
- (NSString *)updatedContentString:(NSString *)aString context:(NSMutableDictionary *)aContext attributes:(NSDictionary *)aDicAttributes { return aString; }
- (void)closingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext attributes:(NSDictionary *)aDicAttributes {}
- (void)openingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext attributes:(NSDictionary *)aDicAttributes {}

@end

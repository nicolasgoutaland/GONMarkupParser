//
//  GONAttributedMarkupBlock.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONAttributedMarkupBlock.h"

@implementation GONAttributedMarkupBlock
#pragma mark - Constructor
+ (instancetype)attributedBlockMarkup:(NSString *)aTag
{
    return [self markupForTag:aTag];
}

#pragma mark - Configuration
- (void)openingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext attributes:(NSDictionary *)aDicAttributes
{
    if (_openingMarkupBlock)
        _openingMarkupBlock(aConfigurationDictionary, aTag, aContext, aDicAttributes);
}

- (void)closingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext attributes:(NSDictionary *)aDicAttributes
{
    if (_closingMarkupBlock)
        _closingMarkupBlock(aConfigurationDictionary, aTag, aContext, aDicAttributes);
}

- (NSString *)updatedContentString:(NSString *)aString context:(NSMutableDictionary *)aContext attributes:(NSDictionary *)aDicAttributes
{
    if (_updatedContentString)
        return _updatedContentString(aString, aContext, aDicAttributes);

    return [super updatedContentString:aString context:aContext attributes:aDicAttributes];
}
@end

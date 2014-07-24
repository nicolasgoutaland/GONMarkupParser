//
//  GONMarkupBlock.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupBlock.h"

@implementation GONMarkupBlock
#pragma mark - Constructor
+ (instancetype)blockMarkup:(NSString *)aTag
{
    return [self markupForTag:aTag];
}

#pragma mark - Configuration
- (void)openingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext
{
    if (_openingMarkupBlock)
        _openingMarkupBlock(aConfigurationDictionary, aTag, aContext);
}

- (void)closingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext
{
    if (_closingMarkupBlock)
        _closingMarkupBlock(aConfigurationDictionary, aTag, aContext);
}

- (NSString *)updatedContentString:(NSString *)aString context:(NSMutableDictionary *)aContext
{
    if (_updatedContentString)
        return _updatedContentString(aString, aContext);

    return [super updatedContentString:aString context:aContext];
}
@end

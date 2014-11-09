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
+ (instancetype)blockMarkup:(NSString *)tag
{
    return [self markupForTag:tag];
}

#pragma mark - Configuration
- (void)openingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context
{
    if (_openingMarkupBlock)
        _openingMarkupBlock(configurationDictionary, tag, context);
}

- (void)closingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context
{
    if (_closingMarkupBlock)
        _closingMarkupBlock(configurationDictionary, tag, context);
}

- (NSString *)updatedContentString:(NSString *)string context:(NSMutableDictionary *)context
{
    if (_updatedContentString)
        return _updatedContentString(string, context);

    return [super updatedContentString:string context:context];
}
@end

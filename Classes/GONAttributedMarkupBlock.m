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
+ (instancetype)attributedBlockMarkup:(NSString *)tag
{
    return [self markupForTag:tag];
}

#pragma mark - Configuration
- (void)openingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    if (_openingMarkupBlock)
        _openingMarkupBlock(configurationDictionary, tag, context, dicAttributes);
}

- (void)closingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    if (_closingMarkupBlock)
        _closingMarkupBlock(configurationDictionary, tag, context, dicAttributes);
}

- (NSString *)updatedContentString:(NSString *)string context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes
{
    if (_updatedContentString)
        return _updatedContentString(string, context, dicAttributes);

    return [super updatedContentString:string context:context attributes:dicAttributes];
}
@end

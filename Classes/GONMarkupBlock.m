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

- (NSAttributedString *)updatedContentString:(NSString *)string context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes stringAttributes:(NSDictionary *)stringAttributes
{
    if (_updatedContentStringBlock)
        return _updatedContentStringBlock(string, context, dicAttributes, stringAttributes);

    return [super updatedContentString:string context:context attributes:dicAttributes stringAttributes:stringAttributes];
}

- (NSAttributedString *)prefixStringForContext:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes stringAttributes:(NSDictionary *)stringAttributes
{
    if (_prefixStringForContextBlock)
        return _prefixStringForContextBlock(context, dicAttributes, stringAttributes);

    return [super prefixStringForContext:context attributes:dicAttributes stringAttributes:stringAttributes];
}

- (NSAttributedString *)suffixStringForContext:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes stringAttributes:(NSDictionary *)stringAttributes
{
    if (_suffixStringForContextBlock)
        return _suffixStringForContextBlock(context, dicAttributes, stringAttributes);

    return [super suffixStringForContext:context attributes:dicAttributes stringAttributes:stringAttributes];
}
@end

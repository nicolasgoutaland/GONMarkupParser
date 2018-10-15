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
- (void)openingMarkupFound:(NSString *)tag
             configuration:(NSMutableDictionary *)configurationDictionary
                   context:(NSMutableDictionary *)context
                attributes:(NSDictionary *)dicAttributes
              resultString:(NSAttributedString *)resultString
{
    if (_openingMarkupBlock)
        _openingMarkupBlock(configurationDictionary, tag, context, dicAttributes, resultString);
}

- (void)closingMarkupFound:(NSString *)tag
             configuration:(NSMutableDictionary *)configurationDictionary
                   context:(NSMutableDictionary *)context
                attributes:(NSDictionary *)dicAttributes
              resultString:(NSAttributedString *)resultString
{
    if (_closingMarkupBlock)
        _closingMarkupBlock(configurationDictionary, tag, context, dicAttributes, resultString);
}

- (NSAttributedString *)updatedContentString:(NSString *)string
                                     context:(NSMutableDictionary *)context
                                  attributes:(NSDictionary *)dicAttributes
                            stringAttributes:(NSDictionary *)stringAttributes
                                resultString:(NSAttributedString *)resultString
{
    if (_updatedContentStringBlock)
        return _updatedContentStringBlock(string, context, dicAttributes, stringAttributes, resultString);

    return [super updatedContentString:string
                               context:context
                            attributes:dicAttributes
                      stringAttributes:stringAttributes
                          resultString:resultString];
}

- (NSAttributedString *)prefixStringForContext:(NSMutableDictionary *)context
                                    attributes:(NSDictionary *)dicAttributes
                              stringAttributes:(NSDictionary *)stringAttributes
                                  resultString:(NSAttributedString *)resultString
{
    if (_prefixStringForContextBlock)
        return _prefixStringForContextBlock(context, dicAttributes, stringAttributes, resultString);

    return [super prefixStringForContext:context
                              attributes:dicAttributes
                        stringAttributes:stringAttributes
                            resultString:resultString];
}

- (NSAttributedString *)suffixStringForContext:(NSMutableDictionary *)context
                                    attributes:(NSDictionary *)dicAttributes
                              stringAttributes:(NSDictionary *)stringAttributes
                                  resultString:(NSAttributedString *)resultString
{
    if (_suffixStringForContextBlock)
        return _suffixStringForContextBlock(context, dicAttributes, stringAttributes, resultString);

    return [super suffixStringForContext:context
                              attributes:dicAttributes
                        stringAttributes:stringAttributes
                            resultString:resultString];
}
@end

//
//  GONMarkupBlock.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
// Markup using a block as parameters. Useful to add new markup without creating new subclasses


#import "GONMarkup.h"

@interface GONMarkupBlock : GONMarkup
/* Class contructor
 */
+ (instancetype)blockMarkup:(NSString *)tag;

@property (nonatomic, copy) void(^openingMarkupBlock)(NSMutableDictionary *configurationDictionary, NSString *tag, NSMutableDictionary *context);    // Called when opening tag is found
@property (nonatomic, copy) NSString *(^updatedContentString)(NSString *string, NSMutableDictionary *context);                                        // Called when extracted string is complete
@property (nonatomic, copy) void(^closingMarkupBlock)(NSMutableDictionary *configurationDictionary, NSString *tag, NSMutableDictionary *context);    // Called when closing tag is found
@end

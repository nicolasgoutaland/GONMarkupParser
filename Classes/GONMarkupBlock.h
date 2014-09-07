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
+ (instancetype)blockMarkup:(NSString *)aTag;

@property (nonatomic, copy) void(^openingMarkupBlock)(NSMutableDictionary *aConfigurationDictionary, NSString *aTag, NSMutableDictionary *aContext);    // Called when opening tag is found
@property (nonatomic, copy) NSString *(^updatedContentString)(NSString *aString, NSMutableDictionary *aContext);                                        // Called when extracted string is complete
@property (nonatomic, copy) void(^closingMarkupBlock)(NSMutableDictionary *aConfigurationDictionary, NSString *aTag, NSMutableDictionary *aContext);    // Called when closing tag is found
@end

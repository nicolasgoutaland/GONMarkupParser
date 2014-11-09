//
//  GONAttributedMarkupBlock.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
// AttributedMarkup using a block as parameter. Usuful to add new markup without creating new classes

#import "GONAttributedMarkup.h"

@interface GONAttributedMarkupBlock : GONAttributedMarkup

/* Class contructor
 * Given block will be executed once tag is detected.
 */
+ (instancetype)attributedBlockMarkup:(NSString *)tag;

@property (nonatomic, copy) void(^openingMarkupBlock)(NSMutableDictionary *configurationDictionary, NSString *tag, NSMutableDictionary *context, NSDictionary *dicAttributes);  // Called when opening tag is found
@property (nonatomic, copy) NSString *(^updatedContentString)(NSString *string, NSMutableDictionary *context, NSDictionary *dicAttributes);                                      // Called when extracted string is complete
@property (nonatomic, copy) void(^closingMarkupBlock)(NSMutableDictionary *configurationDictionary, NSString *tag, NSMutableDictionary *context, NSDictionary *dicAttributes);  // Called when closing tag is found
@end

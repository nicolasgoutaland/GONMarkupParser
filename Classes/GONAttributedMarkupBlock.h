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
+ (instancetype)attributedBlockMarkup:(NSString *)aTag;

@property (nonatomic, copy) void(^openingMarkupBlock)(NSMutableDictionary *aConfigurationDictionary, NSString *aTag, NSMutableDictionary *aContext, NSDictionary *aDicAttributes);  // Called when opening tag is found
@property (nonatomic, copy) NSString *(^updatedContentString)(NSString *aString, NSMutableDictionary *aContext, NSDictionary *aDicAttributes);                                      // Called when extracted string is complete
@property (nonatomic, copy) void(^closingMarkupBlock)(NSMutableDictionary *aConfigurationDictionary, NSString *aTag, NSMutableDictionary *aContext, NSDictionary *aDicAttributes);  // Called when closing tag is found
@end

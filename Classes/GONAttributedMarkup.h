//
//  GONAttributedMarkup.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland All rights reserved.
//
//  Subclass for Markup, but handling ( markups
//  This class will automatically extract attributes from given tag
//  Tags should be space separated, values affected using equal sign, and between double quotes. To escape double quotes, use \
//
//  Example :
//  Tag                     | Supported
//  -----------------------------------
//  <color value="red">     | YES
//  <color value = "red">   | YES
//  <color value = red>     | NO
//  <color value = "re"d">  | NO
//  <color value = "re\"d"> | YES
//
//  When subclassing, override openingMarkupFound:configuration:fromTag:attributes: instead of openingMarkupFound:configuration:fromTag:
//  When subclassing, override closingMarkupFound:configuration:fromTag:attributes: instead of closingMarkupFound:configuration:fromTag:
//

#import "GONMarkup.h"

// Context
#define GONAttributedMarkup_CONFIGURATIONS_KEY  @"GONAttributedMarkup.configurations"  // Cached attributes in context

@interface GONAttributedMarkup : GONMarkup
/* This method will be called if markup is matching current opening tag.
 * Object is responsible to update attributed string parameters in "configurationDictionary"
 *
 * "tag" is matching tag, allowing you to extract parameters
 * "dicAttributes" contains all extracted parameters
 * "context" is a mutable dictionary use by marker to add contextual information. This dictioanry is shared throught all markers in a parser and is reset each time a new parse is started
 * It is used for example by list markers to handle list type, tabulation index and count
 *
 * You should override this method to implement new behavior
 */
- (void)openingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes;

/* This method will be called once current marker tag is closed
 * This allows marker to update string content
 * "dicAttributes" contains all previously extracted parameters
 * "context" is the same as in openingMarkupFound:configuration:fromTag:context:attributes:
 *
 * Default implementation return input string
 */
- (NSString *)updatedContentString:(NSString *)string context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes;

/* Allows marker to prefix its content string
 * This method is called right after opening markup
 */
- (NSString *)prefixStringForContext:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes;

/* Allows marker to suffix its content string
 * This method is called right after opening markup
 */
- (NSString *)suffixStringForContext:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes;

/* This method will be called if markup is matching current closing tag.
 * Object is responsible to update attributed string parameters in "configurationDictionary"
 *
 * "tag" is matching tag, allowing you to extract parameters
 * "dicAttributes" contains all previously extracted parameters
 * "context" is a mutable dictionary use by marker to add contextual information. This dictionary is shared throught all markers in a parser and is reset each time a new parse is started
 * It is used for example by list markers to handle list type, tabulation index and count
 *
 * You should override this method to implement new behavior
 */
- (void)closingMarkupFound:(NSString *)tag configuration:(NSMutableDictionary *)configurationDictionary context:(NSMutableDictionary *)context attributes:(NSDictionary *)dicAttributes;

@end

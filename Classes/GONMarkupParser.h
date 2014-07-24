//
//  GONMarkupParser.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland All rights reserved.
//
// A simple string parser, allowing string manipulation, usually used to parse HTML like string.
// You have to define your own rules and ensure that tags are wellformed
//
// To close a tag, you do not have to specity its name, </> is valid
// <//> is also valid to close all previoulsy opened tags
//
// This class also provide a shared instance you can user throught you whole project
//
// This class is not thread safe, so be careful when using sharedInstance in multiple threads
//
#import "GONMarkup.h"

#warning Evolutions : Allow markup to be encoded (NSCoding)
#warning Evolutions : Loading from PLIST file

#define GONMarkupParser_ERROR_DOMAIN                   @"error.markupParser"
#define GONMarkupParser_StringMalformed_ERROR_CODE     69
#define GONMarkupParser_incorrectClosingTag_KEY        @"incorrectClosingTag"

@interface GONMarkupParser : NSObject
/* Return shared instance.
 * Shared instance is preconfigured to handle all default tags
 */
+ (instancetype)sharedInstance;

/* Instanciate a new markup parser, configured to handle all default tags */
+ (instancetype)defaultMarkupParser;

/* Instanciate a new empty markup parser. This parser won't have any configured tag 
 * Same as [[GONMarkupParser alloc] init]
 */
+ (instancetype)emptyMarkupParser;

/* Add a new markup to parser
 * A markup can be used in only one parser at a time
 * If you are trying to a markup already used by another parser, an exception willl be thrown
 */
- (void)addMarkup:(GONMarkup *)aMarkup;

/* Add some markups */
- (void)addMarkups:(id <NSFastEnumeration>)markups;

/* Remove given markup from parser, if previously added */
- (void)removeMarkup:(GONMarkup *)aMarkup;

/* Remove given markups from parser, if previously added */
- (void)removeMarkups:(id <NSFastEnumeration>)markups;

/* Remove all currently applied markups */
- (void)removeAllMarkups;

// Fonts management
/* Register given font */
- (void)registerFont:(UIFont *)aFont forKey:(NSString *)aKey;

/* Register given font */
- (UIFont *)fontForKey:(NSString *)aKey;

/* Register given font */
- (void)unregisterFontForKey:(NSString *)aKey;

/* Convert given string to an attributed string.
 * String will be parsed and updated according to stored markups
 * If nil is passed as parameter, an empty string will be returned
 *
 * anError may be set if input string seems malformed, but method will return a valid string. Only last error is returned.
 */
- (NSMutableAttributedString *)attributedStringFromString:(NSString *)aString error:(NSError **)anError;

@property (nonatomic, strong, readonly) NSMutableDictionary *defaultConfiguration;                              // Default attributed string configuration
@property (nonatomic, readonly)         NSArray *markups;                                                       // Retrieve all applied markups
@property (nonatomic, readonly)         NSDictionary *registeredFonts;                                          // Retrieve all applied markups
@property (nonatomic, copy)             void (^preProcessingBlock)(NSMutableString *inputString);               // Block automatically called to preprocess input string
@property (nonatomic, copy)             void (^postProcessingBlock)(NSMutableAttributedString *inputString);    // Block automatically called to postprocess result attributed string
@property (nonatomic, assign)           BOOL debugEnabled;                                                      // Enable debug output
@end

//
//  GONMarkup+Private.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkup.h"
#import "GONMarkupParser.h"

@interface GONMarkup (Private)
// Shared context configuration LIFO management
// These methods can be used to shared data between markers throught shared context.
/* Push a new configuration to shared context, under given key */
- (void)pushConfiguration:(id)aConfiguration toContext:(NSMutableDictionary *)aContext forKey:(NSString *)aKey;

/* Return current available configuration in shared context for given key
 * May return nil if there is no configuration
 */
- (id)currentContextConfiguration:(NSString *)aKey fromContext:(NSMutableDictionary *)aContext;

/* Pop current configuration from shared context, and return it.
 * May return nil if there is no configuration */
- (id)popContextConfiguration:(NSString *)aKey fromContext:(NSMutableDictionary *)aContext;

@property (nonatomic, weak) GONMarkupParser *parser;
@end

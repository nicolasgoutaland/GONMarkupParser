//
//  GONMarkupParserUtils.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 08/08/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
//  Utils
//  Why not using some categories Sir ? Because I'm pretty sure everyone already have a cleanHTMLEntities method on their strings,
//  and I don't want to conflict with existing methods, nor adding a pod dependency that will add tons of new methods

@interface GONMarkupParserUtils : NSObject
/* Clean HTML entities from string */
+ (void)cleanHTMLEntitiesFromString:(NSMutableString *)inputString;

@end

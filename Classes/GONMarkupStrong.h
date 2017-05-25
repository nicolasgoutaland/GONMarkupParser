//
//  GONMarkupStrong.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/05/2017.
//  Copyright 2017 Nicolas Goutaland. All rights reserved.
//
//  Same as b tag.
//  Subclassing b allowing users to override strong markup behavior
//
//  Examples
//
//  <strong>bold text</>

#import "GONMarkupBold.h"

#define GONMarkupStrong_TAG                 @"strong"

@interface GONMarkupStrong : GONMarkupBold
/* Default markup to add strong support */
+ (instancetype)strongMarkup;

@end

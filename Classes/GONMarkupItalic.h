//
//  GONMarkupItalic.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 19/09/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
//  Tag updating current font style to italic
//  This tag may not work if no italic version of current font is available.
//  You can provide a fallback block in order to provide another font if italic version is not found.
//  This block will be called only if no matching font is found.
//
//  Examples
//
// <i>italic text</>

#import "GONMarkup.h"

#define GONMarkupItalic_TAG               @"i"

@interface GONMarkupItalic : GONMarkup

/* Default markup to add italic support */
+ (instancetype)italicMarkup;

@property (nonatomic, copy) UIFont *(^italicFontFallbackBlock)(UIFont *font);
@end

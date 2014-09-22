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

#import "GONMarkupFontTraits.h"

#define GONMarkupItalic_TAG               @"i"

@interface GONMarkupItalic : GONMarkupFontTraits

/* Default markup to add italic support */
+ (instancetype)italicMarkup;
@end

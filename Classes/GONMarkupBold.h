//
//  GONMarkupBold.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 19/09/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//
//  Tag updating current font style to bold
//  This tag may not work if no bold version of current font is available.
//  You can provide a fallback block in order to provide another font if bold version is not found.
//  This block will be called only if no matching font is found.
//
//  Examples
//
// <b>bold text</>

#import "GONMarkupFontTraits.h"

#define GONMarkupBold_TAG                 @"b"

@interface GONMarkupBold : GONMarkupFontTraits

/* Default markup to add bold support */
+ (instancetype)boldMarkup;
@end

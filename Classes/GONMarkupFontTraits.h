//
//  GONMarkupFontTraits.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 22/09/14.
//  Copyright 2014 Nicolas Goutaland. All rights reserved.
//
//  Super class for markers updating font traits
//  fallbackBlock will be used to determine which font to use ONLY if system cannot find it automatically
//
// You may not need to use this class directly. Use subclasses instead (GONMarkupBold, GONMarkupItalic)

#import "GONMarkup.h"

@interface GONMarkupFontTraits : GONMarkup {
}

/* Class constructor */
+ (instancetype)fontTraitsMarkup:(NSString *)aTag traits:(UIFontDescriptorSymbolicTraits )aTraits;

@property (nonatomic, copy) UIFont *(^fallbackBlock)(UIFont *font);             // Should return a font. Markup will automatically update font to needed size.
@property (nonatomic, assign, readonly) UIFontDescriptorSymbolicTraits traits;
@end

//
//  GONMarkupFont.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland All rights reserved.
//
//  Define a generic markup to configure font
//  "size" is used to define font size
//      If missing, current font size will be used. If not found is set, default system font size will be used
//  "name" define a full font name
//  "registeredName" define a registered font name
//      If nor "name" or "registeredName" are set, current defined font will be used with new defined size. If no font is currently used, default system one will be used
//      If "name" and "registeredName" are specified, “registeredName" will be used
//
//  If no attribute is set, current defined font will be removed (NSFontAttributeName), and default system one will be used instead

#import "GONAttributedMarkup.h"

// Tag
#define GONMarkupFont_TAG                 @"font"

// Attributes
#define GONMarkupFont_TAG_size_ATT       @"size"                // Is missing
#define GONMarkupFont_TAG_name_ATT       @"name"                // Full font name, including style
#define GONMarkupFont_TAG_code_ATT       @"registeredName"      // Registered font name, as specified when registering it in parser

@interface GONMarkupFont : GONAttributedMarkup
/* Default markup to add font support */
+ (instancetype)fontMarkup;

@end

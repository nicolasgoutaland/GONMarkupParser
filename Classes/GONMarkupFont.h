//
//  GONMarkupFont.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland All rights reserved.
//
//  Define a generic markup to configure font
//  "color" is used to change text color
//       Colors are handled via NSString+Color, using "representedColor" category method
//       Have a look at https://github.com/nicolasgoutaland/NSString-Color for more information
//  "size" is used to define font size
//      If missing, current font size will be used. If not found is set, default system font size will be used
//  "name" define a registered font name or full font name
//      - Markup will first try to find a registeredFont with given name.
//      - If no font found, markup will try to load a font using given name
//  If "name" isn't set, current defined font will be used with new defined size. If no font is currently used, default system one will be used
//
//  If no attribute is set, current defined font will be removed (NSFontAttributeName), and default system one will be used instead
//
//  Examples
//
//  <font size="18">This text will use current font, set to 18</>
//  <font name="Helvetica">This text will use Helvetica as font, using current font size</>
//  <font name="Helvetica" size="18">This text will use Helvetica, set to 18</>
//  <font name="Helvetica" size="18" color="red">This text will use Helvetica, set to 18, in red</>

#import "GONMarkup.h"

// Tag
#define GONMarkupFont_TAG                @"font"

// Attributes
#define GONMarkupFont_TAG_size_ATT       @"size"                // Font size. If missing, will use default font size, or one previously set on stack
#define GONMarkupFont_TAG_color_ATT      @"color"               // Text color
#define GONMarkupFont_TAG_name_ATT       @"name"                // Full font name, including style

@interface GONMarkupFont : GONMarkup
/* Default markup to add font support */
+ (instancetype)fontMarkup;

@end

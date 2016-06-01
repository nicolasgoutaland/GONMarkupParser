//
//  GONMarkupImage.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 04/03/16.
//  Copyright © 2016 Nicolas Goutaland. All rights reserved.
//
//
//  Define a generic markup to add images
//  You can specify image path with "value" attribute.
//
//  Examples
//
//  <image src="image.png"/>
//  <image src="#FFEEAA"/>
//  <image src="myCustomRegisteredColor"/>

#import "GONMarkup.h"

// Tag
#define GONMarkupImage_TAG                 @"image"

// Attributes
#define GONMarkupImage_TAG_value_ATT       @"src"

@interface GONMarkupImage : GONMarkup
/* Default markup to add image support */
+ (instancetype)imageMarkup;
@end

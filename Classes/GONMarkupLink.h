//
//  GONMarkupLink.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 04/02/15.
//  Copyright 2015 Nicolas Goutaland. All rights reserved.
//
//  Define a markup to add link support
//  You can specify link value with "value" attribute.
//
//  To detect user touch on link :
//  - display attributed string in a UITextView
//  - configure UITextView selectable property to YES and isEditable to NO
//  - set delegate
//  - implement "textView:shouldInteractWithTextAttachment:inRange:" method
//
//  Examples
//
//  <link value="#1">Link 1</>
//  <link value="http://www.apple.com">Link to apple.com</>
//  <link value="myscheme://myapp">Custom link</>

#import "GONMarkup.h"

// Tag
#define GONMarkupLink_TAG                 @"link"

// Attributes
#define GONMarkupLink_TAG_value_ATT       @"value"

@interface GONMarkupLink : GONMarkup
/* Default markup to add link support */
+ (instancetype)linkMarkup;
@end

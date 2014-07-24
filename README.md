#GONMarkupParser

WIP - A simple markup parser for iOS.

##Description

// Default markup

##Usage
- instantiate a new __GONMarkupParser__ or use the __sharedInstance__ one.
- configure your parser adding supporting tags, default ones, custom ones, etc...
- parser input string and retrieve result __NSMutableAttributedString__ using __attributedStringFromString__

##Installation
__Cocoapods__: `pod 'GONMarkupParser'`<br> // Not available yet
__Manual__: Copy the __Classes__ folder in your project<br>

Import wanted headers in your project. .pch is a good place ;)
You can also import GONMarkupDefaultMarkups.h to reference all markups in your project.

##How to add new tags

##Versions
1.0   : Initial release<br/>

#import "GONAttributedMarkupBlock.h"
#import "GONMarkupBlock.h"
#import "GONMarkupColor.h"
#import "GONMarkupFont.h"
#import "GONMarkupLineBreak.h"
#import "GONMarkupList.h"
#import "GONMarkupListItem.h"
#import "GONMarkupNamedColor.h"
#import "GONMarkupNamedFont.h"
#import "GONMarkupReset.h"


Closing a markup </>, <tag/> 
<//> ==> close all opened markup

Extending :
Register fonts
Special blocks :

Example ==> tokenizer ?
==> Faire un pretraitement pour ajouter les balises

#GONMarkupParser

WIP - A simple markup parser for iOS.

##Description

// Default markup

##Usage
- instantiate a new __GONMarkupParser__ or use the  __+ GONMarkupParserManager sharedParser__ one.
- configure your parser adding supporting tags, default ones, custom ones, etc...
- parser input string and retrieve result __NSMutableAttributedString__ using __attributedStringFromString__

##Installation
__Cocoapods__: `pod 'GONMarkupParser'`<br> // Not available yet
__Manual__: Copy the __Classes__ folder in your project<br>

Import wanted headers in your project. .pch is a good place ;)
You can also import GONMarkupDefaultMarkups.h to reference all markups in your project.

##Example


##Parser
GONMarkupParser
- constructoors
- configuration
- registered fonts
- pre / post processing block
- replaceNewLineCharactersFromInputString
- replaceHTMLCharactersFromOutputString

GONMarkupParserManager
- sharedParser
- parsers registration

Categories
- UILabel
 - setMarkedUpText:(NSString *)aText parser:(GONMarkupParser *)aParser;
 - setMarkedUpText:(NSString *)aText;

- UITextField
 - setMarkedUpText:(NSString *)aText parser:(GONMarkupParser *)aParser;
 - setMarkedUpText:(NSString *)aText;

##Default tags summary

| Tag        | Class | Parameters           | Effect |
|:-------------:|-------------| -----|---|
| **left** | GONMarkupAlignment | none | Force text alignment to left |
| **right** | GONMarkupAlignment | none |  Force text alignment to right |
| **center** | GONMarkupAlignment | none | Force text alignment to center |
| **justified** | GONMarkupAlignment | none | Force text alignment to justified |
| **natural** | GONMarkupAlignment | none | Force text alignment to natural  |
| **color**      | GONMarkupColor | **value** | Set text color |
| **N/A**      | GONMarkupNamedColor | none | Set text color. Can be used to reset text color to parser default one if specified color is nil |
| **font**      | GONMarkupFont | **size**, **name**  | Set text font, text size or both |
| **N/A**      | GONMarkupNamedFont | none  | Set text font and size. Can be used to reset font to parser default one if specified font is nil |
| **br**      | GONMarkupLineBreak | none | Add a new line |
| **ul**      | GONMarkupList | none  | Create an unordered list |
| **ol**      | GONMarkupList | none | Create an ordered list | 
| **li**      | GONMarkupListItem | none | Add a list item to current list |
| **p**      | GONMarkupParagrap | none | Specify a paragraph. A paragraph will automatically insert a new blanck line after it |
| **reset**      | GONMarkupReset | **all** | All enclosed text will use default parser configuration |
| **N/A**      | GONMarkupSimple | none | Apply a configuration to enclosed text |
| *b*      | GONMarkupBold | none | Set text to bold. Allows user to define a fallback block if no matching bold font found.|
| *i*      | GONMarkupItalic | none | Set text to italic. Allows user to define a fallback block if no matching italic font found.|
| *sup*      | GONMarkupTextStyle | none | Set text to superscript |
| *sub*      | GONMarkupTextStyle | none | Set text to subscript |
| **N/A**   | GONMarkupBlock | none | When encountered executes associated block |
| **N/A**   | GONAttributedMarkupBlock | *user defined* | When encountered executes associated block |

##Default tags
#Reset
##How to add new tags
- subclass
- use block marker
- use simple marker

##How does it works
- Stacked configuration
- Shared context


## Limitations
- Indentation prefix in lists need to be improved (add more symbols, etc..)
 

## Evolutions
- Implements **NSCoder** in parser and Markers
- Allows **copy** on parsers / markers

##Versions
0.5   : Initial release<br/>


Closing a markup </>, <tag/> 
<//> ==> close all opened markup

Extending :
Register fonts
Special blocks :
- reset

Example ==> tokenizer ?
==> Faire un pretraitement pour ajouter les balises

#GONMarkupParser
Easily build NSAttributedString from XML/HTML like strings.

##Description
Creating rich text under iOS can be cumbersome, needing a lot of code.
The main goal of GONMarkupParser is to provide an easy to use syntax, near XML/HTML, but more flexible.
Some others projects exists, allowing you to build NSAttributedString from HTML, but my main goal here was to focus on text semantic. In fact, the parser will detect registered markup and apply style on text.
The purpose of this was to be able to generate different output from the same input string, without editing its content, but editing the markups style.

##Demo
![ScreenShot](https://raw.github.com/nicolasgoutaland/GONMarkupParser/master/Assets/sample.gif)

##Usage
- instantiate a new __GONMarkupParser__ or use the  __+ GONMarkupParserManager sharedParser__ one.
- configure your parser adding supporting tags, default ones, custom ones, etc...
- parse input string and retrieve result __NSMutableAttributedString__ using __- attributedStringFromString:error:__ method from __GONMarkupParser__

##Installation
__Cocoapods__: `pod 'GONMarkupParser'`<br> // Not available yet
__Manual__: Copy the __Classes__ folder in your project<br>

Import wanted headers in your project. .pch is a good place ;)
__GONMarkupParser_All.h__ will reference all library headers, whereas __GONMarkupDefaultMarkups.h__ only references default markup classes.

##Example
// TODO

##How does it work ?
To fully understand how style will be applied to string, you have to imagine a [LIFO stack](http://en.wikipedia.org/wiki/LIFO_(computing)) composed of style description.
Each time a new markup is found, current style configuration will be saved then stacked. New configuration will be the previous one, updated by current markup configuration.
Each time a closing markup is found, current style configuration is popped out, and previous one restored.


##Syntax
Syntax is pretty easy. It's like XML, but, non valid one, to be easier and faster to write.
- Each markup  should be contained between __<__ and __>__ characters
 - __&lt;strong&gt;__
- Closing markup should start with __/__ character. There is no need for closing markup to match opening one. You can also leave it blank, with just the __/__ character
 - __&lt;/strong&gt;__, __</>__, __</hakuna matata>__
- You can also close all opened markup by using __<//>__
- You do not need to balance markup at text end

##Examples
 This is a &lt;/strong&gt;valid&lt;/strong&gt; string with some <color value="red">red <b>bold text</b></color>.
 This is a &lt;/strong&gt;valid&gt;/&lt;string with some <color value="red">red <b>bold text</></>.
 This is a &lt;/strong&gt;valid&gt;/Hakuna&lt; string with some <color value="red">red <b>bold text</mata></ta>.
 This is a &lt;/strong&gt;valid&gt;/&lt; string with some <color value="red">red <b>bold text<//>.

##Parser
GONMarkupParser
- constructors
- configuration
- registered fonts
- pre / post processing block
- replaceNewLineCharactersFromInputString
- replaceHTMLCharactersFromOutputString

GONMarkupParserManager
- sharedParser
- parsers registration

##Available UIKit Categories
__UILabel__/__UITextField__
2 methods were added to UILabel and UITextField, allowing you to easily update its attribtued string using a markedup one.
__- setMarkedUpText:(NSString *)text parser:(GONMarkupParser *)parser__ will use given parser to handle string and generate attributedOne.
__- setMarkedUpText:(NSString *)text__ will use shared one, aka __[GONMarkupParserManager sharedParser]__

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
- Shared context


## Limitations
- Indentation prefix in lists needs to be improved (add more symbols, etc..)
 

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


==> Example

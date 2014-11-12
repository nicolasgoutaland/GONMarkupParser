#GONMarkupParser
Easily build NSAttributedString from XML/HTML like strings.

##Demo
![ScreenShot](https://raw.github.com/nicolasgoutaland/GONMarkupParser/master/Assets/sample.gif)

##TL;DR;
```
    NSString *inputText = @"Simple input text, using a preconfigured parser.\n<color value=\"red\">This text will be displayed in red</>.\n<font size="8">This one will be displayed in small</>.\nNow a list:\n<ul><li>First item</><li>Second item</><li><color value="blue">Third blue item</></><li><b><color value="green">Fourth bold green item<//>";

    // No custom configuration, use default tags only

    // Affect text to label
    label.attributedText = [[GONMarkupParserManager sharedParser] attributedStringFromString:inputText                  
                                                                                       error:nil];
````
![ScreenShot](https://raw.github.com/nicolasgoutaland/GONMarkupParser/master/Assets/GONMarkupParser-example1.png)

Need a more complex example  ?

```
    NSString *inputText = @"Simple input text, using a preconfigured parser.\n<red>This text will be displayed in red</>.\n<small>This one will be displayed in small</>.\n<pwet>This one is a custom one, to demonstrate how easy it is to declare a new markup.</>";

    // Set your custom configuration here
#ifdef DEBUG
    [GONMarkupParserManager sharedParser].debugEnabled = YES; // Fuck yeah, error logging
#endif
    
    // Set default string configuration
    [[GONMarkupParserManager sharedParser].defaultConfiguration setObject:[UIFont systemFontOfSize:25.0] forKey:NSFontAttributeName];
    
    // Add a custom markup, that will center text when used, and display it in pink.
    NSMutableParagraphStyle *defaultParagraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    defaultParagraphStyle.alignment = NSTextAlignmentCenter;
    [[GONMarkupParserManager sharedParser] addMarkup:[GONMarkupSimple simpleMarkup:@"pwet"
                                                                             style:@{
                                                                                     NSParagraphStyleAttributeName : defaultParagraphStyle,
                                                                                     NSForegroundColorAttributeName : [@"pink" representedColor] // NSString+Color
                                                                                     }
                                                                   mergingStrategy:GONMarkupSimpleMergingStrategyMergeAll]];
    
    // Add add font markup, to display small text when encountered
    [[GONMarkupParserManager sharedParser] addMarkup:[GONMarkupNamedFont namedFontMarkup:[UIFont systemFontOfSize:12.0] forTag:@"small"]];

    // Add a convenient tag for red color
    [[GONMarkupParserManager sharedParser] addMarkup:[GONMarkupNamedColor namedColorMarkup:[UIColor redColor]
                                                                                    forTag:@"red"]];

    // Affect text to label
    label.attributedText = [[GONMarkupParserManager sharedParser] attributedStringFromString:inputText                  
                                                                                       error:nil];
````
![ScreenShot](https://raw.github.com/nicolasgoutaland/GONMarkupParser/master/Assets/GONMarkupParser-example2.png)



##Description
Creating rich text under iOS can be cumbersome, needing a lot of code.<br/>
The main goal of GONMarkupParser is to provide an easy to use syntax, near XML/HTML, but more flexible.<br/>
Some others projects exists, allowing you to build NSAttributedString from HTML, but my main goal here was to focus on text semantic. In fact, the parser will detect registered markup and apply style on text.<br/>
The purpose of this was to be able to generate different output from the same input string, without editing its content, but editing the markups style.<br/>

##Usage
- instantiate a new __GONMarkupParser__ or use the  __+ GONMarkupParserManager sharedParser__ one.
- configure your parser adding supporting tags, default ones, custom ones, etc...
- parse input string and retrieve result __NSMutableAttributedString__ using __- attributedStringFromString:error:__ method from __GONMarkupParser__

##Installation
__Cocoapods__: `pod 'GONMarkupParser'`<br> // Not available yet
__Manual__: Copy the __Classes__ folder in your project<br>

Import wanted headers in your project. .pch is a good place ;)
__GONMarkupParser_All.h__ will reference all library headers, whereas __GONMarkupDefaultMarkups.h__ only references default markup classes.

##How does it work ?
![ScreenShot](https://raw.github.com/nicolasgoutaland/GONMarkupParser/master/Assets/GONMarkupParser-howdoesitworks.gif)

To fully understand how style will be applied to string, you have to imagine a [LIFO stack](http://en.wikipedia.org/wiki/LIFO_(computing)) composed of style description.<br/>
Each time a new markup is found, current style configuration will be saved then stacked. New configuration will be the previous one, updated by current markup configuration.<br/>
Each time a closing markup is found, current style configuration is popped out, and previous one restored.

##Syntax
Syntax is pretty easy. It's like XML, but non valid one, to be easier and faster to write.
- Each markup  should be contained between __<__ and __>__ characters
 - __&lt;strong&gt;__
- Closing markup should start with __/__ character. There is no need for closing markup to match opening one. You can also leave it blank, with just the __/__ character
 - __&lt;/strong&gt;__, __</>__, __</hakuna matata>__
- You can also close all opened markup by using __<//>__
- You do not need to balance markup at text end

###Examples
```
 This is a <strong>valid</strong> string with some <color value="red">red <b>bold text</b></color>.
 This is a <strong>valid</>string with some <color value="red">red <b>bold text</></>.
 This is a <strong>valid</Hakuna> string with some <color value="red">red <b>bold text</mata></ta>.
 This is a <strong>valid</> string with some <color value="red">red <b>bold text<//>.
```

##Parser
###Constructor
__GONMarkupParser__ class provide two class constructors.
- __+ defaultMarkupParser__ is a parser with all default tags registered (See [Default tags summary](#default-tags) for more information)
- __+ emptyMarkupParser__ is a parser without any registered tags

###Properties
A parser can have a pre / post processing block, that will be called prior and after parsing. This allows you to perform some string replace before parsing for example. 

Parsers have two interesting properties :
- __replaceNewLineCharactersFromInputString__, is intended to strip all newlines characters from input string. Use __br__ markup to add new lines. Default is __NO__.
- __replaceHTMLCharactersFromOutputString__, is intended to replace all HTML entities contained in string, after parsing. Default is __YES__.

__defaultConfiguration__ will contains default style configuration for generated attributed string. Content should be valid attributes parameters, as you may pass to __- addAttributes:range:__ of __NSMutableAttributedString__ objects.

For debugging purpose, you can set __debug__ to YES.

###Configuration
A parser must have some registered markups to correctly handling strings.<br/>
Use __- addMarkup:__, __- addMarkups:__, __- removeMarkups:__ and __- removeAllMarkups__ methods for that purpose.<br/>
__A markup can be added to only one parser at a time.__

###Registered fonts
To simplify fonts uses, you can register then using __- registerFont:forKey:__ method, then referencing them using given key.<br/>
Very useful with __&lt;font&gt;__ markup, allowing you to directly use code instead of full font name. You can also use codes such as __mainFont__, __titleFont__ to easily update them later throught all your strings.

##GONMarkupParserManager
###sharedParser
A shared parser is available, so you don't have to create one and reference it throught all your application.<br/>
Shared parser is configured with all default markups.

###parsers registration
You can register some parser to this class, allowing you to use them from different places in your application.

##Available UIKit Categories
__UILabel__/__UITextField__<br/>
2 methods were added to UILabel and UITextField, allowing you to easily update its attribtued string using a markedup one.<br/>
- __- setMarkedUpText:(NSString *)text parser:(GONMarkupParser *)parser__ will use given parser to handle string and generate attributedOne.
- __- setMarkedUpText:(NSString *)text__ will use shared one, aka __[GONMarkupParserManager sharedParser]__

##Default tags
###Summary
| Tag        | Class | Parameters           | Effect |
|:-------------:|-------------| -----|---|
| **left** | GONMarkupAlignment | none | Force text alignment to left |
| **right** | GONMarkupAlignment | none |  Force text alignment to right |
| **center** | GONMarkupAlignment | none | Force text alignment to center |
| **justified** | GONMarkupAlignment | none | Force text alignment to justified |
| **natural** | GONMarkupAlignment | none | Force text alignment to natural  |
| **color**      | GONMarkupColor | **value** | Set text color. For supported __value__ syntaxes, check [NSString+Color](https://github.com/nicolasgoutaland/NSString-Color) [__representedColor__](https://github.com/nicolasgoutaland/NSString-Color#example) method. |
| **N/A**      | GONMarkupNamedColor | none | Set text color. Can be used to reset text color to parser default one if specified color is nil |
| **font**      | GONMarkupFont | **size**, **name**  | Set text font, text size or both. |
| **N/A**      | GONMarkupNamedFont | none  | Set text font and size. Can be used to reset font to parser default one if specified font is nil |
| **br**      | GONMarkupLineBreak | none | Add a new line |
| **ul**      | GONMarkupList | none  | Create an unordered list |
| **ol**      | GONMarkupList | none | Create an ordered list | 
| **li**      | GONMarkupListItem | none | Add a list item to current list |
| **p**      | GONMarkupParagrap | none | Specify a paragraph. A paragraph will automatically insert a new blanck line after it |
| **inc**      | GONMarkupInc | **value** | Increment text font size. If __value__ is missing, font will be increased by one point  |
| **dec**      | GONMarkupDec | **value** | Decrement text font size. If __value__ is missing, font will be decreased by one point  |
| **reset**      | GONMarkupReset | **all** | All enclosed text will use default parser configuration |
| **N/A**      | GONMarkupSimple | none | Apply a configuration to enclosed text |
| **b**      | GONMarkupBold | none | Set text to bold. Allows user to define an override block overrideBlock to provide another font. Useful to provide a medium font instead of bold one for example.|
| **i**      | GONMarkupItalic | none | Set text to italic. Allows user to define an override block overrideBlock to provide another font. Useful to provide a medium italic font instead of bold italic one for example.|
| **sup**      | GONMarkupTextStyle | none | Set text to superscript |
| **sub**      | GONMarkupTextStyle | none | Set text to subscript |
| **N/A**   | GONMarkupBlock | none | When encountered executes associated block |
| **N/A**   | GONAttributedMarkupBlock | *user defined* | When encountered executes associated block |

###Reset
Reset is a special tag, allowing you to protect some parts of a string. You can also force markup to ignore default parser configuration by setting __all__ attribute.

![ScreenShot](https://raw.github.com/nicolasgoutaland/GONMarkupParser/master/Assets/GONMarkupParser-reset.gif)

##How to add new markup
You can add new markup in your application, to add new style, or to just add some semantic to your text, allowing you to update rendering, without changing input string.<br/>
There is 3 ways to do it.

###Adding a new simple marker
The simpler way to add a new markup in your application is to use one of theses 3 following classes :
- __GONMarkupNamedColor__, allows you to add a markup that updates text color
- __GONMarkupNamedFont__, allows you to add a markup that updates text font
- __GONMarkupSimple__, allows you to add a markup that updates all text attributes. Dictionary is intended to be the same as you may pass to configure an NSMutableAttributedString using -setAttributes:range: method.

####Example
```
    // Retrieve shared parser
    GONMarkupParser *parser = [GONMarkupParserManager sharedParser];
    
    // Add a named color markup
    [parser addMarkup:[GONMarkupNamedColor namedColorMarkup:[UIColor redColor]
               forTag:@"red"]];

    // Add a named font markup
    [parser addMarkup:[GONMarkupNamedFont namedFontMarkup:[UIFont systemFontOfSize:12.0] 
               forTag:@"small"]];

    // Add a custom markup, that will center text when used, and display it in pink.
    NSMutableParagraphStyle *defaultParagraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    defaultParagraphStyle.alignment = NSTextAlignmentCenter;
    [parser addMarkup:[GONMarkupSimple simpleMarkup:@"pwet"
                                              style:@{
                                                        NSParagraphStyleAttributeName : defaultParagraphStyle,
                                                        NSForegroundColorAttributeName : [@"pink" representedColor] // NSString+Color
                                                     }
                                    mergingStrategy:GONMarkupSimpleMergingStrategyMergeAll]];
````

###Adding a new block based marker
For more complexe markup, you can add __GONMarkupBlock__ and __GONAttributedMarkupBlock__ instances.<br />
First one is simple, without markup parameters handling.
If you want to handle parameters in your markup, you better have to use second one.

They both have blocks 5 parameters :
- __openingMarkupBlock__, called when markup opening is found. Used to pushed your custom configuration to stack
- __closingMarkupBlock__, called once markup is closed.
- __updatedContentStringBlock__, called right after __closingMarkupBlock__, allowing you to override returned string
- __prefixStringForContextBlock__, called right after __openingMarkupBlock__, allowing you to return a prefix
- __suffixStringForContextBlock__, called right after __openingMarkupBlock__, allowing you to return a suffix

####Example
```
    // Retrieve shared parser
    GONMarkupParser *parser = [GONMarkupParserManager sharedParser];
    
    // Custom markup, based on block
    GONMarkupBlock *markupBlock = [GONMarkupBlock blockMarkup:@"custom"];
    markupBlock.openingMarkupBlock = ^(NSMutableDictionary *configurationDictionary, NSString *tag, NSMutableDictionary *context) {
        // Update font size
        [configurationDictionary setObject:[UIFont boldSystemFontOfSize:69.0]
                                    forKey:NSFontAttributeName];
        
        // Update text color
        [configurationDictionary setObject:[@"brown" representedColor]
                                    forKey:NSForegroundColorAttributeName];
    };

    [parser addMarkup:markupBlock];
````

###Creating a new GONMarkup subclass
You can add a custom markup by subclassing __GONMarkup__ or __GONAttributedMarkup__ classes.
__GONMarkup__ is for simple markups,  __GONAttributedMarkup__ add support for attributes.

Adding a new markup by subclassing is useful if you want to reuse your markups between several projets, or addto implement more complex behavior. When subclassing, you have access to a shared object, allowing you to persists data and share it between each markup handling.

For examples, have a look a currently defined markups ;)
See __GONMarkupList__ and __GONMarkupListItem__ for an implementation using shared context.

## Evolutions
- Indentation prefix in lists needs to be improved (add more symbols, etc..)
- Implements **NSCoder** in parser and Markers
- Allows **copy** on parsers / markers

##Versions
0.5   : Initial release<br/>

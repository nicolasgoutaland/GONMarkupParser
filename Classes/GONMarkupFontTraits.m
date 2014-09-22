//
//  GONMarkupFontTraits.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 22/09/14.
//  Copyright 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupFontTraits.h"
#import "GONMarkup+private.h"

@interface GONMarkupFontTraits ()
// Data
@property (nonatomic, assign) UIFontDescriptorSymbolicTraits traits;
@end

@implementation GONMarkupFontTraits
#pragma mark - Constructor
+ (instancetype)fontTraitsMarkup:(NSString *)aTag traits:(UIFontDescriptorSymbolicTraits )aTraits
{
    GONMarkupFontTraits *markup = [self markupForTag:aTag];

    markup.traits = aTraits;

    return markup;
}


#pragma mark - Style
- (void)openingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext
{
    // Look for current font
    UIFont *currentFont = [aConfigurationDictionary objectForKey:NSFontAttributeName];
    if (!currentFont)
    {
        // No found defined, use default one with default size
        currentFont = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }
    
    // Update font to set trait
    UIFontDescriptor *fontDescriptor = currentFont.fontDescriptor;
    UIFontDescriptorSymbolicTraits fontTaits = fontDescriptor.symbolicTraits;
    
    // Check if font already has traits
    UIFont *updatedFont = currentFont;
    if (!(fontTaits & _traits))
    {
        fontTaits |= _traits;
        updatedFont = [UIFont fontWithDescriptor:[fontDescriptor fontDescriptorWithSymbolicTraits:fontTaits]
                                            size:currentFont.pointSize];
        
        // Font may not exists, fallback
        // Note : In iOS7, if no fount is found, normal one will be returned. Since iOS8, nil will be returned
        if (!updatedFont || [currentFont isEqual:updatedFont])
        {
            // If a fallback block was defined, try it
            if (_fallbackBlock)
                updatedFont = (_fallbackBlock(currentFont));

            // If no font after block, use default system one
            if (!updatedFont)
            {
                if (self.parser.debugEnabled)
                {
                    if (!_fallbackBlock)
                        NSLog(@"%@ : No font found for <%@-%@> applying traits. Consider setting up <fallbackBlock> to provide a fallback font", [[self class] description], currentFont.familyName, currentFont.fontName);
                    else
                        NSLog(@"%@ : No font returned from fallback block for <%@-%@>. Consider seting up one", [[self class] description], currentFont.familyName, currentFont.fontName);
                }

                // Do not update font
                updatedFont = currentFont;
            }
            else
            {
                // Check for font size
                if (updatedFont.pointSize != currentFont.pointSize)
                {
                    // Build a new font with current size
                    updatedFont = [UIFont fontWithDescriptor:[updatedFont fontDescriptor]
                                                        size:currentFont.pointSize];
                }
            }
        }
    }

    // Update configuration
    [aConfigurationDictionary setObject:updatedFont
                                 forKey:NSFontAttributeName];
}

@end
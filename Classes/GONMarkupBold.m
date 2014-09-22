//
//  GONMarkupBold.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 19/09/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupBold.h"
#import "GONMarkup+Private.h"

@implementation GONMarkupBold
#pragma mark - Constructor
+ (instancetype)boldMarkup
{
    return [self markupForTag:GONMarkupBold_TAG];
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
    UIFontDescriptorSymbolicTraits traits = fontDescriptor.symbolicTraits;
    
    // Check if font is already bold
    UIFont *boldFont = currentFont;
    if (!(traits & UIFontDescriptorTraitBold))
    {
        traits |= UIFontDescriptorTraitBold;
        currentFont = [UIFont fontWithDescriptor:[fontDescriptor fontDescriptorWithSymbolicTraits:traits]
                                            size:currentFont.pointSize];

        // Font may not exists, fallback
        if (!boldFont)
        {
            // If a fallback block was defined, try it
            if (_boldFontFallbackBlock)
                boldFont = (_boldFontFallbackBlock(currentFont));

            // If no font after block, use default system one
            if (!boldFont)
            {
                if (self.parser.debugEnabled)
                {
                    if (!_boldFontFallbackBlock)
                        NSLog(@"%@ : No bold font found for <%@-%@>. Consider setting up <boldFontFallbackBlock> to provide a fallback font", [[self class] description], currentFont.familyName, currentFont.fontName);
                    else
                        NSLog(@"%@ : No bold font returned from fallback block for <%@-%@>. Consider seting up one", [[self class] description], currentFont.familyName, currentFont.fontName);
                }

                boldFont = [UIFont boldSystemFontOfSize:currentFont.pointSize];
            }
        }
    }

    // Update configuration
    [aConfigurationDictionary setObject:boldFont
                                 forKey:NSFontAttributeName];
}
@end

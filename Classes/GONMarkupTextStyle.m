//
//  GONMarkupTextStyle.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/07/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupTextStyle.h"
#import <CoreText/CoreText.h>

@interface GONMarkupTextStyle ()
// Data
@property (nonatomic, strong) NSNumber *superscriptValue;
@property (nonatomic, assign) UIFontDescriptorSymbolicTraits trait;

@end

@implementation GONMarkupTextStyle
#pragma mark - Constructor
+ (NSArray *)allMarkups
{
    return @[[self boldMarkup], [self italicMarkup], [self superscriptedMarkup], [self subscriptedMarkup]];
}

+ (instancetype)boldMarkup
{
    GONMarkupTextStyle *markup = [self markupForTag:GONMarkupTextStyle_Bold_TAG];
    
    markup.trait = UIFontDescriptorTraitBold;

    return markup;
}

+ (instancetype)italicMarkup
{
    GONMarkupTextStyle *markup = [self markupForTag:GONMarkupTextStyle_Italic_TAG];

    markup.trait = UIFontDescriptorTraitItalic;

    return markup;
}

+ (instancetype)superscriptedMarkup
{
    GONMarkupTextStyle *markup = [self markupForTag:GONMarkupTextStyle_Superscripted_TAG];

    markup.superscriptValue = @(1);

    return markup;
}

+ (instancetype)subscriptedMarkup
{
    GONMarkupTextStyle *markup = [self markupForTag:GONMarkupTextStyle_Subscripted_TAG];

    markup.superscriptValue = @(-1);

    return markup;
}



#pragma mark - Style
- (void)openingMarkupFound:(NSString *)aTag configuration:(NSMutableDictionary *)aConfigurationDictionary context:(NSMutableDictionary *)aContext
{
    if (_superscriptValue)
        [self handleSuperScript:aConfigurationDictionary];
    else
        [self handleFontTrait:aConfigurationDictionary];
}

- (void)handleSuperScript:(NSMutableDictionary *)aConfigurationDictionary
{
    [aConfigurationDictionary setObject:_superscriptValue
                                 forKey:(NSString *)kCTSuperscriptAttributeName];
}

- (void)handleFontTrait:(NSMutableDictionary *)aConfigurationDictionary
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
    if (!(traits & _trait))
    {
        traits |= _trait;
        currentFont = [UIFont fontWithDescriptor:[fontDescriptor fontDescriptorWithSymbolicTraits:traits]
                                            size:currentFont.pointSize];
    }

    // Update configuration
    [aConfigurationDictionary setObject:currentFont
                                 forKey:NSFontAttributeName];
}

@end

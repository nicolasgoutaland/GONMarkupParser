//
//  GONMarkupImage.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 04/03/16.
//  Copyright © 2016 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupImage.h"

@implementation GONMarkupImage
+ (instancetype)imageMarkup
{
    return [self markupForTag:@"image"];
}

- (NSAttributedString *)updatedContentString:(NSString *)string
                                     context:(NSMutableDictionary *)context
                                  attributes:(NSDictionary *)dicAttributes
                            stringAttributes:(NSDictionary *)stringAttributes
                                resultString:(NSAttributedString *)resultString
{
    UIImage *image = [UIImage imageNamed:[dicAttributes objectForKey:GONMarkupImage_TAG_value_ATT]];
    if (image)
    {
        CGFloat scale = [UIScreen mainScreen].scale;
        scale = 2;
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        attch.image = image;
        attch.bounds = CGRectMake(0, 0, image.size.width/scale, image.size.height/scale);
        return [NSAttributedString attributedStringWithAttachment:attch];
    }

    return [super updatedContentString:string
                               context:context
                            attributes:dicAttributes
                      stringAttributes:stringAttributes
                          resultString:resultString];
}
@end

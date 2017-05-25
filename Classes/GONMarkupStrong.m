//
//  GONMarkupStrong.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/05/2017.
//  Copyright 2017 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupStrong.h"

@interface GONMarkupStrong ()
@end

@implementation GONMarkupStrong
#pragma mark - Constructor
+ (instancetype)strongMarkup
{
    return [super fontTraitsMarkup:GONMarkupStrong_TAG
                            traits:UIFontDescriptorTraitBold];
}

@end

//
//  GONMarkup+Private.h
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkup.h"
#import "GONMarkupParser.h"

@interface GONMarkup (Private)
@property (nonatomic, weak) GONMarkupParser *parser;
@end

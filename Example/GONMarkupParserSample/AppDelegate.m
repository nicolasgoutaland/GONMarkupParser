//
//  AppDelegate.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "AppDelegate.h"
#import "GONMarkupParser_All.h"
#import "InputViewController.h"

@implementation AppDelegate

#warning TODO Need more examples !!!!! Create a tableview with all samples

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Set your custom configuration here
    [GONMarkupParserManager sharedParser].debugEnabled = YES;
    [[GONMarkupParserManager sharedParser].defaultConfiguration setObject:[UIFont systemFontOfSize:25.0] forKey:NSFontAttributeName];

    [[GONMarkupParserManager sharedParser] addMarkup:[GONMarkupSimple simpleMarkup:@"pwet"
                                                                        style:@{NSParagraphStyleAttributeName : [NSParagraphStyle defaultParagraphStyle]}
                                                              mergingStrategy:GONMarkupSimpleMergingStrategyMergeAll]];

    
    [[GONMarkupParserManager sharedParser] addMarkup:[GONMarkupNamedFont namedFontMarkup:[UIFont systemFontOfSize:12.0] forTag:@"small"]];
    [[GONMarkupParserManager sharedParser] addMarkup:[GONMarkupNamedColor namedColorMarkup:[UIColor redColor]
                                                                               forTag:@"red"]];

    // Custom markup block
    GONMarkupBlock *markupBlock = [GONMarkupBlock blockMarkup:@"custom"];
    markupBlock.openingMarkupBlock = ^(NSMutableDictionary *aConfigurationDictionary, NSString *aTag, NSMutableDictionary *aContext) {
        [aConfigurationDictionary setObject:[UIFont boldSystemFontOfSize:69.0]
                                     forKey:NSFontAttributeName];
    };

    [[GONMarkupParserManager sharedParser] addMarkup:markupBlock];

    // You can define custom text from <Resources/Default> file
    NSString *defaultString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DefaultText" ofType:nil]
                                                        encoding:NSUTF8StringEncoding error:nil];

    // Set input string for demo. Do not do this king of thing in a real project, please don't ;)
    ((InputViewController *)[((UINavigationController *)[self.window rootViewController]) topViewController]).defaultString = defaultString;

    return YES;
}

@end

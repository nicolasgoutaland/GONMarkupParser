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
    // Custom markup, based on block
    GONMarkupBlock *markupBlock = [GONMarkupBlock blockMarkup:@"custom"];
    markupBlock.openingMarkupBlock = ^(NSMutableDictionary *configurationDictionary, NSString *tag, NSMutableDictionary *context) {
        [configurationDictionary setObject:[UIFont boldSystemFontOfSize:69.0]
                                    forKey:NSFontAttributeName];
        [configurationDictionary setObject:[@"brown" representedColor]
                                    forKey:NSForegroundColorAttributeName];
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

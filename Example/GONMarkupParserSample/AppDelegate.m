//
//  AppDelegate.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "AppDelegate.h"
#import "GONMarkupParser_All.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Set your custom configuration here
#ifdef DEBUG
    [GONMarkupParserManager sharedParser].logLevel = GONMarkupParserLogLevelErrors; // Fuck yeah, error logging
#endif

    return YES;
}

@end

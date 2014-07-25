//
//  GONMarkupParserManager.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/07/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "GONMarkupParserManager.h"
#import "GONMarkupDefaultMarkups.h"

@interface GONMarkupParserManager ()
// Data
@property (nonatomic, strong) NSMutableDictionary *registeredParsers;
@end

@implementation GONMarkupParserManager
#pragma mark - Shared manager
+ (instancetype)manager
{
    [super initialize];
    
    static GONMarkupParserManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}

- (id)init
{
    if (self = [super init])
    {
        _registeredParsers = [[NSMutableDictionary alloc] init];
    }

    return self;
}

#pragma mark - Shared instance
+ (GONMarkupParser *)sharedParser
{
    static GONMarkupParser *sharedParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedParser = [GONMarkupParser defaultMarkupParser];
    });

    return sharedParser;
}

+ (GONMarkupParser *)registeredMarkupParserForKey:(NSString *)aKey
{
    return [[[self manager] registeredParsers] objectForKey:aKey];
}

+ (void)registerMarkupParser:(GONMarkupParser *)aParser forKey:(NSString *)aKey
{
    [[[self manager] registeredParsers] setObject:aParser
                                           forKey:aKey];
}

+ (void)unregisterMarkupParserForKey:(NSString *)aKey
{
    [[[self manager] registeredParsers] removeObjectForKey:aKey];
}

@end

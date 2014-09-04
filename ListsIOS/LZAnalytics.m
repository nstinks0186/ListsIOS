//
//  LZAnalytics.m
//  ListsIOS
//
//  Created by Pinuno on 9/3/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "LZAnalytics.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import "Flurry.h"

#define GAITracker ((id<GAITracker>)[[GAI sharedInstance] defaultTracker])

@implementation LZAnalytics

+ (LZAnalytics *)sharedInstance
{
    static LZAnalytics *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[LZAnalytics alloc] init];
    });
    
    return _sharedInstance;
}

#pragma mark Operatins

- (void)logError:(NSError *)error title:(NSString *)title message:(NSString *)message
{
    // console log
    DLog(@"%@\n  %@\n  %@", title, message, error);
    
    // google analytics
    [GAITracker send:[[GAIDictionaryBuilder createEventWithCategory:title
                                                             action:message
                                                              label:[error description]
                                                              value:nil] build]];
    
    // flurry analytics
    [Flurry logError:title message:message error:error];
}

- (void)logScreenView:(NSString *)screenName
{
    // google analytics
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:screenName];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    // flurry analytics
    [Flurry logPageView];
    [Flurry logEvent:screenName];
}

@end

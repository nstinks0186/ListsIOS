//
//  AppDelegate.m
//  ListsIOS
//
//  Created by Pinuno on 8/6/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "BButton.h"
#import "GAI.h"
#import "Flurry.h"
#import "LZSession.h"

@implementation AppDelegate

#pragma mark - Operations

- (void)showHome
{
    // TODO: do presync here
//    [LZTag fetchSystemTags:^(BOOL succeeded, NSError *error) {
//        self.window.rootViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"ECSlidingVC"];
//    }];
    [LZCurrentSession initSession:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            self.window.rootViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"ECSlidingVC"];
        }
    }];
}

- (void)showAuth
{
    self.window.rootViewController = [self.window.rootViewController.storyboard instantiateInitialViewController];
}

#pragma mark - UIApplicationDelegate Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#warning Debug code
    LZDebugModeOn;
    
    // Parse Setup
    [Parse setApplicationId:@"fs0rqrwuJGKHwtYp6qvyPxytPFACpEsqRtPt8hOw"
                  clientKey:@"qPyxYg7VOIpZtJ0wBfFlJ25GgyDAmReqpqB0kzuY"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Google Analytics Setup
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-53434717-2"];
    
    // Flurry Analytics Setup
    [Flurry setCrashReportingEnabled:YES];
    [Flurry startSession:@"XXWTNVY73SR37DRDJD36"];
    
    // Appearance Setup
    [[BButton appearance] setButtonCornerRadius:[NSNumber numberWithFloat:0.0f]];
    [[UINavigationBar appearance] setTitleTextAttributes: @{ NSFontAttributeName: [UIFont fontWithName:Theme_FontName size:0.0f], NSForegroundColorAttributeName : [UIColor whiteColor] }];
    [[UINavigationBar appearance] setBarTintColor:Theme_MainColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}

@end

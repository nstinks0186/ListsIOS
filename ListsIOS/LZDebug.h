//
//  LZDebug.h
//  ListsIOS
//
//  Created by Pinuno on 9/3/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define LZDebugMode [[NSUserDefaults standardUserDefaults] boolForKey:@"ListZilla.debugMode"]
#define LZDebugModeOn [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ListZilla.debugMode"];
#define LZDebugModeOff [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ListZilla.debugMode"]

#define LZDebugVC self

@interface LZDebug : NSObject

+ (LZDebug *)sharedInstance;

@end

@interface UIViewController (LZDebug)

- (void)showCTFeedbackForError:(NSError *)error;

@end

//
//  LZAnalytics.h
//  ListsIOS
//
//  Created by Pinuno on 9/3/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LZAnalyticsBoss [LZAnalytics sharedInstance]

@interface LZAnalytics : NSObject

+ (LZAnalytics *)sharedInstance;

// operations
- (void)logError:(NSError *)error title:(NSString *)title message:(NSString *)message;
- (void)logScreenView:(NSString *)screenName;

@end

//
//  WebVC.h
//  ListsIOS
//
//  Created by Pinuno on 8/12/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WebVM;

@interface WebVC : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) WebVM *webVM;

@end

@interface WebVM : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *htmlString;

+ (id)BButtonWebVM;
+ (id)BZGFormFieldWebVM;
+ (id)CTFeedbackWebVM;
+ (id)FacebookSDKWebVM;
+ (id)ECSlidingViewControllerWebVM;
+ (id)HexColorWebVM;
+ (id)TSMessagesWebVM;
+ (id)DefaultEULAWebVM;

@end
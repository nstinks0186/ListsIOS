//
//  LoginVC.h
//  ListsIOS
//
//  Created by Pinuno on 8/7/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LoginVM : NSObject

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;

@end

@interface LoginVC : UITableViewController

@end

//
//  SignupVC.h
//  ListsIOS
//
//  Created by Pinuno on 8/7/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SignupVM : NSObject

@property (strong, nonatomic) NSString *emailAddress;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;

@property (readonly) BOOL isValid;
@property (readonly) NSString *validationError;

@end

@interface SignupVC : UITableViewController

@end

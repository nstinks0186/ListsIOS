//
//  SignupVM.h
//  ListsIOS
//
//  Created by Pinuno on 8/12/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "LoginVM.h"

@interface SignupVM : LoginVM

@property (strong, nonatomic) NSString *emailAddress;

@property (readonly) BOOL isEmailAddressValid;

@end

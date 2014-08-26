//
//  LoginVM.h
//  ListsIOS
//
//  Created by Pinuno on 8/12/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginVM : NSObject {
    NSString *_validationError;
}

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;

@property (readonly) BOOL isUsernameValid;
@property (readonly) BOOL isPasswordValid;
@property (readonly) BOOL isValid;
@property (readonly) NSString *validationError;


@end

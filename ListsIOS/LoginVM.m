//
//  LoginVM.m
//  ListsIOS
//
//  Created by Pinuno on 8/12/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "LoginVM.h"

@interface LoginVM ()

@end

@implementation LoginVM

- (BOOL)isUsernameValid
{
    // TODO: improve
    
    if (self.username.length < 6) {
        _validationError = @"Invalid username.";
        return NO;
    }
    
    NSCharacterSet * characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString: self.username];
    if([[NSCharacterSet alphanumericCharacterSet] isSupersetOfSet: characterSetFromTextField] == NO){
        _validationError = @"Invalid username.";
        return NO;
    }
    
    _validationError = nil;
    return YES;
}

- (BOOL)isPasswordValid
{
    if (self.password.length < 8) {
        _validationError = @"Invalid password.";
        return NO;
    }
    
    _validationError = nil;
    return YES;
}

- (BOOL)isValid
{
    // validate username
    if (!self.isUsernameValid) {
        return NO;
    }
    
    // validate password
    if (!self.isPasswordValid) {
        return NO;
    }
    
    _validationError = nil;
    return YES;
}

- (NSString *)validationErrror
{
    return [_validationError copy];
}

@end

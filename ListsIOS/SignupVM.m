//
//  SignupVM.m
//  ListsIOS
//
//  Created by Pinuno on 8/12/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "SignupVM.h"

@interface SignupVM () 

@end

@implementation SignupVM

- (BOOL)isEmailAddressValid
{
    if (self.emailAddress.length < 8) {
        _validationError = @"Invalid email address.";
        return NO;
    }
    
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    BOOL valid = [emailTest evaluateWithObject:self.emailAddress];
    if (!valid) {
        _validationError = @"Invalid email address.";
        return NO;
    }
    
    _validationError = nil;
    return YES;
}

- (BOOL)isValid
{
    // TODO: improve
    
    // do email address validation
    if (!self.isEmailAddressValid) {
        return NO;
    }
    
    
    // do super validation
    if (!super.isValid) {
        return NO;
    }
    
    _validationError = nil;
    return YES;
}

- (NSString *)validationError
{
    return [_validationError copy];
}

@end

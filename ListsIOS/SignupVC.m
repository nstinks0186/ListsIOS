//
//  SignupVC.m
//  ListsIOS
//
//  Created by Pinuno on 8/7/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "SignupVC.h"
#import "AppDelegate.h"
#import "BZGFormField.h"
#import "TSMessage.h"

@interface SignupVC ()

@property (strong, nonatomic) SignupVM *signupVM;

@property (weak, nonatomic) IBOutlet BZGFormField *emailAddressField;
@property (weak, nonatomic) IBOutlet BZGFormField *usernameField;
@property (weak, nonatomic) IBOutlet BZGFormField *passwordField;

- (void)signup;
- (void)showHome;

@end

@implementation SignupVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [TSMessage setDefaultViewController:self];
    
    self.emailAddressField.textField.placeholder = @"Email Address";
    self.usernameField.textField.placeholder = @"Username";
    self.passwordField.textField.placeholder = @"Password";
    self.passwordField.textField.secureTextEntry = YES;
    
    [self.emailAddressField setTextValidationBlock:^BOOL(BZGFormField *field, NSString *text) {
        // TODO: do validation
        
        if (text.length < 8) {
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
        return [emailTest evaluateWithObject:text];
    }];
    [self.usernameField setTextValidationBlock:^BOOL(BZGFormField *field, NSString *text) {
        // TODO: do validation
        
        if (text.length < 8) {
            return NO;
        }
        
        NSCharacterSet * characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString: text];
        if([[NSCharacterSet alphanumericCharacterSet] isSupersetOfSet: characterSetFromTextField] == NO){
            return NO;
        }
        
        return YES;
    }];
    [self.passwordField setTextValidationBlock:^BOOL(BZGFormField *field, NSString *text) {
        // TODO: do validation
        
        if (text.length < 8) {
            return NO;
        }
        
        return YES;
    }];
    
    [self.emailAddressField.textField addTarget:self action:@selector(emailAddressFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.usernameField.textField addTarget:self action:@selector(usernameFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordField.textField addTarget:self action:@selector(passwordFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.signupVM = [[SignupVM alloc] init];
    self.signupVM.emailAddress = self.emailAddressField.textField.text;
    self.signupVM.username = self.usernameField.textField.text;
    self.signupVM.password = self.passwordField.textField.text;
}

#pragma mark - Action Methods

- (IBAction)cancelButtonTapped:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)emailAddressFieldChanged:(id)sender
{
    self.signupVM.emailAddress = self.emailAddressField.textField.text;
}

- (IBAction)usernameFieldChanged:(id)sender
{
    self.signupVM.username = self.usernameField.textField.text;
}

- (IBAction)passwordFieldChanged:(id)sender
{
    self.signupVM.password = self.passwordField.textField.text;
}

- (IBAction)signupButtonTapped:(id)sender
{
    if (self.signupVM.isValid) {
        [self signup];
    }else{
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"Login Failed", nil)
                                    subtitle:self.signupVM.validationError
                                        type:TSMessageNotificationTypeError];
    }
}


#pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Convenience Methods

- (void)signup
{
    
    PFUser *user = [PFUser user];
    user.email = self.signupVM.emailAddress;
    user.username = self.signupVM.username;
    user.password = self.signupVM.password;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self showHome];
        }else{
            [TSMessage showNotificationWithTitle:NSLocalizedString(@"Login Failed", nil)
                                        subtitle:error.localizedDescription
                                            type:TSMessageNotificationTypeError];
        }
        
    }];
}

- (void)showHome
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate showHome];
}


@end

@interface SignupVM () {
    NSString *_validationError;
}

@end

@implementation SignupVM

- (BOOL)isValid
{
    // TODO: improve
    
    
    if (self.emailAddress.length < 8) {
        _validationError = @"Invalid email address.";
    }
        
    
    if (self.username.length < 8) {
        _validationError = @"Invalid username.";
        return NO;
    }
    
    NSCharacterSet * characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString: self.username];
    if([[NSCharacterSet alphanumericCharacterSet] isSupersetOfSet: characterSetFromTextField] == NO){
        return NO;
    }
    
    if (self.password.length < 8) {
        _validationError = @"Invalid password.";
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










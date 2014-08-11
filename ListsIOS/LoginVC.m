//
//  LoginVC.m
//  ListsIOS
//
//  Created by Pinuno on 8/7/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "LoginVC.h"
#import "AppDelegate.h"
#import "BZGFormField.h"
#import "TSMessage.h"

@interface LoginVC ()

@property (strong, nonatomic) LoginVM *loginVM;

@property (weak, nonatomic) IBOutlet BZGFormField *usernameField;
@property (weak, nonatomic) IBOutlet BZGFormField *passwordField;

- (void)login;
- (void)showHome;

@end

@implementation LoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    self.usernameField.textField.placeholder = @"Username";
    self.passwordField.textField.placeholder = @"Password";
    self.passwordField.textField.secureTextEntry = YES;
    
    [self.usernameField setTextValidationBlock:^BOOL(BZGFormField *field, NSString *text) {
        
        // TODO: do validation
        
        if (text.length < 8) {
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
    
    [self.usernameField.textField addTarget:self action:@selector(usernameFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordField.textField addTarget:self action:@selector(passwordFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.loginVM = [LoginVM new];
    self.loginVM.username = self.usernameField.textField.text;
    self.loginVM.password = self.passwordField.textField.text;
    
}

#pragma mark - Action Methods

- (IBAction)cancelButtonTapped:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)usernameFieldChanged:(id)sender
{
    self.loginVM.username = self.usernameField.textField.text;
}

- (IBAction)passwordFieldChanged:(id)sender
{
    self.loginVM.password = self.passwordField.textField.text;
}

- (IBAction)loginButtonTapped:(id)sender
{
    if (self.loginVM.isValid) {
        [self login];
    }else{
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"Login Failed", nil)
                                    subtitle:self.loginVM.validationError
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

- (void)login
{
    [PFUser logInWithUsernameInBackground:self.loginVM.username
                                 password:self.loginVM.password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            [self showHome];
                                        } else {
                                            NSString *errorMessage = error.localizedDescription;
                                            switch (error.code) {
                                                case 101:   // kPFErrorObjectNotFound
                                                    errorMessage = @"Invalid login credentials.";
                                                    break;
                                                default:
                                                    break;
                                            }
                                            
                                            [TSMessage showNotificationWithTitle:NSLocalizedString(@"Login Failed", nil)
                                                                        subtitle:errorMessage
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

@interface LoginVM (){
    NSString *_validationError;
}

@end

@implementation LoginVM

- (BOOL)isValid
{
    // TODO: improve
    
    if (self.username.length < 8) {
        _validationError = @"Invalid username.";
        return NO;
    }
    
    if (self.username.length < 8) {
        _validationError = @"Invalid password.";
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







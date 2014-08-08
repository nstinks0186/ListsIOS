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

@implementation LoginVM

@end

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
    // TODO: validation
    BOOL valid = YES;
    if (valid) {
        [self login];
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
                                            DLog(@"code: %d", error.code);
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

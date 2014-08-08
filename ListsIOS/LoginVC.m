//
//  LoginVC.m
//  ListsIOS
//
//  Created by Pinuno on 8/7/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "LoginVC.h"
#import "AppDelegate.h"

@implementation LoginVM

@end

@interface LoginVC ()

@property (strong, nonatomic) LoginVM *loginVM;

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (void)login;
- (void)showHome;

@end

@implementation LoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loginVM = [LoginVM new];
    self.loginVM.username = self.usernameField.text;
    self.loginVM.password = self.passwordField.text;
    
}

#pragma mark - Action Methods

- (IBAction)usernameFieldChanged:(id)sender
{
    self.loginVM.username = self.usernameField.text;
}

- (IBAction)passwordFieldChanged:(id)sender
{
    self.loginVM.password = self.passwordField.text;
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
                                            
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                            [alert show];
                                            
                                        }
                                    }];
}

- (void)showHome
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate showHome];
}

@end

//
//  SignupVC.m
//  ListsIOS
//
//  Created by Pinuno on 8/7/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "SignupVC.h"
#import "AppDelegate.h"

@implementation SignupVM

@end

@interface SignupVC ()

@property (weak, nonatomic) IBOutlet UITextField *emailAddressField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (void)signup;
- (void)showHome;

@end

@implementation SignupVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.signupVM = [[SignupVM alloc] init];
    self.signupVM.emailAddress = self.emailAddressField.text;
    self.signupVM.username = self.usernameField.text;
    self.signupVM.password = self.passwordField.text;
}

#pragma mark - Action Methods

- (IBAction)emailAddressFieldChanged:(id)sender
{
    self.signupVM.emailAddress = self.emailAddressField.text;
}

- (IBAction)usernameFieldChanged:(id)sender
{
    self.signupVM.username = self.usernameField.text;
}

- (IBAction)passwordFieldChanged:(id)sender
{
    self.signupVM.password = self.passwordField.text;
}

- (IBAction)signupButtonTapped:(id)sender
{
    // TODO: validation
    BOOL valid = true;
    if (valid) {
        [self signup];
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
        DLog(@"succeed: %d",succeeded);
        DLog(@"error: %@",error);
        
        if (!error) {
            [self showHome];
        }else{
            
        }
        
    }];
}

- (void)showHome
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ECSlidingVC"];
}


@end








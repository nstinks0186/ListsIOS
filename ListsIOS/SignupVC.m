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
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

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
    
    // setup GAnalytics tracker
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"SignupVC"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    [TSMessage setDefaultViewController:self];
    
    self.emailAddressField.textField.placeholder = @"Email Address";
    self.emailAddressField.textField.delegate = self;
    self.usernameField.textField.placeholder = @"Username";
    self.usernameField.textField.delegate = self;
    self.passwordField.textField.placeholder = @"Password";
    self.passwordField.textField.delegate = self;
    self.passwordField.textField.secureTextEntry = YES;
    
    [self.emailAddressField setTextValidationBlock:^BOOL(BZGFormField *field, NSString *text) {
        self.signupVM.emailAddress = text;
        return self.signupVM.isEmailAddressValid;
    }];
    [self.usernameField setTextValidationBlock:^BOOL(BZGFormField *field, NSString *text) {
        self.signupVM.username = text;
        return self.signupVM.isUsernameValid;
    }];
    [self.passwordField setTextValidationBlock:^BOOL(BZGFormField *field, NSString *text) {
        self.signupVM.password = text;
        return self.signupVM.isPasswordValid;
    }];
    
    self.signupVM = [[SignupVM alloc] init];
    self.signupVM.emailAddress = self.emailAddressField.textField.text;
    self.signupVM.username = self.usernameField.textField.text;
    self.signupVM.password = self.passwordField.textField.text;
}

#pragma mark - Action Methods

- (IBAction)cancelButtonTapped:(id)sender
{
    [self.view endEditing:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
            [self.view endEditing:YES];
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










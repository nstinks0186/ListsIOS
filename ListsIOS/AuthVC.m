//
//  AuthVC.m
//  ListsIOS
//
//  Created by Pinuno Fuentes on 8/7/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "AuthVC.h"
#import "AppDelegate.h"
#import "BButton.h"
#import "TSMessage.h"

@interface AuthVC ()

@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;
@property (weak, nonatomic) IBOutlet BButton *facebookLoginButton;
@property (weak, nonatomic) IBOutlet BButton *signupButton;
@property (weak, nonatomic) IBOutlet BButton *loginButton;

@end

@implementation AuthVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [TSMessage setDefaultViewController:self];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.appNameLabel.textColor = Theme_MainColor;
    [self.facebookLoginButton addAwesomeIcon:FAFacebook beforeTitle:YES];
    
    if([PFUser currentUser]){
        [self showHome];
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Action Buttons

- (IBAction)facebookLoginButtonTapped:(id)sender
{
    [PFFacebookUtils logInWithPermissions:@[@"public_profile"] block:^(PFUser *user, NSError *error) {
        if (!user) {
            if (error) {
                [TSMessage showNotificationWithTitle:NSLocalizedString(@"Login Failed", nil)
                                            subtitle:error.localizedDescription
                                                type:TSMessageNotificationTypeError];
            }
        } else if (user.isNew) {
            [self showHome];
        } else {
            [self showHome];
        }
    }];

}

#pragma mark - Convenience Methods

- (void)showHome
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate showHome];
}

@end

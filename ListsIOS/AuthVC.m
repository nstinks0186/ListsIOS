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
#import <FacebookSDK/FacebookSDK.h>
#import "MBProgressHUD.h"

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

    // FB Setup
    [PFFacebookUtils initializeFacebook];
    
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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [PFFacebookUtils logInWithPermissions:@[@"public_profile", @"email"] block:^(PFUser *user, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!user) {
            if (error) {
                [LZAnalyticsBoss logError:error
                                    title:@"FB Login"
                                  message:@"AuthVC.FBLogin.Error"];
                [LZDebugVC showCTFeedbackForError:error];
                
                if ([error.domain isEqualToString:@"com.facebook.sdk"] && error.code == 2) {
                    [TSMessage showNotificationWithTitle:NSLocalizedString(@"Login Cancelled", nil)
                                                subtitle:@"User cancelled the login process."
                                                    type:TSMessageNotificationTypeWarning];
                }else{
                    [TSMessage showNotificationWithTitle:NSLocalizedString(@"Login Failed", nil)
                                                subtitle:error.localizedDescription
                                                    type:TSMessageNotificationTypeError];
                }
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

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

@interface AuthVC ()

@property (weak, nonatomic) IBOutlet BButton *facebookLoginButton;

@end

@implementation AuthVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.facebookLoginButton addAwesomeIcon:FAFacebook beforeTitle:YES];
    
//    if([PFUser currentUser]){
//        [self showHome];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Buttons

- (IBAction)facebookLoginButtonTapped:(id)sender
{
    [PFFacebookUtils logInWithPermissions:@[@"public_profile"] block:^(PFUser *user, NSError *error) {
        if (!user) {
            if (error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
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

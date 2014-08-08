//
//  MenuVC.m
//  ListsIOS
//
//  Created by Pinuno on 8/6/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "MenuVC.h"
#import "AppDelegate.h"

@implementation MenuVC

#pragma mark - Action Methods

- (IBAction)unwindToMenuViewController:(UIStoryboardSegue *)segue
{
}

- (IBAction)signoutButtonTapped:(id)sender
{
    [self signout];
}

#pragma mark - Convenience Methods

- (void)signout
{
    [PFUser logOut];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate showAuth];
}

@end

@implementation MenuNavVC

#pragma mark - Action Methods

- (IBAction)unwindToMenuViewController:(UIStoryboardSegue *)segue
{
}

@end

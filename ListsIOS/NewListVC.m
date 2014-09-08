//
//  NewListVC.m
//  ListsIOS
//
//  Created by Pinuno on 9/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "NewListVC.h"

@interface NewListVC ()

@end

@implementation NewListVC

#pragma mark Action Methods

- (IBAction)cancelButtonTapped:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonTapped:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end

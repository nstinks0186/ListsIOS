//
//  MenuVC.m
//  ListsIOS
//
//  Created by Pinuno on 8/6/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "MenuVC.h"
#import "AppDelegate.h"
#import "ListVC.h"

@implementation MenuVC

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ToDoSegue"]) {
        UINavigationController *navVC = (UINavigationController *)segue.destinationViewController;
        ListVC *vc = (ListVC *)navVC.viewControllers.firstObject;
        vc.type = ListVTypeTodo;
    }
    else if ([segue.identifier isEqualToString:@"ToBuySegue"]) {
        UINavigationController *navVC = (UINavigationController *)segue.destinationViewController;
        ListVC *vc = (ListVC *)navVC.viewControllers.firstObject;
        vc.type = ListVTypeTobuy;
    }
    else if ([segue.identifier isEqualToString:@"ToNoteSegue"]) {
        UINavigationController *navVC = (UINavigationController *)segue.destinationViewController;
        ListVC *vc = (ListVC *)navVC.viewControllers.firstObject;
        vc.type = ListVTypeTonote;
    }
}

#pragma mark - Action Methods

- (IBAction)unwindToMenuViewController:(UIStoryboardSegue *)segue
{
}

@end

@implementation MenuNavVC

#pragma mark - Action Methods

- (IBAction)unwindToMenuViewController:(UIStoryboardSegue *)segue
{
}

@end

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
    if (![segue.identifier isEqualToString:@"SettingsSegue"]) {
        UINavigationController *navVC = (UINavigationController *)segue.destinationViewController;
        ListVC *vc = (ListVC *)navVC.viewControllers.firstObject;
        vc.dueDateFilter = ([segue.identifier isEqualToString:@"TodaySegue"] ? ListVDueDateFilterToday :
                            ([segue.identifier isEqualToString:@"TomorrowSegue"] ? ListVDueDateFilterTomorrow :
                             ([segue.identifier isEqualToString:@"WeekendSegue"] ? ListVDueDateFilterWeekend : ListVDueDateFilterNone)));
    }
}

#pragma mark - Action Methods

- (IBAction)settingsButtonTapped:(id)sender
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UIViewController *rootVC = appDelegate.window.rootViewController;
    UINavigationController *navVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsNavVC"];
    [rootVC presentViewController:navVC animated:YES completion:nil];
}

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

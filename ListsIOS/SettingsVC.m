//
//  SettingsVC.m
//  ListsIOS
//
//  Created by Pinuno on 8/7/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "SettingsVC.h"
#import "CTFeedbackViewController.h"

@implementation SettingsVC

#pragma mark - UITableViewControllerDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 1) {
        CTFeedbackViewController *feedbackViewController = [CTFeedbackViewController controllerWithTopics:CTFeedbackViewController.defaultTopics localizedTopics:CTFeedbackViewController.defaultLocalizedTopics];
        feedbackViewController.toRecipients = @[@"nstinks0186@gmail.com"];
        feedbackViewController.useHTML = NO;
        [self.navigationController pushViewController:feedbackViewController animated:YES];
    }
}

@end

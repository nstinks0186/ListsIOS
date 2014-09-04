//
//  SettingsVC.m
//  ListsIOS
//
//  Created by Pinuno on 8/7/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "SettingsVC.h"
#import "CTFeedbackViewController.h"
#import "AppDelegate.h"
#import "WebVC.h"

@interface SettingsVC () {
    NSInteger _debugModeTriggerCount;
}

@end

@implementation SettingsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _debugModeTriggerCount = 0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebVC *webVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"TermsOfUseSegue"]) {
        webVC.webVM = [WebVM DefaultEULAWebVM];
    }
    else if([segue.identifier isEqualToString:@"AcknowledgementsSegue"]){
        webVC.webVM = [WebVM DefaultAcknowledgementsWebVM];
    }
}

#pragma mark Action Methods

- (IBAction)doneButtonTapped:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signoutButtonTapped:(id)sender
{
    [PFUser logOut];
    
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate showAuth];
    }];
    
}

#pragma mark UITableViewDataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.reuseIdentifier isEqualToString:@"VersionCellIdentifier"]){
        NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
        NSString *build = infoDictionary[(NSString*)kCFBundleVersionKey];
        cell.detailTextLabel.text = build;
    }
    
    return cell;
}

#pragma mark UITableViewControllerDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([cell.reuseIdentifier isEqualToString:@"FeedbackCellIdentifier"]) {
        CTFeedbackViewController *feedbackViewController = [CTFeedbackViewController controllerWithTopics:CTFeedbackViewController.defaultTopics localizedTopics:CTFeedbackViewController.defaultLocalizedTopics];
        feedbackViewController.toRecipients = @[@"nstinks0186@gmail.com"];
        feedbackViewController.useHTML = NO;
        [self.navigationController pushViewController:feedbackViewController animated:YES];
    }
    else if ([cell.reuseIdentifier isEqualToString:@"VersionCellIdentifier"] && !LZDebugMode){
        if (_debugModeTriggerCount++ == 10) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Debug Mode"
                                                            message:@"Do you want to help the app developer in improving this app?"
                                                           delegate:self
                                                  cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
            [alert show];
        }
    }
}

#pragma mark UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.cancelButtonIndex != buttonIndex) {
        LZDebugModeOn;
    }
}


@end

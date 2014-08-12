//
//  LicensesVC.m
//  ListsIOS
//
//  Created by Pinuno on 8/12/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "LicensesVC.h"
#import "WebVC.h"

@interface LicensesVC ()

@end

@implementation LicensesVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebVC *webVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"BButtonSegue"]) {
        webVC.webVM = [WebVM BButtonWebVM];
    }
    else if ([segue.identifier isEqualToString:@"BZGFormFieldSegue"]) {
        webVC.webVM = [WebVM BZGFormFieldWebVM];
    }
    else if ([segue.identifier isEqualToString:@"CTFeedbackSegue"]) {
        webVC.webVM = [WebVM CTFeedbackWebVM];
    }
    else if ([segue.identifier isEqualToString:@"ECSlidingViewControllerSegue"]) {
        webVC.webVM = [WebVM ECSlidingViewControllerWebVM];
    }
    else if ([segue.identifier isEqualToString:@"HexColorSegue"]) {
        webVC.webVM = [WebVM HexColorWebVM];
    }
    else if ([segue.identifier isEqualToString:@"TSMessagesSegue"]) {
        webVC.webVM = [WebVM TSMessagesWebVM];
    }
}

@end

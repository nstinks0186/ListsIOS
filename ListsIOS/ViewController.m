//
//  ViewController.m
//  ListsIOS
//
//  Created by Pinuno on 8/6/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

- (IBAction)skipButtonTapped:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Buttons

- (IBAction)skipButtonTapped:(id)sender
{
    [self _showHomeVC];
}

#pragma mark - Util Methods

- (void)_showHomeVC
{    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ECSlidingVC"];
}

@end

//
//  LZDebug.m
//  ListsIOS
//
//  Created by Pinuno on 9/3/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "LZDebug.h"
#import "CTFeedbackViewController.h"

@implementation LZDebug

+ (LZDebug *)sharedInstance
{
    static LZDebug *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[LZDebug alloc] init];
    });
    
    return _sharedInstance;
}

@end

@implementation UIViewController (LZDebug)

- (void)showCTFeedbackForError:(NSError *)error
{
    if (!LZDebugMode) return;
    
    CTFeedbackViewController *feedbackViewController = [CTFeedbackViewController controllerWithTopics:CTFeedbackViewController.defaultTopics localizedTopics:CTFeedbackViewController.defaultLocalizedTopics];
    feedbackViewController.toRecipients = @[@"nstinks0186@gmail.com"];
    feedbackViewController.useHTML = NO;
    
    if (error) {
        feedbackViewController.additionalDiagnosticContent = [NSString stringWithFormat:@"%@\n %@",error.localizedDescription,error];
    }
    
    UIBarButtonItem *cancel =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                           target:self
                                                                           action:@selector(hideCTFeedback:)];
    feedbackViewController.navigationItem.leftBarButtonItem = cancel;
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    
    if (self.navigationController) {
        [self.navigationController presentViewController:navVC
                                                animated:NO
                                              completion:nil];
    }else{
        [self presentViewController:navVC
                           animated:NO
                         completion:nil];
    }
}

- (void)hideCTFeedback:(id)sender
{
    if (self.navigationController) {
        [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

@end

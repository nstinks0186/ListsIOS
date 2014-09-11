//
//  MenuVC.h
//  ListsIOS
//
//  Created by Pinuno on 8/6/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuVM.h"

@interface MenuVC : UITableViewController <MenuVMDelegate>

- (IBAction)unwindToMenuViewController:(UIStoryboardSegue *)segue;

@end

@interface MenuNavVC : UINavigationController

- (IBAction)unwindToMenuViewController:(UIStoryboardSegue *)segue;

@end

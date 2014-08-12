//
//  ListVC.h
//  ListsIOS
//
//  Created by Pinuno on 8/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListVM.h"


@interface ListVC : UITableViewController <ListVMDelegate>

@property (nonatomic) ListVType type;
@property (strong, nonatomic) ListVM *listVM;

@end

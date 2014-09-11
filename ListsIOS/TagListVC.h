//
//  TagListVC.h
//  ListsIOS
//
//  Created by Pinuno on 9/4/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagListVM.h"

@class LZListItem;

@interface TagListVC : UITableViewController <TagListVMDelegate>

@property (weak, nonatomic) LZListItem *listItem;

@end

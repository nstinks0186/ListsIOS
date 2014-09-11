//
//  ListVC.h
//  ListsIOS
//
//  Created by Pinuno on 8/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListVM.h"
#import "ListVCell.h"


@interface ListVC : UITableViewController <ListVMDelegate, ListVCellDelegate>

@property (strong, nonatomic) ListVM *listVM;

// filters
@property (nonatomic) ListVDueDateFilter dueDateFilter;
@property (copy, nonatomic) NSArray *tagListFilter;

@end

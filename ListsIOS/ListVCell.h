//
//  ListVCell.h
//  ListsIOS
//
//  Created by Pinuno on 8/26/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListVCellM.h"
#import "THDatePickerViewController.h"

@class ListVCell;
@protocol ListVCellDelegate <NSObject>

- (void)listVCellDidUpdateDueDate:(ListVCell *)cell;

@end

@interface ListVCell : UITableViewCell <UIActionSheetDelegate, THDatePickerDelegate>

@property (strong, nonatomic) ListVCellM *listVCellM;
@property (weak, nonatomic) UIViewController <ListVCellDelegate> *viewController;

- (void)setListItem:(LZListItem *)listItem;

@end

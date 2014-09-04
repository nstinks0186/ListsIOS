//
//  ListVCell.m
//  ListsIOS
//
//  Created by Pinuno on 8/26/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "ListVCell.h"
#import "UIViewController+KNSemiModal.h"



@interface ListVCell () {
    PFBooleanResultBlock resultBlock;
}


@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) THDatePickerViewController *datePicker;

@end

@implementation ListVCell

- (void)awakeFromNib
{
    self.listVCellM = [[ListVCellM alloc] init];
    
    __weak typeof(self) weakSelf = self;
    resultBlock = ^(BOOL succeeded, NSError *error) {
        if (error) {
            [LZAnalyticsBoss logError:error
                                title:@"LZListItem UpdateDate"
                              message:@"LZListItem.UpdateDate.Error"];
        }
        
        if ([weakSelf.viewController respondsToSelector:@selector(listVCellDidUpdateDueDate:)]) {
            [weakSelf.viewController listVCellDidUpdateDueDate:weakSelf];
        }
    };
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark Action Methods

- (IBAction)calendarButtonTapped:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:self.listVCellM.destructiveButtonTitle
                                                    otherButtonTitles:self.listVCellM.dueTodayTitle, self.listVCellM.dueTomorrowTitle, self.listVCellM.dueWeekendTitle, self.listVCellM.otherTitle, nil];
    actionSheet.delegate = self;
    [actionSheet showInView:self.viewController.view];
}

#pragma mark Properties

- (void)setListItem:(LZListItem *)listItem
{
    self.listVCellM.listItem = listItem;
    [self updateSubviews];
}

#pragma mark UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // TODO: analytics event here
    
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        [self.listVCellM.listItem updateDueDate:nil withBlock:resultBlock];
    }
    else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:self.listVCellM.dueTodayTitle]) {
        NSDate *today = [NSDate date];
        [self.listVCellM.listItem updateDueDate:today withBlock:resultBlock];
    }
    else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:self.listVCellM.dueTomorrowTitle]) {
        NSDate *tomorrow = [NSDate dateTomorrow].dateWithOutTime;
        [self.listVCellM.listItem updateDueDate:tomorrow withBlock:resultBlock];
    }
    else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:self.listVCellM.dueWeekendTitle]) {
        NSDate *thisSaturday = [NSDate dateThisSaturday];
        [self.listVCellM.listItem updateDueDate:thisSaturday withBlock:resultBlock];
    }
    else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:self.listVCellM.otherTitle]) {
        self.datePicker = [THDatePickerViewController datePicker];
        self.datePicker.date = self.listVCellM.listItem.dueDate;
        self.datePicker.delegate = self;
        self.datePicker.currentDateColor = Theme_MainColor;
        self.datePicker.selectedBackgroundColor = [UIColor lightGrayColor];
        
        [self.viewController presentSemiViewController:self.datePicker
                                           withOptions:@{
                                                         KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                         KNSemiModalOptionKeys.animationDuration : @(0.2),
                                                         KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                         }];
    }
}

#pragma mark THDatePickerDelegate Methods

-(void)datePickerDonePressed:(THDatePickerViewController *)datePicker
{
    [self.listVCellM.listItem updateDueDate:datePicker.date withBlock:resultBlock];
    [self.viewController dismissSemiModalView];
}

-(void)datePickerCancelPressed:(THDatePickerViewController *)datePicker
{
    [self.viewController dismissSemiModalView];
}

#pragma mark Convenience Methods

- (void)updateSubviews
{
    self.descriptionLabel.text = self.listVCellM.description;
    self.tintColor =  self.listVCellM.tintColor;
}

@end





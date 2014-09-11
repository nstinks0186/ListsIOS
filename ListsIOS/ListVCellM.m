//
//  ListVCellM.m
//  ListsIOS
//
//  Created by Pinuno on 9/2/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "ListVCellM.h"
#import "LZTag.h"

@interface LZListItem (ListVCellM)

- (NSString *)dueDateShortDateFormattedString;
- (NSString *)dueDateLZFormattedString;

@end

@implementation ListVCellM

#pragma mark - Getters

- (NSString *)description
{
    return (self.listItem && self.listItem.description.length ? self.listItem.description : @"");
}

- (NSString *)tagList
{
    return (self.listItem && self.listItem.customTagList && self.listItem.customTagList.count
            ? ((LZTag *)[self.listItem.customTagList firstObject]).description
            : @"");
}

- (UIColor *)tintColor
{
    return (self.listItem.isDueToday ? [UIColor redColor] :
            (self.listItem.dueDate == nil ? [UIColor grayColor] :
             Theme_MainColor));
}

- (NSString *)destructiveButtonTitle
{
    return (self.listItem.dueDate ? [NSString stringWithFormat:@"Remove Due Date (%@)",self.listItem.dueDateShortDateFormattedString] : nil);
}

- (NSString *)dueTodayTitle
{
    return @"Due Today";
}

- (NSString *)dueTomorrowTitle
{
    return @"Due Tomorrow";
}

- (NSString *)dueWeekendTitle
{
    return @"Due Weekend";
}

- (NSString *)otherTitle
{
    return @"Other...";
}

@end

@implementation LZListItem (ListVCellM)

- (NSString *)dueDateShortDateFormattedString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.doesRelativeDateFormatting = YES;
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    
    return (self.dueDate ? [dateFormatter stringFromDate:self.dueDate] :
            @"");
}

- (NSString *)dueDateLZFormattedString
{
    return (self.isDueToday ? @"Today" :
            (self.isDueTomorrow ? @"Tomorrow" :
             (self.isDueWeekend ? @"Weekend" :
              (self.dueDate ? [self dueDateShortDateFormattedString] :
               @"Someday"))));
}

@end




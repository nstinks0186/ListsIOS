//
//  ListVCellM.h
//  ListsIOS
//
//  Created by Pinuno on 9/2/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZListItem.h"

@interface ListVCellM : NSObject

@property (weak, nonatomic) LZListItem *listItem;

@property (readonly, nonatomic) NSString *description;
@property (readonly, nonatomic) NSString *tagList;
@property (readonly, nonatomic) UIColor *tintColor;

@property (readonly, nonatomic) NSString *destructiveButtonTitle;
@property (readonly, nonatomic) NSString *dueTodayTitle;
@property (readonly, nonatomic) NSString *dueTomorrowTitle;
@property (readonly, nonatomic) NSString *dueWeekendTitle;
@property (readonly, nonatomic) NSString *otherTitle;

@end

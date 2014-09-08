//
//  LZListItem.h
//  ListsIOS
//
//  Created by Pinuno on 8/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZObject.h"
#import "NSDate+Utilities.h"

typedef NS_ENUM(NSInteger, LZListItemStatus) {
    LZListItemStatusDefault = 0,
    LZListItemStatusArchived = 1
};

@interface LZListItem : LZObject

@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSMutableArray *tagList;
@property (strong, nonatomic) NSDate *dueDate;
@property (nonatomic) LZListItemStatus status;

// init
- (id)initWithDescription:(NSString *)description tagList:(NSArray *)tagList status:(LZListItemStatus)status dueDate:(NSDate *)dueDate;

// update
- (void)updateDueDate:(NSDate *)newDate withBlock:(PFBooleanResultBlock)block;
- (void)updateStatus:(LZListItemStatus)newStatus withBlock:(PFBooleanResultBlock)block;
- (void)updateTagList:(NSMutableArray *)tagList withBlock:(PFBooleanResultBlock)block;

// due date logic
- (BOOL)isDueToday;
- (BOOL)isDueTomorrow;
- (BOOL)isDueWeekend;
- (BOOL)isDueSomeday;

@end

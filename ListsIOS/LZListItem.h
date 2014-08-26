//
//  LZListItem.h
//  ListsIOS
//
//  Created by Pinuno on 8/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZObject.h"

typedef NS_ENUM(NSInteger, LZListItemStatus) {
    LZListItemStatusUnchecked,
    LZListItemStatusChecked
};

@interface LZListItem : LZObject

@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSMutableArray *tagList;
@property (strong, nonatomic) NSDate *dueDate;
@property (nonatomic) LZListItemStatus status;

- (id)initWithDescription:(NSString *)description tagList:(NSArray *)tagList status:(LZListItemStatus)status;
- (id)initWithDescription:(NSString *)description tagList:(NSArray *)tagList;

@end

//
//  ListVM.h
//  ListsIOS
//
//  Created by Pinuno on 8/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "LZListItem.h"


typedef NS_ENUM(NSUInteger, ListVMode) {
    ListVModeTodo,
    ListVModeTobuy
};

typedef NS_ENUM(NSUInteger, ListVDueDateFilter) {
    ListVDueDateFilterNone,
    ListVDueDateFilterToday,
    ListVDueDateFilterTomorrow,
    ListVDueDateFilterWeekend
};

@protocol ListVMDelegate;

@interface ListVM : NSObject

@property (nonatomic) ListVMode mode;
@property (nonatomic) ListVDueDateFilter dueDateFilter;

@property (readonly, nonatomic) NSMutableArray *itemList;
@property (strong, nonatomic) NSString *createItemDescription;

@property (weak, nonatomic) id<ListVMDelegate> delegate;

// getters
- (NSInteger)sectionCount;
- (NSInteger)rowCountForSection:(NSInteger)section;

// operation
- (void)doCreateItem;
- (void)fetchItemList:(BOOL)forceNetwork;
- (void)sortItemList;

@end

@protocol ListVMDelegate <NSObject>

- (void)listVMDidUpdateListItemList:(ListVM *)vm;

@end

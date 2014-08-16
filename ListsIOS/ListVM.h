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


typedef NS_ENUM(NSUInteger, ListVType) {
    ListVTypeTodo,
    ListVTypeTobuy,
    ListVTypeTonote,
    ListVTypeCustom
};

@protocol ListVMDelegate;

@interface ListVM : NSObject

@property (nonatomic) ListVType type;

@property (readonly, nonatomic) NSString *title;
@property (readonly, nonatomic) NSArray *tagList;
@property (readonly, nonatomic) NSMutableArray *itemList;
@property (strong, nonatomic) NSString *createItemDescription;

@property (weak, nonatomic) id<ListVMDelegate> delegate;

- (id)initWithType:(ListVType)type;

// getters
- (NSInteger)sectionCount;
- (NSInteger)rowCountForSection:(NSInteger)section;

// operation
- (void)doCreateItem;
- (void)doRemoveItem:(LZListItem *)item;
- (void)fetchItemList;

@end

@protocol ListVMDelegate <NSObject>

- (void)listVMDidUpdateListItemList:(ListVM *)vm;

@end

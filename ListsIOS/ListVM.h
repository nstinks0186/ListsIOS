//
//  ListVM.h
//  ListsIOS
//
//  Created by Pinuno on 8/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZListItem.h"


typedef NS_ENUM(NSUInteger, ListVType) {
    ListVTypeTodo,
    ListVTypeTobuy,
    ListVTypeTonote,
    ListVTypeCustom
};

@interface ListVM : NSObject

@property (nonatomic) ListVType type;
@property (readonly, nonatomic) NSMutableArray *lzListItemList;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *createItemDescription;

- (id)initWithType:(ListVType)type;

// getters
- (NSInteger)sectionCount;
- (NSInteger)rowCountForSection:(NSInteger)section;

// operation
- (void)doCreateItem;

@end

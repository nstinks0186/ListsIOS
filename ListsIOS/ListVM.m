//
//  ListVM.m
//  ListsIOS
//
//  Created by Pinuno on 8/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "ListVM.h"
#import "LZList.h"
#import "LZListItem.h"

@interface ListVM ()

@property (strong, nonatomic) NSMutableArray *lzListItemList;

@end


@implementation ListVM

- (id)initWithType:(ListVType)type
{
    self = [super init];
    if (self) {
        self.type = type;
        self.lzListItemList = [NSMutableArray array];
        
        [self initTitle];
    }
    return self;
}

#pragma mark - Convenience Methods

- (void)initTitle
{
    switch (self.type) {
        case ListVTypeTodo:
            self.title = @"To Do";
            break;
        case ListVTypeTobuy:
            self.title = @"To Buy";
            break;
        case ListVTypeTonote:
            self.title = @"To Note";
            break;
        default:
            self.title = @" ";
            break;
    }
}

#pragma mark - Getters

- (NSInteger)sectionCount
{
    return 0;
}

- (NSInteger)rowCountForSection:(NSInteger)section
{
    return self.lzListItemList.count;
}

#pragma mark - Operations

- (void)doCreateItem
{
    if (self.createItemDescription.length <= 0) {
        return;
    }
    
    LZListItem *newItem = [[LZListItem alloc] initWithDescription:self.createItemDescription];
    [self.lzListItemList addObject:newItem];
}

@end

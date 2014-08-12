//
//  ListVM.m
//  ListsIOS
//
//  Created by Pinuno on 8/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "ListVM.h"

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
    }
    return self;
}

#pragma mark - Convenience Methods

- (NSString *)title
{
    switch (self.type) {
        case ListVTypeTodo:
            return @"To Do";
        case ListVTypeTobuy:
            return @"To Buy";
        case ListVTypeTonote:
            return @"To Note";
        default:
            return @" ";
    }
}

- (NSArray *)tagList
{
    switch (self.type) {
        case ListVTypeTodo:
            return @[@"$TypeTodo"];
        case ListVTypeTobuy:
            return @[@"$TypeTobuy"];
        case ListVTypeTonote:
            return @[@"$TypeTonote"];
        default:
            return @[@""];
    }
}

#pragma mark - Getters

- (NSInteger)sectionCount
{
    return 1;
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
    
    LZListItem *newItem = [[LZListItem alloc] initWithDescription:self.createItemDescription tagList:self.tagList];
    [self.lzListItemList addObject:newItem];
    
    @synchronized(self){
        [newItem saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                if ([self.delegate respondsToSelector:@selector(listVMDidUpdateListItemList:)]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.delegate listVMDidUpdateListItemList:self];
                    });
                }
            } else {
                [LZObject processError:error];
            }
        }];
    }
}

- (void)fetchItemList
{
    @synchronized(self) {
        PFQuery *query = [PFQuery queryWithClassName:@"Item"];
        query.cachePolicy = kPFCachePolicyCacheThenNetwork; // kPFCachePolicyNetworkElseCache;
        [query whereKey:@"owner" equalTo:[PFUser currentUser]];
        [query whereKey:@"status" equalTo:@(LZListItemStatusUnchecked)];
        [query whereKey:@"tagList" containsAllObjectsInArray:self.tagList];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                [self.lzListItemList removeAllObjects];
                for (PFObject *object in objects) {
                    LZListItem *item = [[LZListItem alloc] initWithPFObject:object];
                    [self.lzListItemList addObject:item];
                }
                
                if ([self.delegate respondsToSelector:@selector(listVMDidUpdateListItemList:)]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.delegate listVMDidUpdateListItemList:self];
                    });
                }
            } else {
                [LZObject processError:error];
            }
        }];
    }
}

@end

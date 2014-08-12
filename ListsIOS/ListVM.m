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
    
    LZListItem *newItem = [[LZListItem alloc] initWithDescription:self.createItemDescription];
    [self.lzListItemList addObject:newItem];
}

- (void)fetchItemList
{
    @synchronized(self) {
        PFQuery *query = [PFQuery queryWithClassName:@"Item"];
        query.cachePolicy = kPFCachePolicyCacheThenNetwork; // kPFCachePolicyNetworkElseCache;
        [query whereKey:@"owner" equalTo:[PFUser currentUser]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
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
                DLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
}

@end

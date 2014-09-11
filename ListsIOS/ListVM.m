//
//  ListVM.m
//  ListsIOS
//
//  Created by Pinuno on 8/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "ListVM.h"
#import "LZTag.h"

@interface ListVM ()

@property (readonly, nonatomic) NSArray *tagList;
@property (strong, nonatomic) NSMutableArray *itemList;

@end


@implementation ListVM

- (id)init
{
    self = [super init];
    if (self) {
        self.itemList = [NSMutableArray array]; 
    }
    return self;
}

#pragma mark - Convenience Methods

- (NSString *)title
{
    switch (self.mode) {
        case ListVModeTodo:
            return @"To Do";
        case ListVModeTobuy:
            return @"To Buy";
        default:
            return @" ";
    }
}

- (NSArray *)tagList
{
    switch (self.mode) {
        case ListVModeTodo:
            return @[[LZTag typeTodo].pfObject];
        case ListVModeTobuy:
            return @[[LZTag typeTobuy].pfObject];
        default:
            return @[];
    }
}

#pragma mark - Getters

- (NSInteger)sectionCount
{
    return 1;
}

- (NSInteger)rowCountForSection:(NSInteger)section
{
    return self.itemList.count;
}

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    LZListItem *item = [self.itemList objectAtIndex:indexPath.row];
    return (item.hasCustomTag ? @"ListItemWithTagCellIdentifier" : @"ListItemCellIdentifier");
}

#pragma mark - Operations

- (void)doCreateItem
{
    if (self.createItemDescription.length <= 0) {
        return;
    }
    
    LZListItem *newItem = [[LZListItem alloc] initWithDescription:self.createItemDescription
                                                          tagList:self.tagList
                                                           status:LZListItemStatusDefault
                                                          dueDate:(self.dueDateFilter == ListVDueDateFilterTomorrow ? [NSDate dateTomorrow].dateWithOutTime :
                                                                   (self.dueDateFilter == ListVDueDateFilterWeekend ? [NSDate dateThisSaturday] :
                                                                    [NSDate date]))];
    
    [self.itemList insertObject:newItem atIndex:0];
    
    @synchronized(self){
        [newItem saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                if ([self.delegate respondsToSelector:@selector(listVMDidUpdateListItemList:)]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.delegate listVMDidUpdateListItemList:self];
                    });
                }
            } else {
            }
        }];
    }
}

- (void)fetchItemList:(BOOL)forceNetwork
{
    @synchronized(self) {
        PFQuery *query = [PFQuery queryWithClassName:@"Item"];
        query.cachePolicy = (forceNetwork ? kPFCachePolicyNetworkElseCache : kPFCachePolicyNetworkElseCache);
        [query whereKey:@"owner" equalTo:[PFUser currentUser]];
        [query whereKey:@"status" equalTo:@(LZListItemStatusDefault)];
        [query whereKey:@"tagList" containsAllObjectsInArray:self.tagList];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                [self.itemList removeAllObjects];
                for (PFObject *object in objects) {
                    LZListItem *item = [[LZListItem alloc] initWithPFObject:object];
                    
                    if (self.dueDateFilter == ListVDueDateFilterToday && !item.isDueToday) { continue; }
                    else if (self.dueDateFilter == ListVDueDateFilterTomorrow && !item.isDueTomorrow) { continue; }
                    else if (self.dueDateFilter == ListVDueDateFilterWeekend && !item.isDueWeekend) { continue; }
                    
                    if (self.tagListFilter) {
//                        BOOL tagFilterSatisfied = NO;
//                        for (LZTag *tag in self.tagListFilter) {
//                            if ([item isTagged:tag.description]) {
//                                tagFilterSatisfied = YES;
//                                break;
//                            }
//                        }
//                        if (!tagFilterSatisfied) continue;
                    }
                    
                    [self.itemList insertObject:item atIndex:0];
                }
                
                if ([self.delegate respondsToSelector:@selector(listVMDidUpdateListItemList:)]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.delegate listVMDidUpdateListItemList:self];
                    });
                }
            } else {
                [LZAnalyticsBoss logError:error
                                    title:@"Parse.APICall"
                                  message:@"Parse.APICall.Error"];
            }
        }];
    }
}

- (void)sortItemList
{
    NSArray *sortedList = [self.itemList sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        return [([(LZListItem*)a dueDate] != nil ? [(LZListItem*)a dueDate] : [NSDate dateWithTimeIntervalSinceNow:999999999]) compare:([(LZListItem*)b dueDate] != nil ? [(LZListItem*)b dueDate] : [NSDate dateWithTimeIntervalSinceNow:999999999])];
    }];
    self.itemList = [NSMutableArray arrayWithArray:sortedList];
}

@end






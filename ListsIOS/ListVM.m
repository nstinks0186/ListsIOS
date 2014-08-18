//
//  ListVM.m
//  ListsIOS
//
//  Created by Pinuno on 8/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "ListVM.h"
#import "NSDate+Utilities.h"

@interface ListVM ()

@property (strong, nonatomic) NSMutableArray *itemList;

@end


@implementation ListVM

- (id)initWithType:(ListVType)type
{
    self = [super init];
    if (self) {
        self.type = type;
        self.itemList = [NSMutableArray array];
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
    return self.itemList.count;
}

#pragma mark - Operations

- (void)doCreateItem
{
    if (self.createItemDescription.length <= 0) {
        return;
    }
    
    LZListItem *newItem = [[LZListItem alloc] initWithDescription:self.createItemDescription tagList:self.tagList];
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
                [LZObject processError:error];
            }
        }];
    }
}

- (void)doRemoveItem:(LZListItem *)item
{
    [self.itemList removeObject:item];
    
    @synchronized(self){
        [item deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
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
                [self.itemList removeAllObjects];
                for (PFObject *object in objects) {
                    LZListItem *item = [[LZListItem alloc] initWithPFObject:object];
                    [self.itemList insertObject:item atIndex:0];
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

@implementation LZListItem (ListVM)

- (NSString *)dueDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.doesRelativeDateFormatting = YES;
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    
    return (self.isDueToday ? @"Today" :
            (self.isDueTomorrow ? @"Tomorrow" :
             (self.isDueWeekend ? @"Weekend" :
              (self.dueDate ? [dateFormatter stringFromDate:self.dueDate] :
               @"Someday"))));
}

#pragma mark - Due date logic

- (BOOL)isDueToday
{
    return (self.dueDate && (self.dueDate.isToday || self.dueDate.isInPast));
}

- (BOOL)isDueTomorrow
{
    return (self.dueDate && self.dueDate.isTomorrow);
}
- (BOOL)isDueWeekend
{
    if (self.dueDate && !self.dueDate.isInPast && self.dueDate.isTypicallyWeekend) {
        NSDate *today = [NSDate date];
        return ([today daysBeforeDate:self.dueDate] < 7);
    }
    return NO;
}

- (BOOL)isDueSomeday
{
    return (!self.isDueToday && !self.isDueTomorrow && !self.isDueWeekend);
}

@end






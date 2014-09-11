//
//  MenuVM.m
//  ListsIOS
//
//  Created by Pinuno on 9/10/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "MenuVM.h"
#import "LZTag.h"

@interface MenuVM ()

@property (strong, nonatomic) NSMutableArray *tagList;

@end

@implementation MenuVM

#pragma mark Getters

- (NSInteger)sectionCount
{
    return 1;
}

- (NSInteger)rowCountForSection:(NSInteger)section
{
    return 4 + self.tagList.count;
}

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row == 0 ? @"AllItemsCellIdentifier" :
            (indexPath.row >= 1 && indexPath.row <= 3 ? @"DueDateCellIdentifier" :
             (indexPath.row > 3 ? @"TagCellIdentifier" :
              @"")));
}

- (NSString *)cellTitleForIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row == 0 ? @"All Items" :
            (indexPath.row == 1 ? @"Today" :
             (indexPath.row == 2 ? @"Tomorrow" :
              (indexPath.row == 3 ? @"Weekend" :
               (indexPath.row > 3 ? [self tagCellTitleForIndexPath:indexPath] :
                @"")))));
}

- (NSString *)tagCellTitleForIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row-4;
    LZTag *tag = [self.tagList objectAtIndex:index];
    return tag.description;
}

- (ListVDueDateFilter)dueDateFilterForIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row == 1 ? ListVDueDateFilterToday :
            (indexPath.row == 2 ? ListVDueDateFilterTomorrow :
             (indexPath.row == 3 ? ListVDueDateFilterWeekend :
              ListVDueDateFilterNone)));
}

- (NSArray *)tagListFilterForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 4) {
        NSInteger index = indexPath.row-4;
        return @[[self.tagList objectAtIndex:index]];
    }
    return nil;
}

#pragma mark Operations

- (void)fetchTagList:(BOOL)forceNetwork
{
    @synchronized(self) {
        PFQuery *query = [PFQuery queryWithClassName:@"Tag"];
        query.cachePolicy = (forceNetwork ? kPFCachePolicyNetworkElseCache : kPFCachePolicyCacheElseNetwork);
        [query whereKey:@"owner" equalTo:[PFUser currentUser]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                if (!self.tagList) {
                    self.tagList = [NSMutableArray array];
                }else{
                    [self.tagList removeAllObjects];
                }
                
                for (PFObject *object in objects) {
                    LZTag *tag = [[LZTag alloc] initWithPFObject:object];
                    [self.tagList addObject:tag];
                }
                
                if ([self.delegate respondsToSelector:@selector(menuVMDidUpdateTagList:)]) {
                    [self.delegate menuVMDidUpdateTagList:self];
                }
            } else {
                [LZAnalyticsBoss logError:error
                                    title:@"Parse.APICall"
                                  message:@"Parse.APICall.Error"];
            }
        }];
    }
}

#pragma mark Convenience Methods

@end

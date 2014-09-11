//
//  MenuVM.m
//  ListsIOS
//
//  Created by Pinuno on 9/10/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "MenuVM.h"
#import "LZTag.h"

@implementation MenuVM

#pragma mark Getters

- (NSInteger)sectionCount
{
    return 1;
}

- (NSInteger)rowCountForSection:(NSInteger)section
{
    return 4;
}

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row == 0 ? @"AllItemsCellIdentifier" :
            (indexPath.row >= 1 && indexPath.row <= 3 ? @"DueDateCellIdentifier" :
             @""));
}

- (NSString *)cellTitleForIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row == 0 ? @"All Items" :
            (indexPath.row == 1 ? @"Today" :
             (indexPath.row == 2 ? @"Tomorrow" :
              (indexPath.row == 3 ? @"Weekend" :
               @""))));
}

#pragma mark Operations

- (void)fetchTagList:(BOOL)forceNetwork
{
    @synchronized(self) {
        PFQuery *query = [PFQuery queryWithClassName:@"Tag"];
        query.cachePolicy = (forceNetwork ? kPFCachePolicyNetworkElseCache : kPFCachePolicyNetworkElseCache);
        [query whereKey:@"owner" equalTo:[PFUser currentUser]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                
                for (PFObject *object in objects) {
                    LZTag *item = [[LZTag alloc] initWithPFObject:object];
                    NSLog(@"Tag: %@",item.description);
                }
            } else {
                [LZAnalyticsBoss logError:error
                                    title:@"Parse.APICall"
                                  message:@"Parse.APICall.Error"];
            }
        }];
    }
}

@end

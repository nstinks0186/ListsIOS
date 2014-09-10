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

//
//  LZListItem.m
//  ListsIOS
//
//  Created by Pinuno on 8/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "LZListItem.h"

@implementation LZListItem

- (id)initWithPFObject:(PFObject *)pfObject
{
    self = [super initWithPFObject:pfObject];
    if (self) {
        self.description = pfObject[@"description"];
        self.tagList = [NSMutableArray arrayWithArray:pfObject[@"tagList"]];
        self.status = [(NSNumber *)pfObject[@"status"] integerValue];
    }
    return self;
}

- (id)initWithDescription:(NSString *)description tagList:(NSArray *)tagList status:(LZListItemStatus)status
{
    PFObject *pfObject = [PFObject objectWithClassName:@"Item"];
    pfObject[@"owner"] = [PFUser currentUser];
    pfObject[@"description"] = description.copy;
    pfObject[@"tagList"] = tagList.copy;
    pfObject[@"status"] = @(status);
    
    return [self initWithPFObject:pfObject];
}

- (id)initWithDescription:(NSString *)description tagList:(NSArray *)tagList
{
    return [self initWithDescription:description tagList:tagList status:LZListItemStatusUnchecked];
}

@end

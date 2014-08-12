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
    self = [super init];
    if (self) {
        self.description = pfObject[@"description"];
    }
    return self;
}

- (id)initWithDescription:(NSString *)description
{
    self = [super init];
    if (self) {
        self.description = description;
    }
    return self;
}

@end

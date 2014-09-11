//
//  LZList.m
//  ListsIOS
//
//  Created by Pinuno on 8/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "LZList.h"

@implementation LZList

- (id)initWithPFObject:(PFObject *)pfObject
{
    // this is the designated initializer
    
    self = [super initWithPFObject:pfObject];
    if (self) {
        self.description = pfObject[@"description"];
        self.tagList = [NSMutableArray arrayWithArray:pfObject[@"tagList"]];
    }
    return self;
}

- (id)initWithDescription:(NSString *)description tagList:(NSArray *)tagList
{
    PFObject *pfObject = [PFObject objectWithClassName:@"List"];
    pfObject[@"owner"] = [PFUser currentUser];
    
    pfObject[@"description"] = description.copy;
    pfObject[@"tagList"] = tagList;
    
    return [self initWithPFObject:pfObject];
}

@end

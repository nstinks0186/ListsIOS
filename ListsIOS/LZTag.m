//
//  LZTag.m
//  ListsIOS
//
//  Created by Pinuno on 9/10/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "LZTag.h"

@implementation LZTag

- (id)initWithPFObject:(PFObject *)pfObject
{
    // this is the designated initializer
    
    self = [super initWithPFObject:pfObject];
    if (self) {
        self.description = pfObject[@"description"];
    }
    return self;
}

- (id)initWithDescription:(NSString *)description
{
    PFObject *pfObject = [PFObject objectWithClassName:@"Tag"];
    pfObject[@"owner"] = [PFUser currentUser];
    
    pfObject[@"description"] = description.copy;
    
    return [self initWithPFObject:pfObject];
}

@end

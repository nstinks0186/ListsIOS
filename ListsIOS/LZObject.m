//
//  LZObject.m
//  ListsIOS
//
//  Created by Pinuno on 8/12/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "LZObject.h"

@implementation LZObject

- (id)initWithPFObject:(PFObject *)pfObject
{
    self = [super init];
    if (self) {
        self.pfObject = pfObject;
    }
    return self;
}

@end

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

#pragma mark - Saving

- (void)saveInBackground
{
    assert(self.pfObject);
    [self.pfObject saveInBackground];
}

- (void)saveInBackgroundWithBlock:(PFBooleanResultBlock)block
{
    assert(self.pfObject);
    [self.pfObject saveInBackgroundWithBlock:block];
}

#pragma mark -

+ (void)processError:(NSError *)error
{
    if (error.code == 120) { // cache miss
        DLog(@"%@",error.localizedDescription);
    }
    if (error.code == 124) { // timed out
        DLog(@"%@",error.localizedDescription);
    }
    else{
        DLog(@"Error: %@ %@", error, [error userInfo]);
    }
}

@end

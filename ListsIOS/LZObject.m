//
//  LZObject.m
//  ListsIOS
//
//  Created by Pinuno on 8/12/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "LZObject.h"

@interface LZObject ()

- (void)processError:(NSError *)error;

@end

@implementation LZObject

- (id)initWithPFObject:(PFObject *)pfObject
{
    self = [super init];
    if (self) {
        self.pfObject = pfObject;
    }
    return self;
}

#pragma mark - Operations

- (void)saveInBackground
{
    assert(self.pfObject);
    
    [self.pfObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            [self processError:error];
        }
    }];
}

- (void)saveInBackgroundWithBlock:(PFBooleanResultBlock)block
{
    assert(self.pfObject);
    
    [self.pfObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            [self processError:error];
        }
        
        if (block) {
            block(succeeded, error);
        }
    }];
}

- (void)deleteInBackgroundWithBlock:(PFBooleanResultBlock)block
{
    assert(self.pfObject);
    
    [self.pfObject deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            [self processError:error];
        }
        
        if (block) {
            block(succeeded, error);
        }
    }];
}

#pragma mark Utility Methods

- (void)processError:(NSError *)error
{
    [LZAnalyticsBoss logError:error
                        title:@"Parse.APICall"
                      message:@"Parse.APICall.Error"];
}

@end

@implementation PFObject (LZObject)

- (PFObject *)duplicate
{
    PFObject *pfObject = [PFObject objectWithClassName:self.parseClassName];
    pfObject.objectId = self.objectId;
    NSArray *keys = [pfObject allKeys];
    for (NSString *key in keys) {
        pfObject[key] = self[key];
    }
    return pfObject;
}

@end

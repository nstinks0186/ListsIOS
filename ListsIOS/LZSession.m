//
//  LZSession.m
//  ListsIOS
//
//  Created by Pinuno on 9/11/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "LZSession.h"
#import "LZTag.h"


@interface LZSession ()

@property (strong, nonatomic) LZTag *typeTodoTag;
@property (strong, nonatomic) LZTag *typeTobuyTag;

@property (strong, nonatomic) NSMutableArray *tagList;

@end

@implementation LZSession

+ (LZSession *)currentSession
{
    static LZSession *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[LZSession alloc] init];
        _sharedInstance.tagList = [NSMutableArray array];
    });
    
    return _sharedInstance;
}

#pragma mark Operation

- (void)initSession:(PFBooleanResultBlock)block
{
    PFQuery *query = [PFQuery queryWithClassName:@"Tag"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                LZTag *tag = [[LZTag alloc] initWithPFObject:object];
                if ([tag.description isEqualToString:kTagTypeTodo]) {
                    self.typeTodoTag = [[LZTag alloc] initWithPFObject:object];
                }
                else if ([tag.description isEqualToString:kTagTypeTobuy]) {
                    self.typeTobuyTag = [[LZTag alloc] initWithPFObject:object];
                }
                [self.tagList addObject:tag];
            }
        }
        
        if (block) {
            block((error == nil), error);
        }
        
        
    }];
}

#pragma mark Tag Operations

- (LZTag *)tagWithPFPointer:(PFObject *)object
{
    for (LZTag *tag in self.tagList) {
        if ([tag.pfObject.objectId isEqualToString:object.objectId]) {
            return tag;
        }
    }
    return nil;
}

@end

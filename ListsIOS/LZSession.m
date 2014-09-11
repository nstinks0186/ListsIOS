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

@property (strong, nonatomic) NSMutableArray *tagList;
@property (strong, nonatomic) NSMutableArray *customTagList;
@property (strong, nonatomic) LZTag *typeTodoTag;
@property (strong, nonatomic) LZTag *typeTobuyTag;

@end

@implementation LZSession

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tagList = [NSMutableArray array];
        self.customTagList = [NSMutableArray array];
    }
    return self;
}

+ (LZSession *)currentSession
{
    static LZSession *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[LZSession alloc] init];
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
                else{
                    [self.customTagList addObject:tag];
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

- (BOOL)isTypeTodoTag:(PFObject *)object
{
    return [self.typeTodoTag.pfObject.objectId isEqualToString:object.objectId];
}

- (BOOL)isTypeTobuyTag:(PFObject *)object
{
    return [self.typeTobuyTag.pfObject.objectId isEqualToString:object.objectId];
}

- (LZTag *)customTagWithPFPointer:(PFObject *)object
{
    for (LZTag *tag in self.tagList) {
        if ([tag.pfObject.objectId isEqualToString:object.objectId]) {
            return tag;
        }
    }
    return nil;
}


@end

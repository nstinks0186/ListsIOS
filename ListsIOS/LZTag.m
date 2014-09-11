//
//  LZTag.m
//  ListsIOS
//
//  Created by Pinuno on 9/10/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "LZTag.h"

static LZTag *_tagTypeTodo = nil;
static LZTag *_tagTypeTobuy = nil;

NSString * const kTagTypeTodo = @"$TypeTodo";
NSString * const kTagTypeTobuy = @"$TypeTobuy";

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

#pragma mark Class Methods

+ (void)fetchSystemTags:(PFBooleanResultBlock)block
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"description BEGINSWITH '$'"];
    PFQuery *query = [PFQuery queryWithClassName:@"Tag" predicate:predicate];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            static dispatch_once_t oncePredicate;
            dispatch_once(&oncePredicate, ^{
                for (PFObject *object in objects) {
                    NSString *description = object[@"description"];
                    if ([description isEqualToString:kTagTypeTodo]) {
                        _tagTypeTodo = [[LZTag alloc] initWithPFObject:object];
                    }
                    else if ([description isEqualToString:kTagTypeTobuy]) {
                        _tagTypeTobuy = [[LZTag alloc] initWithPFObject:object];
                    }
                    
                }
            });
        }
        
        if (block) {
            block((error == nil), error);
        }
        
        
    }];
}

+ (instancetype)typeTodo
{
    return _tagTypeTodo;
}

+ (instancetype)typeTobuy
{
    return _tagTypeTobuy;
}

@end

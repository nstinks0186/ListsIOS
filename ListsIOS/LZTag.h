//
//  LZTag.h
//  ListsIOS
//
//  Created by Pinuno on 9/10/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "LZObject.h"

extern NSString * const kTagTypeTodo;
extern NSString * const kTagTypeTobuy;

@interface LZTag : LZObject

@property (strong, nonatomic) NSString *description;

- (id)initWithDescription:(NSString *)description;

// class methods
+ (void)fetchSystemTags:(PFBooleanResultBlock)block;
+ (LZTag *)typeTodo;
+ (LZTag *)typeTobuy;

@end

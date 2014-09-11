//
//  LZSession.h
//  ListsIOS
//
//  Created by Pinuno on 9/11/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

#define LZCurrentSession [LZSession currentSession]

@class LZTag;

@interface LZSession : NSObject

+ (LZSession *)currentSession;

// operations
- (void)initSession:(PFBooleanResultBlock)block;

// tags
@property (strong, readonly) NSMutableArray *customTagList;
@property (strong, readonly) LZTag *typeTodoTag;
@property (strong, readonly) LZTag *typeTobuyTag;
- (BOOL)isTypeTodoTag:(PFObject *)object;
- (BOOL)isTypeTobuyTag:(PFObject *)object;
- (LZTag *)customTagWithPFPointer:(PFObject *)object;

@end

//
//  LZObject.h
//  ListsIOS
//
//  Created by Pinuno on 8/12/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface LZObject : NSObject

@property (strong, nonatomic) PFObject *pfObject;

- (id)initWithPFObject:(PFObject *)pfObject;

- (void)saveInBackground;
- (void)saveInBackgroundWithBlock:(PFBooleanResultBlock)block;
- (void)deleteInBackgroundWithBlock:(PFBooleanResultBlock)block;

@end

@interface PFObject (LZObject)

- (PFObject *)duplicate;

@end

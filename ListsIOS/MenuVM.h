//
//  MenuVM.h
//  ListsIOS
//
//  Created by Pinuno on 9/10/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface MenuVM : NSObject

// operation
- (void)fetchTagList:(BOOL)forceNetwork;

@end

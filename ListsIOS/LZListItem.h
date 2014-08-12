//
//  LZListItem.h
//  ListsIOS
//
//  Created by Pinuno on 8/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZObject.h"

@interface LZListItem : LZObject

@property (strong, nonatomic) NSString *description;

- (id)initWithDescription:(NSString *)description;

@end

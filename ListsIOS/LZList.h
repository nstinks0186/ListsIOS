//
//  LZList.h
//  ListsIOS
//
//  Created by Pinuno on 8/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZObject.h"

@interface LZList : LZObject

@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSMutableArray *tagList;

- (id)initWithDescription:(NSString *)description tagList:(NSArray *)tagList;

@end

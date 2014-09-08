//
//  TagListVM.h
//  ListsIOS
//
//  Created by Pinuno on 9/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZListItem.h"

@interface TagListVM : NSObject

- (id)initWithLZListItem:(LZListItem *)item;

// getters
- (NSInteger)sectionCount;
- (NSInteger)rowCountForSection:(NSInteger)section;
- (NSString *)titleForIndexPath:(NSIndexPath *)indexPath;

// operations
- (void)addTag:(NSString *)tag;
- (void)save;

@end

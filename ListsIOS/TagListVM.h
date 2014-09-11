//
//  TagListVM.h
//  ListsIOS
//
//  Created by Pinuno on 9/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZListItem.h"

@protocol TagListVMDelegate;

@interface TagListVM : NSObject

- (id)initWithLZListItem:(LZListItem *)item;

@property (weak, nonatomic) id<TagListVMDelegate>delegate;

// getters
- (NSInteger)sectionCount;
- (NSInteger)rowCountForSection:(NSInteger)section;
- (NSString *)titleForIndexPath:(NSIndexPath *)indexPath;

// operations
- (void)addTag:(NSString *)tag;
- (void)removeTagAtIndexPath:(NSIndexPath *)indexPath;
- (void)save;
- (void)selectTagAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol TagListVMDelegate <NSObject>

- (void)tagListVMDidUpdateTagList:(TagListVM *)vm;

@end


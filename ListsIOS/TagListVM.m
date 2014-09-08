//
//  TagListVM.m
//  ListsIOS
//
//  Created by Pinuno on 9/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "TagListVM.h"

@interface TagListVM ()

@property (weak, nonatomic) LZListItem *item;
@property (strong, nonatomic) NSString *typeTag;
@property (strong, nonatomic) NSMutableArray *tagList;

@end

@implementation TagListVM

- (id)initWithLZListItem:(LZListItem *)item
{
    self = [self init];
    if (self) {
        self.item = item;
        self.tagList = [NSMutableArray arrayWithArray:self.item.tagList];
        if ([self.tagList containsObject:@"$TypeTodo"]) {
            self.typeTag = @"$TypeTodo";
            [self.tagList removeObject:@"$TypeTodo"];
        }else if ([self.tagList containsObject:@"$TypeTobuy"]) {
            self.typeTag = @"$TypeTobuy";
            [self.tagList removeObject:@"$TypeTobuy"];
        }else if ([self.tagList containsObject:@"$TypeTonote"]) {
            self.typeTag = @"$TypeTonote";
            [self.tagList removeObject:@"$TypeTonote"];
        }
    }
    return self;
}

#pragma mark Getters

- (NSInteger)sectionCount
{
    return 1;
}

- (NSInteger)rowCountForSection:(NSInteger)section
{
    return self.tagList.count;
}

- (NSString *)titleForIndexPath:(NSIndexPath *)indexPath
{
    return [self.tagList objectAtIndex:indexPath.row];
}

#pragma mark Operations

- (void)addTag:(NSString *)tag
{
    [self.tagList insertObject:tag atIndex:0];
}

- (void)removeTagAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tagList removeObjectAtIndex:indexPath.row];
}

- (void)save
{
    [self.tagList addObject:self.typeTag];
    [self.item updateTagList:self.tagList withBlock:nil];
}

@end

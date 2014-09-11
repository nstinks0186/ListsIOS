//
//  TagListVM.m
//  ListsIOS
//
//  Created by Pinuno on 9/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "TagListVM.h"
#import "LZList.h"
#import "LZTag.h"

@interface TagListVM ()

@property (weak, nonatomic) LZListItem *item;
@property (strong, nonatomic) NSMutableArray *tagList;
@property (strong, nonatomic) NSMutableArray *selectedTagList;

@end

@implementation TagListVM

- (id)initWithLZListItem:(LZListItem *)item
{
    self = [self init];
    if (self) {
        self.item = item;
        self.tagList = [NSMutableArray array];
        self.selectedTagList = [NSMutableArray arrayWithArray:self.item.customTagList];
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
    LZTag *tag = [self.tagList objectAtIndex:indexPath.row];
    return tag.description;
}

#pragma mark Operations

- (void)addTag:(NSString *)_tag
{
    [self.tagList insertObject:_tag atIndex:0];
    
    // Create Tag
    LZTag *tag = [[LZTag alloc] initWithDescription:_tag];
    @synchronized(self){
        [tag saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            // Then Create a list
            LZList *newList = [[LZList alloc] initWithDescription:_tag tagList:@[tag.pfObject]];
            @synchronized(self){
                [newList saveInBackgroundWithBlock:nil];
            }
        }];
    }
    
}

- (void)removeTagAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tagList removeObjectAtIndex:indexPath.row];
}

- (void)save
{
    NSMutableArray *tagList = [NSMutableArray arrayWithArray:self.selectedTagList];
    [tagList addObject:self.item.typeTag];
    [self.item updateTagList:tagList withBlock:nil];
}

- (void)fetchTagList:(BOOL)forceNetwork
{
    @synchronized(self) {
        PFQuery *query = [PFQuery queryWithClassName:@"Tag"];
        query.cachePolicy = (forceNetwork ? kPFCachePolicyNetworkElseCache : kPFCachePolicyCacheElseNetwork);
        [query whereKey:@"owner" equalTo:[PFUser currentUser]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                if (!self.tagList) {
                    self.tagList = [NSMutableArray array];
                }else{
                    [self.tagList removeAllObjects];
                }
                
                for (PFObject *object in objects) {
                    LZTag *tag = [[LZTag alloc] initWithPFObject:object];
                    [self.tagList addObject:tag];
                }
                
                if ([self.delegate respondsToSelector:@selector(tagListVMDidUpdateTagList:)]) {
                    [self.delegate tagListVMDidUpdateTagList:self];
                }
            } else {
                [LZAnalyticsBoss logError:error
                                    title:@"Parse.APICall"
                                  message:@"Parse.APICall.Error"];
            }
        }];
    }
}

- (void)selectTagAtIndexPath:(NSIndexPath *)indexPath
{
    LZTag *tag = [self.tagList objectAtIndex:indexPath.row];
    [self.selectedTagList addObject:tag];
}

@end

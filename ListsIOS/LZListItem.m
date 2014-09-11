//
//  LZListItem.m
//  ListsIOS
//
//  Created by Pinuno on 8/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "LZListItem.h"

@interface NSDate (LZListItem)

+ (NSDate *)dateFromPFObjectProperty:(id<NSObject>)value;

@end

@interface LZListItem ()

@property (strong, nonatomic) NSMutableArray *customTagList;

@end

@implementation LZListItem

- (id)initWithPFObject:(PFObject *)pfObject
{
    // this is the designated initializer
    
    self = [super initWithPFObject:pfObject];
    if (self) {
        self.description = pfObject[@"description"];
        self.tagList = [NSMutableArray arrayWithArray:pfObject[@"tagList"]];
        self.dueDate = [NSDate dateFromPFObjectProperty:pfObject[@"dueDate"]];
        self.status = [(NSNumber *)pfObject[@"status"] integerValue];
        
        [self setCustomTagList];
    }
    return self;
}

- (id)initWithDescription:(NSString *)description tagList:(NSArray *)tagList status:(LZListItemStatus)status dueDate:(NSDate *)dueDate
{
    PFObject *pfObject = [PFObject objectWithClassName:@"Item"];
    pfObject[@"owner"] = [PFUser currentUser];
    pfObject[@"dueDate"] = dueDate.copy;
    
    pfObject[@"description"] = description.copy;
    pfObject[@"tagList"] = tagList.copy;
    pfObject[@"status"] = @(status);
    
    return [self initWithPFObject:pfObject];
}

#pragma mark Update

- (void)updateDueDate:(NSDate *)newDate withBlock:(PFBooleanResultBlock)block
{
    PFObject *object = self.pfObject.duplicate;
    object[@"dueDate"] = (newDate ? newDate : [NSNull null]);
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            self.dueDate = ([[object[@"dueDate"] class] isSubclassOfClass:[NSNull class]] ? nil : object[@"dueDate"]);
        }
        
        if (block) {
            block(succeeded, error);
        }
    }];
}

- (void)updateStatus:(LZListItemStatus)newStatus withBlock:(PFBooleanResultBlock)block
{
    PFObject *object = self.pfObject.duplicate;
    object[@"status"] = @(newStatus);
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            self.status = [(NSNumber *)object[@"status"] integerValue];
        }
        
        if (block) {
            block(succeeded, error);
        }
    }];
}

- (void)updateTagList:(NSMutableArray *)tagList withBlock:(PFBooleanResultBlock)block
{
    PFObject *object = self.pfObject.duplicate;
    object[@"tagList"] = tagList.copy;
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            self.tagList = [NSMutableArray arrayWithArray:object[@"tagList"]];
        }
        
        if (block) {
            block(succeeded, error);
        }
    }];
}

#pragma mark Due date logic

- (BOOL)isDueToday
{
    return (self.dueDate ? (self.dueDate && (self.dueDate.isToday || self.dueDate.isInPast)) : NO);
}

- (BOOL)isDueTomorrow
{
    return (self.dueDate ? (self.dueDate && self.dueDate.isTomorrow) : NO);
}

- (BOOL)isDueWeekend
{
    if (self.dueDate && !self.dueDate.isInPast && self.dueDate.isTypicallyWeekend) {
        NSDate *today = [NSDate date];
        return ([today daysBeforeDate:self.dueDate] < 7);
    }
    return NO;
}

- (BOOL)isDueSomeday
{
    return (!self.isDueToday && !self.isDueTomorrow && !self.isDueWeekend);
}

#pragma mark Custom tag list logic

- (void)setCustomTagList
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.tagList];
    [array removeObject:@"$TypeTodo"];
    [array removeObject:@"$TypeTobuy"];
    // for backward compatibility $TypeTonote is no longer supported
    [array removeObject:@"$TypeTonote"];
    
    self.customTagList = array;
}

- (BOOL) isTagged:(NSString *)tag
{
    BOOL tagFilterSatisfied = NO;
    for (NSString *_tag in self.customTagList) {
        if ([_tag isEqual:tag]) {
            tagFilterSatisfied = YES;
            break;
        }
    }
    return tagFilterSatisfied;
}

- (BOOL) hasCustomTag
{
    return (self.customTagList && self.customTagList.count > 0);
}

@end




@implementation NSDate (LZListItem)

+ (NSDate *)dateFromPFObjectProperty:(id<NSObject>)value
{
    return (value != nil ? ([[value class] isSubclassOfClass:[NSNull class]] ? nil : (NSDate *)value) : nil);
}

@end

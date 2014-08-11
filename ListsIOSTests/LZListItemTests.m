//
//  LZListItemTests.m
//  ListsIOS
//
//  Created by Pinuno on 8/11/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LZListItem.h"

@interface LZListItemTests : XCTestCase

@end

@implementation LZListItemTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_initWithDescription
{
    // given
    NSString *description = @"some list item";
    
    // when
    LZListItem *lzListItem = [[LZListItem alloc] initWithDescription:description];
    
    // then
    XCTAssertNotNil(lzListItem, @"%@",lzListItem);
    XCTAssertTrue([description isEqualToString:lzListItem.description], @"%@ %@",description, lzListItem.description);
}

@end

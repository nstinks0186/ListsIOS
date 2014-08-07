//
//  ListsIOSTests.m
//  ListsIOSTests
//
//  Created by Pinuno on 8/6/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SignupVC.h"

@interface ListsIOSTests : XCTestCase

@end

@implementation ListsIOSTests

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

- (void)test_signupWithVMblock
{
    NSString *username = [NSString stringWithFormat:@"%f",[NSDate new].timeIntervalSinceReferenceDate];
    
    SignupVM *vm = [SignupVM new];
    vm.emailAddress = [NSString stringWithFormat:@"%@@test.com",username];
    vm.username = username;
    vm.password = username;
    
    SignupVC *vc = [[SignupVC alloc] initWithNibName:nil bundle:nil];
    XCTAssertNotNil(vc, @"Signup failed. SignupVC is nil.");
    [vc signupWithVM:vm block:^(BOOL succeeded, NSError *error) {
        NSLog(@"%@",[PFUser currentUser].username);
        NSLog(@"%@",error);
        XCTAssertNotNil(error, @"Signup failed. %@",error);
    }];
}

@end

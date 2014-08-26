//
//  ListVMTests.m
//  ListsIOS
//
//  Created by Pinuno on 8/11/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ListVM.h"

@interface ListVMTests : XCTestCase {
    ListVType typeTodo;
    ListVType typeTobuy;
    ListVType typeTonote;
    ListVType typeCustom;
    
    ListVM *vmTodo;
    ListVM *vmTobuy;
    ListVM *vmTonote;
    ListVM *vmCustom;
}


@end

@implementation ListVMTests

- (void)setUp
{
    [super setUp];
    
    // given
    typeTodo = ListVTypeTodo;
    typeTobuy = ListVTypeTobuy;
    typeTonote = ListVTypeTonote;
    typeCustom = ListVTypeCustom;
    
    // when
    vmTodo = [[ListVM alloc] initWithType:typeTodo];
    vmTobuy = [[ListVM alloc] initWithType:typeTobuy];
    vmTonote = [[ListVM alloc] initWithType:typeTonote];
    vmCustom = [[ListVM alloc] initWithType:typeCustom];
}



- (void)tearDown
{
    vmTodo = nil;
    vmTobuy = nil;
    vmTonote = nil;
    vmCustom = nil;
    
    [super tearDown];
}

- (void)test_initWithType
{
    XCTAssertNotNil(vmTodo, @"%@",vmTodo);
    XCTAssertEqual(typeTodo, vmTodo.type, @"%d %d",typeTodo,vmTodo.type);
    XCTAssertNotNil(vmTobuy, @"%@",vmTobuy);
    XCTAssertEqual(typeTobuy, vmTobuy.type, @"%d %d",typeTobuy,vmTobuy.type);
    XCTAssertNotNil(vmTonote, @"%@",vmTonote);
    XCTAssertEqual(typeTonote, vmTonote.type, @"%d %d",typeTonote,vmTonote.type);
    XCTAssertNotNil(vmCustom, @"%@",vmCustom);
    XCTAssertEqual(typeCustom, vmCustom.type, @"%d %d",typeCustom,vmCustom.type);
}

- (void)test_sectionCount
{
    // given
    NSInteger one = 1;
    
    // when
    NSInteger sectionCountTodo = vmTobuy.sectionCount;
    NSInteger sectionCountTobuy = vmTodo.sectionCount;
    NSInteger sectionCountTonote = vmTonote.sectionCount;
    NSInteger sectionCountTocustom = vmCustom.sectionCount;
    
    // then
    XCTAssertEqual(sectionCountTodo, one, @"%d",sectionCountTodo);
    XCTAssertEqual(sectionCountTobuy, one, @"%d",sectionCountTobuy);
    XCTAssertEqual(sectionCountTonote, one, @"%d",sectionCountTonote);
    XCTAssertEqual(sectionCountTocustom, one, @"%d",sectionCountTocustom);
}

- (void)test_rowCountForSection
{
    // given
    NSInteger zero = 0;
    
    // when
    NSInteger rowCountTodo = [vmTodo rowCountForSection:zero];
    NSInteger rowCountTobuy = [vmTobuy rowCountForSection:zero];
    NSInteger rowCountTonote = [vmTonote rowCountForSection:zero];
    NSInteger rowCountCustom = [vmCustom rowCountForSection:zero];
    
    // then
    XCTAssertEqual(rowCountTodo, zero, @"%d",rowCountTodo);
    XCTAssertEqual(rowCountTobuy, zero, @"%d",rowCountTobuy);
    XCTAssertEqual(rowCountTonote, zero, @"%d",rowCountTonote);
    XCTAssertEqual(rowCountCustom, zero, @"%d",rowCountCustom);
}

- (void)test_doCreateItem
{
    // given
    NSInteger one = 1;
    NSString *newItemDescription = @"new item";
    
    // when creating a new item
    vmTodo.createItemDescription = newItemDescription;
    vmTobuy.createItemDescription = newItemDescription;
    vmTonote.createItemDescription = newItemDescription;
    vmCustom.createItemDescription = newItemDescription;
    [vmTodo doCreateItem];
    [vmTobuy doCreateItem];
    [vmTonote doCreateItem];
    [vmCustom doCreateItem];
    
    // then sectionCount stays the same (1)
    NSInteger sectionCountTodo = vmTobuy.sectionCount;
    NSInteger sectionCountTobuy = vmTodo.sectionCount;
    NSInteger sectionCountTonote = vmTonote.sectionCount;
    NSInteger sectionCountTocustom = vmCustom.sectionCount;
    XCTAssertEqual(sectionCountTodo, one, @"%d",sectionCountTodo);
    XCTAssertEqual(sectionCountTobuy, one, @"%d",sectionCountTobuy);
    XCTAssertEqual(sectionCountTonote, one, @"%d",sectionCountTonote);
    XCTAssertEqual(sectionCountTocustom, one, @"%d",sectionCountTocustom);
    // rowCount for section zero increase by one (1)
    NSInteger rowCountTodo = [vmTodo rowCountForSection:one];
    NSInteger rowCountTobuy = [vmTobuy rowCountForSection:one];
    NSInteger rowCountTonote = [vmTonote rowCountForSection:one];
    NSInteger rowCountCustom = [vmCustom rowCountForSection:one];
    XCTAssertEqual(rowCountTodo, one, @"%d",rowCountTodo);
    XCTAssertEqual(rowCountTobuy, one, @"%d",rowCountTobuy);
    XCTAssertEqual(rowCountTonote, one, @"%d",rowCountTonote);
    XCTAssertEqual(rowCountCustom, one, @"%d",rowCountCustom);
    // TODO: itemList[0].description should be equal to newItemDescription
    LZListItem *newItemTodo = vmTodo.itemList.firstObject;
    LZListItem *newItemTobuy = vmTobuy.itemList.firstObject;
    LZListItem *newItemTonote = vmTonote.itemList.firstObject;
    LZListItem *newItemCustom = vmCustom.itemList.firstObject;
    XCTAssertTrue([newItemTodo.description isEqualToString:newItemDescription], @"%@",newItemTodo.description);
    XCTAssertTrue([newItemTobuy.description isEqualToString:newItemDescription], @"%@",newItemTobuy.description);
    XCTAssertTrue([newItemTonote.description isEqualToString:newItemDescription], @"%@",newItemTonote.description);
    XCTAssertTrue([newItemCustom.description isEqualToString:newItemDescription], @"%@",newItemCustom.description);
    
}

@end

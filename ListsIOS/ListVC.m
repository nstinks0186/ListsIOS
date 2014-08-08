//
//  ListVC.m
//  ListsIOS
//
//  Created by Pinuno on 8/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "ListVC.h"

@interface ListVC ()

@property (weak, nonatomic) IBOutlet UITextField *createItemField;

@end

@implementation ListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.listVM = [[ListVM alloc] initWithType:self.type];
    self.listVM.createItemDescription = self.createItemField.text;
    
    self.navigationItem.title = self.listVM.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods

- (IBAction)createItemFieldChange:(id)sender
{
    self.listVM.createItemDescription = self.createItemField.text;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.listVM sectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listVM rowCountForSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListItemCellIdentifier"];
    
    assert(cell);
    
    return cell;
}

#pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self.listVM doCreateItem];
    
    // update UI
    self.createItemField.text = @"";
    [self.tableView reloadData];
    
    return YES;
}

#pragma mark - Conveninence Methods

@end


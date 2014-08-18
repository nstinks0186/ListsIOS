//
//  ListVC.m
//  ListsIOS
//
//  Created by Pinuno on 8/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "ListVC.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

@interface ListVC ()

@property (weak, nonatomic) IBOutlet UITextField *createItemField;

@end

@implementation ListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // initialize vm
    self.listVM = [[ListVM alloc] initWithType:self.type];
    self.listVM.delegate = self;
    self.listVM.createItemDescription = self.createItemField.text;
    
    // setup GAnalytics tracker
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:[NSString stringWithFormat:@"ListVC.%@",self.listVM.title]];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    // UI setup
    self.navigationItem.title = self.listVM.title;
    [self.refreshControl addTarget:self action:@selector(reloadButtonTapped:) forControlEvents:UIControlEventValueChanged];
    
    // fetch data
    [self.listVM fetchItemList];
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

- (IBAction)reloadButtonTapped:(id)sender
{
    [self.listVM fetchItemList];
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
    
    [self setupCell:cell forIndexPath:indexPath];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZListItem *lzListItem = [self.listVM.itemList objectAtIndex:indexPath.row];
    [self.listVM doRemoveItem:lzListItem];
}

#pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self.listVM doCreateItem];
    
    // update UI
    [self.tableView reloadData];
    self.createItemField.text = @"";
    
    return YES;
}

#pragma mark - ListVMDelegate Methods

- (void)listVMDidUpdateListItemList:(ListVM *)vm
{
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

#pragma mark - Conveninence Methods

- (void)setupCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    LZListItem *lzListItem = [self.listVM.itemList objectAtIndex:indexPath.row];
    cell.textLabel.text = lzListItem.description;
    cell.detailTextLabel.text = lzListItem.dueDateString;
}

@end


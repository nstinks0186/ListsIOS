//
//  ListVC.m
//  ListsIOS
//
//  Created by Pinuno on 8/8/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "ListVC.h"
#import "MBProgressHUD.h"

@interface ListVC ()

@property (weak, nonatomic) IBOutlet UITextField *createItemField;

@end

@implementation ListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // initialize vm
    self.listVM = [[ListVM alloc] init];
    self.listVM.dueDateFilter = self.dueDateFilter;
    self.listVM.delegate = self;
    self.listVM.createItemDescription = self.createItemField.text;
    
    // setup analytics
    [LZAnalyticsBoss logScreenView:@"ListVC"];
    
    // UI setup
    [self.refreshControl addTarget:self action:@selector(reloadButtonTapped:) forControlEvents:UIControlEventValueChanged];
    
    // fetch data
    [self fetchItemList:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"TagListSegue"]) {
        
    }
}



#pragma mark - Action Methods


- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)control
{
    self.listVM.mode = control.selectedSegmentIndex;
    [self fetchItemList:NO];
}

- (IBAction)createItemFieldChange:(id)sender
{
    self.listVM.createItemDescription = self.createItemField.text;
}

- (IBAction)reloadButtonTapped:(id)sender
{
    [self fetchItemList:YES];
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
    
    ListVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListItemCellIdentifier"];
    
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
    [lzListItem updateStatus:LZListItemStatusArchived withBlock:^(BOOL succeeded, NSError *error) {
        [self.tableView reloadData];
    }];
    
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
    [self.listVM sortItemList];
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
}

#pragma mark ListVCellDelegate Methods

- (void)listVCellDidUpdateDueDate:(ListVCell *)cell
{
    [self fetchItemList:NO];
}

#pragma mark - Conveninence Methods

- (void)setupCell:(ListVCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    cell.viewController = self;
    cell.listItem = [self.listVM.itemList objectAtIndex:indexPath.row];
}

- (void)fetchItemList:(BOOL)forceNetwork
{
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    [self.listVM fetchItemList:forceNetwork];
}

@end


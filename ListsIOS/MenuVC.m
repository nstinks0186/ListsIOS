//
//  MenuVC.m
//  ListsIOS
//
//  Created by Pinuno on 8/6/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "MenuVC.h"
#import "AppDelegate.h"
#import "ListVC.h"

@interface MenuVC()

@property (strong, nonatomic) MenuVM *menuVM;

@end

@implementation MenuVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.menuVM = [MenuVM new];
    self.menuVM.delegate = self;
    [self.menuVM fetchTagList:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (![segue.identifier isEqualToString:@"SettingsSegue"] && ![segue.identifier isEqualToString:@"NewListSegue"]) {
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        UINavigationController *navVC = (UINavigationController *)segue.destinationViewController;
        ListVC *vc = (ListVC *)navVC.viewControllers.firstObject;
        vc.dueDateFilter = [self.menuVM dueDateFilterForIndexPath:indexPath];
        vc.tagListFilter = [self.menuVM tagListFilterForIndexPath:indexPath];
    }
}

#pragma mark - Action Methods

- (IBAction)settingsButtonTapped:(id)sender
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UIViewController *rootVC = appDelegate.window.rootViewController;
    UINavigationController *navVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsNavVC"];
    [rootVC presentViewController:navVC animated:YES completion:nil];
}

- (IBAction)unwindToMenuViewController:(UIStoryboardSegue *)segue
{
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.menuVM sectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuVM rowCountForSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self.menuVM cellIdentifierForIndexPath:indexPath]];
    cell.tag = indexPath.row;
    
    [self setupCell:cell forIndexPath:indexPath];
    
    return cell;
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    LZListItem *lzListItem = [self.listVM.itemList objectAtIndex:indexPath.row];
//    [lzListItem updateStatus:LZListItemStatusArchived withBlock:^(BOOL succeeded, NSError *error) {
//        [self.tableView reloadData];
//    }];
//    
//}

#pragma mark - MenuVMDelegate Methods

- (void)menuVMDidUpdateTagList:(MenuVM *)vm
{
    [self.tableView reloadData];
}

#pragma mark - Conveninence Methods

- (void)setupCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [self.menuVM cellTitleForIndexPath:indexPath];
}

@end

@implementation MenuNavVC

#pragma mark - Action Methods

- (IBAction)unwindToMenuViewController:(UIStoryboardSegue *)segue
{
}

@end

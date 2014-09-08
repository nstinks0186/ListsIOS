//
//  TagListVC.m
//  ListsIOS
//
//  Created by Pinuno on 9/4/14.
//  Copyright (c) 2014 UNO. All rights reserved.
//

#import "TagListVC.h"
#import "TagListVM.h"

@interface TagListVC ()

@property (strong, nonatomic) TagListVM *tagListVM;

@property (weak, nonatomic) IBOutlet UITextField *createTagField;

@end

@implementation TagListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.tagListVM) {
        self.tagListVM = [[TagListVM alloc] initWithLZListItem:self.listItem];
    }
}

#pragma mark - Action Methods

- (IBAction)saveButtonTapped:(id)sender
{
    [self.tagListVM save];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tagListVM.sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tagListVM rowCountForSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TagListVCellIdentifier"];
    
    cell.textLabel.text = [self.tagListVM titleForIndexPath:indexPath];

    return cell;
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

#pragma mark - UITextFieldDelegate Methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)characters
{
    if (textField == self.createTagField) {
        NSCharacterSet *alphaSet = [NSCharacterSet alphanumericCharacterSet];
        return ([characters rangeOfCharacterFromSet:alphaSet.invertedSet].location == NSNotFound);
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [self.tagListVM addTag:self.createTagField.text];

    // update UI
    [self.tableView reloadData];
    self.createTagField.text = @"";
    
    return YES;
}

@end

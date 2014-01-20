//
//  TIMTableViewController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 19.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMTableViewController.h"

@interface TIMTableViewController () {
    NSArray *_tableViewData;
    NSMutableArray *_selectedData;
}

@end

@implementation TIMTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableViewData = [[NSArray alloc] init];
    _selectedData = [[NSMutableArray alloc] init];
    [self customBackButtonItem];
    [self createNavigationOkBtn];
    if (self.isProfessions) {
        self.navigationItem.title = @"Профессии";
        [self allowMultipleSelection:NO];
        [self professionRequest];
    } else {
        self.navigationItem.title = @"Интересы";
        [self allowMultipleSelection:YES];
        [self interestsRequest];
    }
}

- (void)allowMultipleSelection:(BOOL)flag {
    [self.tableView setAllowsMultipleSelection:flag];
}


- (void)customBackButtonItem{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 22)];
    UIImage *buttonImage = [UIImage imageNamed:@"header-back-button.png"];
    UIImage *buttonHiglitedImage = [UIImage imageNamed:@"header-back-button-down.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:buttonHiglitedImage forState:UIControlStateHighlighted];
    int xPosition;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        xPosition = 0;
    } else {
        xPosition = customView.frame.size.width-22;
    }
    button.frame = CGRectMake(xPosition, 0, 22, 22);
    [customView addSubview:button];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* customBackBtn = [[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.leftBarButtonItem = customBackBtn;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    self.navigationItem.hidesBackButton = YES;
}

- (void)createNavigationOkBtn{
    UIButton* okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(0, 0, 29, 29);
    [okBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [okBtn setImage:[UIImage imageNamed:@"btn_ok.png"] forState:UIControlStateNormal];
    UIBarButtonItem* okBarButton = [[UIBarButtonItem alloc] initWithCustomView:okBtn];
    [self.navigationItem setRightBarButtonItem:okBarButton];
}


- (void)showAlertWithError:(NSString *)message {
    UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:@"Ошибка"
                                                       message:message
                                                      delegate:nil
                                             cancelButtonTitle:@"Закрыть"
                                             otherButtonTitles:nil, nil];
    [alerView show];
}


- (IBAction)saveAction:(id)sender {
    NSLog(@"%d", _selectedData.count);
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)professionRequest {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[TIMRegistrationModel sharedInstance] loadProfessionsWithCompletition:^(NSArray *data, BOOL status, NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (status) {
            _tableViewData = data;
            [self.tableView reloadData];
        } else {
            [self showAlertWithError:error];
        }
    }];
}

- (void)interestsRequest {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[TIMRegistrationModel sharedInstance] loadInterestsWithCompletition:^(NSArray *data, BOOL status, NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (status) {
            _tableViewData = data;
            [self.tableView reloadData];
        } else {
            [self showAlertWithError:error];
        }
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _tableViewData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = _tableViewData[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *thisCell = [tableView cellForRowAtIndexPath:indexPath];
    if (thisCell.accessoryType == UITableViewCellAccessoryNone) {
        thisCell.accessoryType = UITableViewCellAccessoryCheckmark;
        [_selectedData addObject:[_tableViewData objectAtIndex:indexPath.row]];
    } else {
        thisCell.accessoryType = UITableViewCellAccessoryNone;
        [_selectedData removeObject:[_tableViewData objectAtIndex:indexPath.row]];
    }
}

@end

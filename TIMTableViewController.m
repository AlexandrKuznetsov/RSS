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
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 29)];
    UIImage *buttonImage = [UIImage imageNamed:@"btn_back_biggreen"];
    UIImage *buttonHiglitedImage = [UIImage imageNamed:@"btn_back_biggreen_on"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:buttonHiglitedImage forState:UIControlStateHighlighted];
    int xPosition;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        xPosition = 0;
    } else {
        xPosition = customView.frame.size.width-22;
    }
    button.frame = CGRectMake(xPosition, 0, 29, 29);
    [customView addSubview:button];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* customBackBtn = [[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.leftBarButtonItem = customBackBtn;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    self.navigationItem.hidesBackButton = YES;
}

- (void)createSelectedArray {
    _selectedData = [[NSMutableArray alloc] init];
    if ([self.tableView indexPathsForSelectedRows]) {
        for (NSIndexPath *path in [self.tableView indexPathsForSelectedRows]) {
            [_selectedData addObject:[_tableViewData objectAtIndex:path.row]];
        }
    }
}

- (void)createNavigationOkBtn{
    UIButton* okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(0, 0, 29, 29);
    [okBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [okBtn setImage:[UIImage imageNamed:@"btn_ok_white.png"] forState:UIControlStateNormal];
    [okBtn setImage:[UIImage imageNamed:@"btn_ok_white_on.png"] forState:UIControlStateHighlighted];
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
    [self createSelectedArray];
    if (_selectedData.count != 0) {
        if (self.isProfessions) {
            [self.dataDelegate tableViewForProfessions:YES pickedData:_selectedData];
        } else {
            [self.dataDelegate tableViewForProfessions:NO pickedData:_selectedData];
        }
    }
    [self back];
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
    return cell;
}

@end

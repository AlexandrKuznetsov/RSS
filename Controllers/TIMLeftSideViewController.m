//
//  TIMLeftSideViewController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 25.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMLeftSideViewController.h"

@interface TIMLeftSideViewController () {
    NSArray *_controllersArray;
    NSArray *_cellsNameArray;
}

@end

@implementation TIMLeftSideViewController

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
    [self initControllersArray];
    [self initNamesArray];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (IS_IPHONE5) {
        self.tableView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    }

    self.tableView.contentSize = CGSizeMake(0, _cellsNameArray.count * CELL_HEIGHT);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data

- (void)initNamesArray {
    _cellsNameArray = @[@"",
                        @"Дмитрий Вдовиченко",
                        @"",
                        @"Мои впечатления",
                        @"Мои подписки",
                        @"Лента событий",
                        @"Избранное",
                        @"Поиск",
                        @"Друзья",
                        @"Настройки",
                        @"Помощь",
                        @"",
                        @"Выход"];
    [self.tableView reloadData];
}

- (void)initControllersArray {
    TIMGlobalSettingsController *globalSettings = [[TIMGlobalSettingsController alloc] initWithNibName:@"TIMGlobalSettingsController" bundle:[NSBundle mainBundle]];
    TIMHomeProfileViewController *homeProfile = [[TIMHomeProfileViewController alloc] initWithNibName:@"TIMHomeProfileViewController" bundle:[NSBundle mainBundle]];
    TIMImpressionsController *impressions = [[TIMImpressionsController alloc] initWithNibName:@"TIMImpressionsController" bundle:[NSBundle mainBundle]];
    TIMSubscriptionsController *subscriptions = [[TIMSubscriptionsController alloc] initWithNibName:@"TIMSubscriptionsController" bundle:[NSBundle mainBundle]];
    TIMFeedController *feed = [[TIMFeedController alloc] initWithNibName:@"TIMFeedController" bundle:[NSBundle mainBundle]];
    TIMFavouritesController *favorites = [[TIMFavouritesController alloc] initWithNibName:@"TIMFavouritesController" bundle:[NSBundle mainBundle]];
    TIMSearchController *searchController = [[TIMSearchController alloc] initWithNibName:@"TIMSearchController" bundle:[NSBundle mainBundle]];
    TIMFriendsController *friends = [[TIMFriendsController alloc] initWithNibName:@"TIMFriendsController" bundle:[NSBundle mainBundle]];
    TIMHelpViewController *helpController = [[TIMHelpViewController alloc] initWithNibName:@"TIMHelpViewController" bundle:[NSBundle mainBundle]];
    _controllersArray = @[[NSNull null],
                          homeProfile,
                          [NSNull null],
                          impressions,
                          subscriptions,
                          feed,
                          favorites,
                          searchController,
                          friends,
                          globalSettings,
                          helpController,
                          [NSNull null],
                          [NSNull null]
                          ];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellsNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"menuCell";
    TIMMenuCell* cell = (TIMMenuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        NSArray *topLevelItems = [[NSBundle mainBundle] loadNibNamed:@"TIMMenuCell" owner:nil options:nil];
        cell = [topLevelItems lastObject];
    }
    if (indexPath.row == 1) {
        cell.isProfile = YES;
    }
    if (indexPath.row == 12) {
        cell.isExit = YES;
        cell.canSelect = YES;
    }
    NSString *text = _cellsNameArray[indexPath.row];
    if (text.length != 0) {
        cell.canSelect = YES;
    }
    cell.nameLabel.text = text;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TIMHomeNavigationViewController *navigation = self.menuContainerViewController.centerViewController;
    id controller = [_controllersArray objectAtIndex:indexPath.row];
    if (indexPath.row == 12) {
        [TIMKeychain deleteData:KEYCHAIN_SERVICE];
        controller = [_controllersArray objectAtIndex:1];
    }
    if (![controller isKindOfClass:[NSNull class]]) {
        NSArray *controllers = [NSArray arrayWithObject:controller];
        navigation.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}


@end

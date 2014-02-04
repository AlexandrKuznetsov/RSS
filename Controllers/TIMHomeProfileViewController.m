//
//  TIMHomeProfileViewController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMHomeProfileViewController.h"
#import "TIMKeychain.h"

@interface TIMHomeProfileViewController ()

@end

@implementation TIMHomeProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self design];
    [self addNavigationButtons];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self checkForLoginInformation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Set labels for local user 

- (void)labelsForLocalUser {
    self.localUserInfo = [TIMLocalUserInfo sharedInstance];
    self.nameLabel.text = self.localUserInfo.name;
    self.surnameLabel.text = self.localUserInfo.surname;
    self.countryLabel.text = [NSString stringWithFormat:@"%@, %@", [self.localUserInfo country], self.localUserInfo.city];
    self.avatarImageView.image = [[TIMLocalUserInfo sharedInstance] userPhoto];
    self.flagImageView.image = self.localUserInfo.userFlag;
    self.wallpaperImageView.image = [[TIMLocalUserInfo sharedInstance] userWalpaper];
}

#pragma mark - Design

- (void)design {
    [self customizeFonts];
}

- (void)customizeFonts {
    self.nameLabel.font = [UIFont boldFontWithSize:15.0f];
    self.surnameLabel.font = [UIFont boldFontWithSize:15.0f];
    self.countryLabel.font = [UIFont regularFontWithSize:11.0f];
    self.impressionsLabel.font = [UIFont semiBoldFontWithSize:14.0f];
    self.placesLabel.font = [UIFont semiBoldFontWithSize:14.0f];
    self.imprTextLabel.font = [UIFont regularFontWithSize:10.0f];
    self.placeesTextLabel.font = [UIFont regularFontWithSize:10.0f];
    self.settingsOutlet.titleLabel.font = [UIFont semiBoldFontWithSize:10.0f];
    [self.settingsOutlet setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.settingsOutlet setImage:[UIImage imageNamed:@"icon_profilesettings_on"] forState:UIControlStateHighlighted];
}

#pragma mark - Checkings

- (void)checkForLoginInformation {
    if (![[TIMLocalUserInfo sharedInstance] readUserFromUserDefaults] ||
        ![self isValidCurrentUser]) {
        [self pushLoginViewController];
    } else {
        //загрузка локального пользователя при отсутствии инета
        __weak TIMHomeProfileViewController* weakSelf = self;
        if ([[TIMLocalUserInfo sharedInstance] isConnection]) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[TIMLocalUserInfo sharedInstance] loadSettingsWithCompletition:^(NSError *error, id response) {
                if (!error) {
                    [_tableView reloadData];
                    [weakSelf labelsForLocalUser];
                } else {
                    [self showAlertViewWithMessage:[error localizedDescription]];
                }
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }];
        } else {
            [self showAlertViewWithMessage:@"Интернет подключение не доступно!"];
            [self labelsForLocalUser];
        }
    }
}

- (BOOL)isValidCurrentUser{
    NSDictionary* keyChanDict = [TIMKeychain load:KEYCHAIN_SERVICE];
    if ([keyChanDict[@"email"] isEqualToString:
         [[TIMLocalUserInfo sharedInstance] email]]) {
        return YES;
    }
#warning WRONG_CHECK
    return YES;
}

#pragma mark - Accessors

- (TIMHomeNavButtonsView *)buttonsView {
    if (!_buttonsView) {
        _buttonsView = [TIMHomeNavButtonsView loadView];
    }
    return _buttonsView;
}

#pragma mark - Buttons 

- (UIBarButtonItem *)customButtonWithName:(NSString *)imageName selector:(SEL)aSel {
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 36)];
    UIButton *customButton = [[UIButton alloc] initWithFrame:customView.bounds];
    [customButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:@"btn_add_place_on.png"]
                  forState:UIControlStateHighlighted];
    [customButton addTarget:self action:aSel forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:customButton];
    return [[UIBarButtonItem alloc] initWithCustomView:customView];
}

- (void)addNavigationButtons {
    self.navigationItem.titleView = self.buttonsView;
    self.navigationItem.rightBarButtonItem = [self customButtonWithName:@"btn_add_place"
                                                                    selector:@selector(addImpression)];
}

#pragma mark - Navigation

- (void)pushLoginViewController {
    TIMLoginViewController *loginController = [[TIMLoginViewController alloc]
                                               initWithNibName:@"TIMLoginViewController"
                                               bundle:[NSBundle mainBundle]];
    TIMRegistrationNavController *registrationNavigation = [[TIMRegistrationNavController alloc]
                                                            initWithRootViewController:loginController];
    [self presentViewController:registrationNavigation animated:NO completion:nil];
}

#pragma mark - TableView Data source and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [self createInfoCellForTable:tableView atIndexPath:indexPath];
    } else {
        return [self createImpressionCellForTable:tableView atIndexPath:indexPath];
    }
}

- (TIMProfileInfoCell *)createInfoCellForTable:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"profileInfoCell";
    TIMProfileInfoCell* cell = (TIMProfileInfoCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        NSArray *topLevelItems = [[NSBundle mainBundle] loadNibNamed:@"TIMProfileInfoCell" owner:nil options:nil];
        cell = [topLevelItems lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    [cell setDataAndHeight];
    [cell cellDesign];
    return cell;
}

- (TIMProfileImpressionCell *)createImpressionCellForTable:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"impressionCell";
    TIMProfileImpressionCell* cell = (TIMProfileImpressionCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        NSArray *topLevelItems = [[NSBundle mainBundle] loadNibNamed:@"TIMProfileImpressionCell" owner:nil options:nil];
        cell = [topLevelItems lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    [cell customFonts];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //верстка
        return [self getaboutMySelfLabelHeight];
    }
    //верстка
    return 113;
}

- (CGFloat)getaboutMySelfLabelHeight{
    CGFloat allHeight = 0;
    NSDictionary* dict = [[TIMLocalUserInfo sharedInstance] descrAboutMeSizes];
    for (NSString* key in dict) {
        allHeight += [dict[key] floatValue];
    }
    return allHeight;
}

#pragma mark - Navigation actions
- (void)addImpression {
}

- (IBAction)settingBtnAction:(id)sender {
    TIMSetingsViewController* settingsViewController =
    [[TIMSetingsViewController alloc] init];
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

@end

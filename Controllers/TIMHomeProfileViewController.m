//
//  TIMHomeProfileViewController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMHomeProfileViewController.h"

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
    [self checkForLoginInformation];
    [self addNavigationButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkForLoginInformation {
    //проверка на информацию о логине. При отсутвии - переход на экран с логином.
    //На данный момент переход на экран логина осуществляется всегда для разработки экранов регистрации
    [self pushLoginViewController];
}

#pragma mark - Accessors

- (TIMHomeNavButtonsView *)buttonsView {
    if (!_buttonsView) {
        _buttonsView = [TIMHomeNavButtonsView loadView];
    }
    return _buttonsView;
}

#pragma mark - Buttons 

- (UIBarButtonItem *)customButtonWithImageName:(NSString *)imageName selector:(SEL)aSel {
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 36)];
    UIButton *customButton = [[UIButton alloc] initWithFrame:customView.bounds];
    [customButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [customButton addTarget:self action:aSel forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:customButton];
    return [[UIBarButtonItem alloc] initWithCustomView:customView];
}

- (void)addNavigationButtons {
    self.navigationItem.titleView = self.buttonsView;
    self.navigationItem.leftBarButtonItem = [self customButtonWithImageName:@"btn_menu"
                                                                   selector:@selector(showMenu)];
    self.navigationItem.rightBarButtonItem = [self customButtonWithImageName:@"btn_add_place"
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
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"profileInfoCell"];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"impressionCell"];
    }
    NSArray *topLevelObjects;
    if (cell == nil) {
        if (indexPath.row == 0) {
            topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TIMProfileInfoCell" owner:self options:nil];
        } else {
            topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TIMProfileImpressionCell" owner:self options:nil];
        }
        cell = [topLevelObjects objectAtIndex:0];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 167;
    }
    return 121;
}

#pragma mark - Navigation actions
- (void)showMenu {
}

- (void)addImpression {
}

@end

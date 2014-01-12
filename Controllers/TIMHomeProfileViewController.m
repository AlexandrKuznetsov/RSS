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
    //[self checkForLoginInformation];
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

- (void)menuButton {
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 36)];
    UIButton *customButton = [[UIButton alloc] initWithFrame:customView.bounds];
    [customButton setBackgroundImage:[UIImage imageNamed:@"btn_menu"] forState:UIControlStateNormal];
    [customButton addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:customButton];
    UIBarButtonItem *customItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.leftBarButtonItem = customItem;
}

- (void)addButton {
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 36)];
    UIButton *customButton = [[UIButton alloc] initWithFrame:customView.bounds];
    [customButton setBackgroundImage:[UIImage imageNamed:@"btn_add_place"] forState:UIControlStateNormal];
    [customButton addTarget:self action:@selector(addImpression) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:customButton];
    UIBarButtonItem *customItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.rightBarButtonItem = customItem;
}

- (void)addNavigationButtons {
    self.navigationItem.titleView = self.buttonsView;
    [self addButton];
    [self menuButton];
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

- (void)showMenu {
}

- (void)addImpression {
}

@end

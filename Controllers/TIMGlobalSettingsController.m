//
//  TIMGlobalSettingsController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 25.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMGlobalSettingsController.h"

@interface TIMGlobalSettingsController ()

@end

@implementation TIMGlobalSettingsController

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
    self.navigationItem.title = @"Настройки";
    [self setFontsToTextViewsInView:self.view];
    [self createNavigationOkBtn];
    [self settingsRequest];
}

- (void)viewWillAppear:(BOOL)animate {
    [super viewWillAppear:YES];
    [self setViewSizes];
    [super getCrrentUserLocation];
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Data 

- (void)settingsRequest {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[TIMAppSettingsModel sharedInstance] loadSettingsWithCompletition:^(NSError *error, id response) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (!error) {
            [self setButtonsForSettings:(TIMAppSettings *)response];
        } else {
            [self showAlertViewWithMessage:error.localizedDescription];
        }
    }];
}

#pragma mark - Interface

- (void)setButtonsForSettings:(TIMAppSettings *)settings {
    pushEnabled = settings.notifications;
    fbEnabled = settings.facebook;
    VkEnabled = settings.vk;
    odniklEnabled = settings.odnoklassniki;
    googleEnabled = settings.google;
    twitterEnabled = settings.twitter;
    
    _fbButton.active = fbEnabled;
    _notifButton.active = pushEnabled;
    _odnoklButton.active = odniklEnabled;
    _vkButton.active = VkEnabled;
    _googleButton.active = googleEnabled;
    _twitterButton.active = twitterEnabled;
}

- (void)createNavigationOkBtn{
    UIButton* okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(0, 0, 29, 29);
    [okBtn addTarget:self
              action:@selector(saveAction)
    forControlEvents:UIControlEventTouchUpInside];
    [okBtn setImage:[UIImage imageNamed:@"btn_ok_white.png"]
           forState:UIControlStateNormal];
    [okBtn setImage:[UIImage imageNamed:@"btn_ok_white_on.png"]
           forState:UIControlStateHighlighted];
    UIBarButtonItem* okBarButton = [[UIBarButtonItem alloc] initWithCustomView:okBtn];
    [self.navigationItem setRightBarButtonItem:okBarButton];
}

#pragma mark - Design 

- (void)setViewSizes {
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), SCROLL_SIZE);
    CGRect bgFrame = bgImageView.frame;
    bgFrame.size.height = SCROLL_SIZE;
    bgImageView.frame = bgFrame;
}

- (void)setFontsToTextViewsInView:(UIView*)editingView {
    for (UIView* view in [editingView subviews]) {
        if ([[view subviews] count] > 0) {
            [self setFontsToTextViewsInView:view];
        }
        if ([view isKindOfClass:([UILabel class])]) {
            UILabel* currentLabel = (UILabel*)view;
            currentLabel.font = [UIFont lightFontWithSize:currentLabel.font.pointSize];
        }
        if ([view isKindOfClass:([UITextField class])]) {
            UITextField* currentTextField = (UITextField*)view;
            currentTextField.font = [UIFont lightFontWithSize:currentTextField.font.pointSize];
        }
        if ([view isKindOfClass:([UITextView class])]) {
            UITextView* currentTextView = (UITextView*)view;
            currentTextView.font = [UIFont lightFontWithSize:currentTextView.font.pointSize];
        }
    }
}

- (void)hideKeyboardForView:(UIView *)view {
    for (UIView* objView in [view subviews]) {
        if ([[objView subviews] count] > 0) {
            [self setFontsToTextViewsInView:objView];
        }
        if ([objView isKindOfClass:([UITextField class])]) {
            UITextField* currentTextField = (UITextField*)objView;
            [currentTextField resignFirstResponder];
        }
    }
}

#pragma mark - Navigation 

- (void)pushResetPassController {
    TIMResetPassController *resetPassController = [[TIMResetPassController alloc]
                                                   initWithNibName:@"TIMResetPassController"
                                                   bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:resetPassController animated:YES];
}

#pragma mark - Actions

- (void)saveAction {
    [TIMAppSettingsModel sharedInstance].pushEnabled = pushEnabled;
    [TIMAppSettingsModel sharedInstance].fbEnabled = fbEnabled;
    [TIMAppSettingsModel sharedInstance].VkEnabled = VkEnabled;
    [TIMAppSettingsModel sharedInstance].odniklEnabled = odniklEnabled;
    [TIMAppSettingsModel sharedInstance].twitterEnabled = twitterEnabled;
    [TIMAppSettingsModel sharedInstance].googleEnabled = googleEnabled;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[TIMAppSettingsModel sharedInstance] saveSettingsWithCompletition:^(NSError *error, id response) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (!error) {
        } else {
            [self showAlertViewWithMessage:error.localizedDescription];
        }
    }];
}


- (IBAction)pushAction:(TIMSwichButton *)sender {
    pushEnabled = !pushEnabled;
    [sender setActive:pushEnabled];
}

- (IBAction)fbAction:(TIMSwichButton *)sender {
    fbEnabled = !fbEnabled;
    [sender setActive:fbEnabled];
}

- (IBAction)vkAction:(TIMSwichButton *)sender {
    VkEnabled = !VkEnabled;
    [sender setActive:VkEnabled];
}

- (IBAction)odnoklAction:(TIMSwichButton *)sender {
    odniklEnabled = !odniklEnabled;
    [sender setActive:odniklEnabled];
}

- (IBAction)googleAction:(TIMSwichButton *)sender {
    googleEnabled = !googleEnabled;
    [sender setActive:googleEnabled];
}

- (IBAction)twitterAction:(TIMSwichButton *)sender {
    twitterEnabled = !twitterEnabled;
    [sender setActive:twitterEnabled];
}

- (IBAction)resetPass:(id)sender {
    [self pushResetPassController];
}

- (IBAction)hideAction:(id)sender {
    [self hideKeyboardForView:scrollView];
}

@end

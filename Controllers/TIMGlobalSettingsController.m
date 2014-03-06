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
    if ([TIMAppSettingsModel sharedInstance].needUpdate) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[TIMAppSettingsModel sharedInstance] loadSettingsWithCompletition:^(NSError *error, id response) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if (!error) {
                [TIMAppSettingsModel sharedInstance].needUpdate = NO;
                [self setButtonsForSettings:(TIMAppSettings *)response];
            } else {
                [self showAlertViewWithMessage:error.localizedDescription];
            }
        }];
    }
}

- (NSNumber *)indexOfString:(NSString *)string inArray:(NSUInteger)fieldTag {
    NSArray *searchArray;
    NSNumber *foundedIndex;
    if (fieldTag == 113) {
        //mail
        searchArray = [_staticModel notificationsArray];
    }
    if (fieldTag == 104) {
        //language
        searchArray = [_staticModel languageArray];
    }
    if (fieldTag == 114) {
        //search
        searchArray = [_staticModel searchArray];
    }
    if (fieldTag == 115) {
        //sync
        searchArray = [_staticModel synchronizeArray];
    }
    for (NSString *obj in searchArray) {
        if ([obj isEqualToString:string]) {
            foundedIndex = @([searchArray indexOfObject:obj]);
        }
    }
    return foundedIndex;
}

#pragma mark - Interface

- (void)setButtonsForSettings:(TIMAppSettings *)settings {
    pushEnabled = settings.notifications;
    fbEnabled = settings.facebook;
    VkEnabled = settings.vk;
    odniklEnabled = settings.odnoklassniki;
    googleEnabled = settings.google;
    twitterEnabled = settings.twitter;
    _mailField.hidden = NO;
    _languageField.hidden = NO;
    _searchField.hidden = NO;
    _syncField.hidden = NO;
    
    if (settings.mails) {
        _mailField.text = [[_staticModel notificationsArray] objectAtIndex:[settings.mails integerValue]];
    }
    if (settings.language) {
        _languageField.text = [[_staticModel languageArray] objectAtIndex:[settings.language integerValue]];
    }
    if (settings.search) {
        _searchField.text = [[_staticModel searchArray] objectAtIndex:[settings.search integerValue]];
    }
    if (settings.sync) {
        _syncField.text = [[_staticModel synchronizeArray] objectAtIndex:[settings.sync integerValue]];
    }
    
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
    [TIMAppSettingsModel sharedInstance].mails = [self indexOfString:_mailField.text inArray:_mailField.tag];
    [TIMAppSettingsModel sharedInstance].search = [self indexOfString:_searchField.text inArray:_searchField.tag];
    [TIMAppSettingsModel sharedInstance].sync = [self indexOfString:_syncField.text inArray:_syncField.tag];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[TIMAppSettingsModel sharedInstance] saveSettingsWithCompletition:^(NSError *error, id response) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (!error) {
            NSLog(@"OK");
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

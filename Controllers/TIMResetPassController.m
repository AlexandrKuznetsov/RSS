//
//  TIMResetPassController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 29.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMResetPassController.h"

@interface TIMResetPassController ()

@end

@implementation TIMResetPassController

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
    self.navigationItem.title = @"Изменить пароль";
    [self customFonts];
    [self createNavigationOkBtn];
}

- (void)viewWillAppear:(BOOL)animate {
    [super viewWillAppear:YES];
    [super getCrrentUserLocation];
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customFonts {
    oldMailField.font = [UIFont regularFontWithSize:oldMailField.font.pointSize];
    newPassField.font = [UIFont regularFontWithSize:newPassField.font.pointSize];
    confirmPassField.font = [UIFont regularFontWithSize:confirmPassField.font.pointSize];

}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
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

- (void)hideKeyboard {
    [oldMailField resignFirstResponder];
    [newPassField resignFirstResponder];
    [confirmPassField resignFirstResponder];
}

- (void)saveAction {
    if ([self isValidData]) {
        [TIMAppSettingsModel sharedInstance].passNew = newPassField.text;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       [[TIMAppSettingsModel sharedInstance] changePasswordWithCompletition:^(NSError *error, id response) {
           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
           if (!error) {
               NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[TIMKeychain load:KEYCHAIN_SERVICE]];
               [dict setObject:newPassField.text forKey:@"password"];
               [TIMKeychain save:KEYCHAIN_SERVICE data:dict];
           } else {
               [self showAlertViewWithMessage:error.localizedDescription];
           }
       }];
    }
}

- (BOOL)isValidData {
    if (oldMailField.text.length == 0) {
        [self showAlertWithMessage:@"Введите старый пароль"];
        return NO;
    }
    NSDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[TIMKeychain load:KEYCHAIN_SERVICE]];
    if (![dict[@"password"] isEqualToString:oldMailField.text]) {
        [self showAlertWithMessage:@"Введите правильный пароль"];
        return NO;
    }
    if (newPassField.text.length == 0) {
        [self showAlertWithMessage:@"Введите новый пароль"];
        return NO;
    }
    if (confirmPassField.text.length == 0) {
        [self showAlertWithMessage:@"Подтвердите пароль"];
        return NO;
    }
    if (![newPassField.text isEqualToString:confirmPassField.text]) {
        [self showAlertWithMessage:@"Пароли не совпадают"];
        return NO;
    }
    return YES;
}

- (IBAction)hideAction:(id)sender {
    [self hideKeyboard];
}

- (IBAction)save:(id)sender {
    [self saveAction];
}

#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self hideKeyboard];
    return YES;
}

@end

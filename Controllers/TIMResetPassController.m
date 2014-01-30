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
        //save
    }
}

- (BOOL)isValidData {
    if (![newPassField.text isEqualToString:confirmPassField.text]) {
        [self showAlertWithMessage:@"Пароли не совпадают"];
        return NO;
    }
    return YES;
}

- (IBAction)hideAction:(id)sender {
    [self hideKeyboard];
}

#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self hideKeyboard];
    return YES;
}

@end

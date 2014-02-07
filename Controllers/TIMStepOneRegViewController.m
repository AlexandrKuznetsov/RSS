//
//  TIMStepOneRegViewController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMStepOneRegViewController.h"

@interface TIMStepOneRegViewController ()

@end

@implementation TIMStepOneRegViewController

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
    [_scrollView setContentSize:CGSizeMake(_scrollView.contentSize.width,
                                           (CGRectGetMaxY(continueBtn.frame) +
                                            REGISTRATION_OFFSET_FROM_NEXT_STEP_BTN))];
    [self setFontToTextFields];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super getCrrentUserLocation];
    [self.locationManager startUpdatingLocation];
}

- (void)setFontToTextFields{
    top1label.font = [UIFont boldFontWithSize:top1label.font.pointSize];
    repeatPasswordTextField.font = [UIFont regularFontWithSize:repeatPasswordTextField.font.pointSize];
    passwordTextField.font = [UIFont regularFontWithSize:passwordTextField.font.pointSize];
    mailTextField.font = [UIFont regularFontWithSize:mailTextField.font.pointSize];
}

- (void)showAlertViewWithMessage:(NSString *)message {
    UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:@"Ошибка"
                                                       message:message
                                                      delegate:nil
                                             cancelButtonTitle:@"Закрыть"
                                             otherButtonTitles:nil, nil];
    [alerView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registrationRequest {
    __weak TIMStepOneRegViewController* weakSelf = self;
    [[TIMRegistrationModel sharedInstance] registerRequestWithCompletition:^(NSString *errorDescription, BOOL status) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (status) {
            [weakSelf pushStepTwo];
        } else {
            [weakSelf showAlertViewWithMessage:errorDescription];
        }
    }];
}

- (IBAction)goToNextStep:(id)sender {
    if ([self checkIsDataValid]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[TIMRegistrationModel sharedInstance] saveLogin:mailTextField.text
                                                password:passwordTextField.text];
        [self registrationRequest];
    }
}

- (void)saveDataToLocalUserInfo{
    [[TIMLocalUserInfo sharedInstance] setEmail:mailTextField.text];
}

- (BOOL)checkIsDataValid{
    NSString* problem = [self checkFirsStepRegistration:mailTextField.text
                                                   pass:passwordTextField.text
                                         andConfirmPass:repeatPasswordTextField.text];
    if (!problem) {
        return YES;
    } else {
        [self showAlertViewWithMessage:problem];
        return NO;
    }
}

- (void)pushStepTwo {
    mailTextField.text = @"";
    [mailTextField resignFirstResponder];
    passwordTextField.text = @"";
    [passwordTextField resignFirstResponder];
    repeatPasswordTextField.text = @"";
    [repeatPasswordTextField resignFirstResponder];
    
    TIMStepTwoRegViewController *stepTwoController = [[TIMStepTwoRegViewController alloc]
                                                      initWithNibName:@"TIMStepTwoRegViewController"
                                                      bundle:[NSBundle mainBundle]];
    stepTwoController.mapView = self.mapView;
    [self.navigationController pushViewController:stepTwoController animated:YES];
}

@end

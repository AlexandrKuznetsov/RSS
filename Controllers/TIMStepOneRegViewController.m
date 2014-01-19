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
    top1label.font = [UIFont boldFontWithSize:17];
    repeatPasswordTextField.font = [UIFont regularFontWithSize:12];
    passwordTextField.font = [UIFont regularFontWithSize:12];
    mailTextField.font = [UIFont regularFontWithSize:12];
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
    [[TIMRegistrationModel sharedInstance] registerRequestWithCompletition:^(NSString *errorDescription, BOOL status) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (status) {
            [self pushStepTwo];
        } else {
            [self showAlertViewWithMessage:errorDescription];
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

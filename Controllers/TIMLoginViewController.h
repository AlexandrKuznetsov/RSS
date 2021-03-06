//
//  TIMLoginViewController.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "TIMStepOneRegViewController.h"
#import "TIMLoginButton.h"
#import "UIFont+TIFonts.h"
#import "TIMAPIRequests.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "TIMStatisticsModel.h"
#import "TIMStatistic.h"

#define LOGIN_FIELD_TAG 1
#define PASSWORD_FIELD_TAG 2
#define MAIL_FIELD_TAG 3

@interface TIMLoginViewController : UIViewController < UITextFieldDelegate >

@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIView *fieldsView;

@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UIView *forgetView;
@property (weak, nonatomic) IBOutlet UIView *statisticView;

@property (weak, nonatomic) IBOutlet UIButton *registrationButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetButtonOutlet;

@property (weak, nonatomic) IBOutlet TIMLoginButton *loginButtonOutlet;

@property (weak, nonatomic) IBOutlet UILabel *errorTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UILabel *forgetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *usersCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *usersLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationsLabel;
@property (weak, nonatomic) IBOutlet UILabel *impressionsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *impressionsLabel;
@property (weak, nonatomic) IBOutlet UIView *mailFieldView;
@property (weak, nonatomic) IBOutlet UITextField *mailField;
@property (weak, nonatomic) IBOutlet UILabel *mailTextlabel;
@property (weak, nonatomic) IBOutlet UILabel *backLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)showLoginFields:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)goToRegistration:(id)sender;
- (IBAction)hideErrorView:(id)sender;
- (IBAction)openMail:(id)sender;
- (IBAction)showForgetView:(id)sender;
- (IBAction)sendPassOnMail:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)hide:(id)sender;


@end

//
//  TIMLoginViewController.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TIMStepOneRegViewController.h"

@interface TIMLoginViewController : UIViewController < UITextFieldDelegate >

@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIView *fieldsView;
@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UIView *forgetView;
@property (weak, nonatomic) IBOutlet UIButton *registrationButton;
- (IBAction)showLoginFields:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)goToRegistration:(id)sender;
- (IBAction)hideErrorView:(id)sender;
- (IBAction)openMail:(id)sender;
- (IBAction)showForgetView:(id)sender;


@end

//
//  TIMLoginViewController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMLoginViewController.h"

@interface TIMLoginViewController ()

@end

@implementation TIMLoginViewController

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
    [self design];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushRegistrationViewController {
    TIMStepOneRegViewController *registraionController = [[TIMStepOneRegViewController alloc]
                                                        initWithNibName:@"TIMStepOneRegViewController"
                                                            bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:registraionController animated:YES];
}

#pragma mark - Design

- (void)design {
    if([UIViewController instancesRespondToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.loginField setValue:[UIColor colorWithWhite:0.5 alpha:1.0]
                       forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordField setValue:[UIColor colorWithWhite:0.5 alpha:1.0]
                          forKeyPath:@"_placeholderLabel.textColor"];
}

#pragma mark - UI
- (void)presentFieldsView {
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.loginView.alpha = 0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5 animations:^{
                             self.fieldsView.alpha = 1;
                         }];
                     }];
}

- (void)animateView:(id)view hide:(BOOL)isHide {
    UIView *animatedView;
    BOOL action;
    if ([view isKindOfClass:[NSArray class]]) {
        animatedView = view[0];
        action = (BOOL)view[1];
    } else {
        animatedView = view;
        action = isHide;
    }
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.fieldsView.alpha = (action ? 1 : 0);
                         self.registrationButton.alpha = (action ? 1 : 0);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5 animations:^{
                             animatedView.alpha = (action ? 0 : 1);
                         }];
                     }];
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"ОК"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)hideKeyBoard {
    [self.loginField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

- (void)fieldsWithError {
    self.loginField.textColor = [UIColor redColor];
    self.passwordField.textColor = [UIColor redColor];
}

- (void)fieldsWithoutError {
    self.loginField.textColor = [UIColor whiteColor];
    self.passwordField.textColor = [UIColor whiteColor];
}

- (void)showLoginError {
    [self fieldsWithError];
    [self animateView:self.errorView hide:NO];
    [self performSelector:@selector(animateView:hide:)
               withObject:@[self.errorView, @(NO)]
               afterDelay:5.0f];
}

#pragma mark - Data

- (void) sendImpressionsRequest {
    
}

- (void) sendLogin:(NSString *)login andPassword:(NSString *)password {
    [self showLoginError];
}

#pragma mark - Actions

- (IBAction)showLoginFields:(id)sender {
    [self presentFieldsView];
}

- (IBAction)login:(id)sender {
    [self hideKeyBoard];
    if ([self isAllFieldsAreValid]) {
        [self sendLogin:self.loginField.text andPassword:self.passwordField.text];
    }
}

- (IBAction)goToRegistration:(id)sender {
    [self pushRegistrationViewController];
}

- (IBAction)hideErrorView:(id)sender {
    [self animateView:self.errorView hide:YES];
}

- (IBAction)openMail:(id)sender {
    [self animateView:self.forgetView hide:YES];
}

- (IBAction)showForgetView:(id)sender {
    //отправка запроса на забывание пароля
    [self animateView:self.forgetView hide:NO];
}

#pragma mark - Checks 

- (BOOL)isAllFieldsAreValid {
    if (self.loginField.text.length == 0) {
        [self showAlertWithMessage:@"Введите e-mail"];
        return NO;
    }
    if (![self emailIsValid:self.loginField.text]) {
        [self showAlertWithMessage:@"Введите правильный e-mail"];
        self.loginField.textColor = [UIColor redColor];
        return NO;
    }
    if (self.passwordField.text.length == 0) {
        [self showAlertWithMessage:@"Введите пароль"];
        return NO;
    }
    return YES;
}

- (BOOL)emailIsValid:(NSString *)mail {
    // Note: You cannot correctly validate an email address with regular
	// expressions alone. http://www.regular-expressions.info/email.html
    
	NSString* pattern = @"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}";
	NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
	return [predicate evaluateWithObject:mail];
}


#pragma mark - Delegates
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self fieldsWithoutError];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self hideKeyBoard];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self hideKeyBoard];
    return YES;
}

@end

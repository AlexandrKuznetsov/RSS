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
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self sendImpressionsRequest];
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
    [self customizeFonts];
    [self.loginField setValue:[UIColor colorWithWhite:0.5 alpha:1.0]
                       forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordField setValue:[UIColor colorWithWhite:0.5 alpha:1.0]
                          forKeyPath:@"_placeholderLabel.textColor"];
    [self.mailField setValue:[UIColor colorWithWhite:0.5 alpha:1.0]
                      forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)customizeFonts {
    self.usersCountLabel.font = [UIFont semiBoldFontWithSize:14.0f];
    self.destinationsCountLabel.font = [UIFont semiBoldFontWithSize:14.0f];
    self.impressionsCountLabel.font = [UIFont semiBoldFontWithSize:14.0f];
    
    self.usersLabel.font = [UIFont regularFontWithSize:10.0f];
    self.destinationsLabel.font = [UIFont regularFontWithSize:10.0f];
    self.impressionsLabel.font = [UIFont regularFontWithSize:10.0f];

    self.registrationButton.titleLabel.font = [UIFont regularFontWithSize:18];
    self.forgetButtonOutlet.titleLabel.font = [UIFont regularFontWithSize:18];
    
    self.errorLabel.font = [UIFont semiBoldFontWithSize:15.0f];
    self.errorTextLabel.font = [UIFont lightFontWithSize:15.0f];
    
    self.forgetTextLabel.font = [UIFont semiBoldFontWithSize:15.0f];
    self.mailTextlabel.font = [UIFont semiBoldFontWithSize:15.0f];
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

- (void)presentForgotView {
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.mailFieldView.alpha = 0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5 animations:^{
                             self.forgetView.alpha = 1;
                         }];
                     }];
}

- (void)hideForgetView {
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.forgetView.alpha = 0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5 animations:^{
                             self.fieldsView.alpha = 1;
                             self.registrationButton.alpha = 1;
                         }];
                     }];
}

- (void)showErrorView {
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.fieldsView.alpha = 0;
                         self.registrationButton.alpha = 0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5 animations:^{
                             self.errorView.alpha = 1;
                         }];
                     }];
}

- (void)hideError {
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.errorView.alpha = 0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5 animations:^{
                             self.fieldsView.alpha = 1;
                             self.registrationButton.alpha = 1;
                         }];
                     }];
}

- (void)showForgetFieldView {
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.fieldsView.alpha = 0;
                         self.registrationButton.alpha = 0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5 animations:^{
                             self.mailFieldView.alpha = 1;
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
    self.errorTextLabel.text = @"Вы ввели неправильную комбинацию логина и пароля. Повтрите пожалуйста ввод.";
    [self fieldsWithError];
    [self showErrorView];
    [self performSelector:@selector(hideError)
               withObject:nil
               afterDelay:5.0f];
}

- (void)resizeScrollView {
    CGSize scrollSize = self.scrollView.contentSize;
    if (scrollSize.height == 0) {
        if (IS_IPHONE5) {
            scrollSize.height = scrollSize.height + 738;
        } else {
            scrollSize.height = scrollSize.height + 670;
        }
        [UIView animateWithDuration:0.2f animations:^{
            self.scrollView.contentSize = scrollSize;
        }];
    }
}

- (void)standartScrollSize {
    [UIView animateWithDuration:0.2f animations:^{
        self.scrollView.contentSize = CGSizeZero;
    }];
}

- (void)changeOffsetForTextField:(UITextField *)textField {
    CGPoint contentOffset;
    if (textField.tag == LOGIN_FIELD_TAG) {
        CGFloat y = (IS_IPHONE5) ? 60 : 120;
        contentOffset = CGPointMake(0, y);
    } else {
        CGFloat y = (IS_IPHONE5) ? 60 : 120;
        contentOffset = CGPointMake(0, y);
    }
    [self.scrollView setContentOffset:contentOffset animated:YES];
}

- (void)setStatisticsLabel:(TIMStatistic *)stat {
    self.impressionsCountLabel.text = [NSString stringWithFormat:@"%d", stat.impressions];
    self.usersCountLabel.text = [NSString stringWithFormat:@"%d", stat.users];
    self.destinationsCountLabel.text = [NSString stringWithFormat:@"%d", stat.locations];
    self.statisticView.hidden = NO;
}

#pragma mark - Data

- (void) sendImpressionsRequest {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    TIMStatisticsModel *model = [[TIMStatisticsModel alloc] init];
    [model loadStatisticWithCompletition:^(TIMStatistic *data, BOOL status, NSString *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (status) {
            [self setStatisticsLabel:data];
        } else {
            self.errorTextLabel.text = @"Отсутствует интернет подключение!";
            [self showErrorView];
        }
    }];
}

- (void) sendLogin:(NSString *)login andPassword:(NSString *)password {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[TIMAPIRequests sharedManager] postEmail:login password:password withCompletition:^(NSError *error, id response) {
        if (error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ((error.code == NSURLErrorNotConnectedToInternet) || (error.code == NSURLErrorTimedOut)) {
                self.errorTextLabel.text = @"Отсутствует интернет подключение!";
                [self showErrorView];
            } else {
                [self showLoginError];
            }
        } else {
            if (response) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }];
}

- (void)sendPasswordRequest:(NSString *)mail {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[TIMAPIRequests sharedManager] sendPasswordOnMail:mail withCompletition:^(NSError *error, id response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            if ((error.code == NSURLErrorNotConnectedToInternet) || (error.code == NSURLErrorTimedOut)) {
                [self showAlertWithMessage:@"Отсутствует интернет подключение!"];
            } else {
                [self showAlertWithMessage:@"Ошибка сервера"];
            }
        } else {
            [self presentForgotView];
        }
    }];
}

#pragma mark - Actions

- (IBAction)showLoginFields:(id)sender {
    [self presentFieldsView];
}

- (IBAction)login:(id)sender {
    [self standartScrollSize];
    [self hideKeyBoard];
    if ([self isAllFieldsAreValid]) {
        [self sendLogin:self.loginField.text andPassword:self.passwordField.text];
    }
}

- (IBAction)goToRegistration:(id)sender {
    [self pushRegistrationViewController];
}

- (IBAction)hideErrorView:(id)sender {
    [self hideError];
}

- (IBAction)openMail:(id)sender {
    [self hideForgetView];
}

- (IBAction)showForgetView:(id)sender {
    [self showForgetFieldView];
}

- (IBAction)sendPassOnMail:(id)sender {
    [self standartScrollSize];
    [self.mailField resignFirstResponder];
    if ([self emailIsValid:self.mailField.text]) {
        [self sendPasswordRequest:self.mailField.text];
    } else {
        [self showAlertWithMessage:@"E-Mail адресс введен неправильно"];
    }
}

#pragma mark - Checks

- (BOOL)isAllFieldsAreValid {
    if (self.loginField.text.length == 0) {
        self.errorTextLabel.text = @"Введите e-mail";
        [self showErrorView];
        return NO;
    }
    if (![self emailIsValid:self.loginField.text]) {
        self.errorTextLabel.text = @"Введите правильный e-mail";
        [self showErrorView];
        self.loginField.textColor = [UIColor redColor];
        return NO;
    }
    if (self.passwordField.text.length == 0) {
        self.errorTextLabel.text = @"Введите пароль";
        [self showErrorView];
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
    [self resizeScrollView];
    [self changeOffsetForTextField:textField];
    if (textField.tag != MAIL_FIELD_TAG) {
        [self fieldsWithoutError];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self hideKeyBoard];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self standartScrollSize];
    [self hideKeyBoard];
    return YES;
}

@end

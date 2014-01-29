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

#pragma mark - Design 

- (void)setViewSizes {
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), SCROLL_SIZE);
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

#pragma mark - Navigation 

- (void)pushResetPassController {
    TIMResetPassController *resetPassController = [[TIMResetPassController alloc]
                                                   initWithNibName:@"TIMResetPassController"
                                                   bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:resetPassController animated:YES];
}

#pragma mark - Actions

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

@end

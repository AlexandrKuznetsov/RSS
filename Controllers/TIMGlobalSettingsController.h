//
//  TIMGlobalSettingsController.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 25.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMRegistrationViewController.h"
#import "TIMResetPassController.h"
#import "TIMSwichButton.h"
#import "TIMAppSettingsModel.h"
#import "TIMAppSettings.h"

#define SCROLL_SIZE 662

@interface TIMGlobalSettingsController : TIMRegistrationViewController {
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIImageView *bgImageView;
    __weak IBOutlet TIMSwichButton *_notifButton;
    __weak IBOutlet TIMSwichButton *_googleButton;
    __weak IBOutlet TIMSwichButton *_odnoklButton;
    __weak IBOutlet TIMSwichButton *_vkButton;
    __weak IBOutlet TIMSwichButton *_fbButton;
    __weak IBOutlet TIMSwichButton *_twitterButton;
    __weak IBOutlet UITextField *_mailField;
    __weak IBOutlet UITextField *_languageField;
    __weak IBOutlet UITextField *_searchField;
    __weak IBOutlet UITextField *_syncField;

    BOOL pushEnabled;
    BOOL fbEnabled;
    BOOL VkEnabled;
    BOOL odniklEnabled;
    BOOL googleEnabled;
    BOOL twitterEnabled;
}
- (IBAction)pushAction:(TIMSwichButton *)sender;
- (IBAction)fbAction:(TIMSwichButton *)sender;
- (IBAction)vkAction:(TIMSwichButton *)sender;
- (IBAction)odnoklAction:(TIMSwichButton *)sender;
- (IBAction)googleAction:(TIMSwichButton *)sender;
- (IBAction)twitterAction:(TIMSwichButton *)sender;
- (IBAction)resetPass:(id)sender;
- (IBAction)hideAction:(id)sender;

@end

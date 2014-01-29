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

#define SCROLL_SIZE 662

@interface TIMGlobalSettingsController : TIMRegistrationViewController {
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIImageView *bgImageView;
    
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

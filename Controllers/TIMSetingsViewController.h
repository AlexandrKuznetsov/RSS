//
//  TIMSetingsViewController.h
//  TrueIMPRESSION
//
//  Created by fist on 1/17/14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMRegistrationViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "TIMContinueButton.h"
#import "TIMRoundedImageView.h"
#import "TIMPhotoButtons.h"

@interface TIMSetingsViewController : TIMRegistrationViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, TIMPhotoButtonsDelegate,UITextViewDelegate>{
    
    BOOL anonymousUser;
    photoBtnsEnam currentImageView;
    __weak IBOutlet TIMContinueButton *btnSave;
    __weak IBOutlet UITextField *textFiewldMyProfession;
    __weak IBOutlet UILabel *labelMyProfession;
    __weak IBOutlet UITextField *textFieldMyImpressions;
    __weak IBOutlet UILabel *labelMyImpressions;
    __weak IBOutlet UITextField *textFieldMyInterests;
    __weak IBOutlet UILabel *labelMyInterests;
    __weak IBOutlet UITextField *textFiewlMyLocation;
    __weak IBOutlet UILabel *labelMyLocation;
    __weak IBOutlet UILabel *labelHoCanSeeMyInfo;
    __weak IBOutlet UILabel *labelIsAnonymousUser;
    __weak IBOutlet UILabel *labelPrivacy;
    __weak IBOutlet UIView *textViewAboveMySelfInfo;
    __weak IBOutlet UILabel *labelAboutMySelf;
    __weak IBOutlet UITextField *textFiewldProfession;
    __weak IBOutlet UILabel *labelProfession;
    __weak IBOutlet UITextField *textFieldInterestsDescr;
    __weak IBOutlet UILabel *labelInterestsList;
    __weak IBOutlet UILabel *labelInterests;
    __weak IBOutlet UITextField *textFieldCountry;
    __weak IBOutlet UILabel *labelCountry;
    __weak IBOutlet UILabel *labelCity;
    __weak IBOutlet UITextField *textFieldCity;
    __weak IBOutlet UILabel *labelBirthday;
    __weak IBOutlet UITextField *textFieldBirthday;
    __weak IBOutlet UILabel *labelSecondName;
    __weak IBOutlet UITextField *textFieldSeconName;
    __weak IBOutlet UITextField *textFieldName;
    __weak IBOutlet UILabel *labelName;
    __weak IBOutlet UILabel *labelPersonalInfo;
    __weak IBOutlet TIMPhotoButtons *photoBtnCover;
    __weak IBOutlet UILabel *labelFon;
    __weak IBOutlet UILabel *labelProfilePhoto;
    __weak IBOutlet TIMPhotoButtons *photoBtnsAvatar;
    __weak IBOutlet UIImageView *imageViewFon;
    __weak IBOutlet TPKeyboardAvoidingScrollView *_scrollView;
    __weak IBOutlet UITextView *textViewAboutMySelf;
    __weak IBOutlet UIButton *swicherBtn;
}

@property (weak, nonatomic) IBOutlet TIMRoundedImageView *imageViewAvatar;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCover;

- (IBAction)saveAction:(id)sender;
- (IBAction)swicherBtnAction:(id)sender;

@end

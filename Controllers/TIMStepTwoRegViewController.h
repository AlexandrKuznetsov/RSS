//
//  TIMStepTwoRegViewController.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMRegistrationViewController.h"
#import "TIMStepThreeRegViewController.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface TIMStepTwoRegViewController : TIMRegistrationViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    
    __weak IBOutlet UILabel *top2Label;
    __weak IBOutlet UILabel *makePhotoLabel;
    __weak IBOutlet UILabel *loadPhotoButton;
    __weak IBOutlet UILabel *deletePhotoLabel;
    __weak IBOutlet UIButton *nextStepBtn;
    __weak IBOutlet UIButton *removePhotoBtn;
    __weak IBOutlet UIButton *loadPhotoBtn;
    __weak IBOutlet UIButton *makePhotoBtn;
    __weak IBOutlet UIImageView *avatarImageView;
    __weak IBOutlet UITextField *userLanguageTextField;
    __weak IBOutlet UILabel *userLanguageLabel;
    __weak IBOutlet UITextField *userGenderTextField;
    __weak IBOutlet UILabel *userGenderLabel;
    __weak IBOutlet UITextField *birthdayTextField;
    __weak IBOutlet UILabel *birthdayLabel;
    __weak IBOutlet UITextField *userSecondNameTextField;
    __weak IBOutlet UILabel *userSecondNameLabel;
    __weak IBOutlet UITextField *userNameTextField;
    __weak IBOutlet UILabel *userNameLabel;
    __weak IBOutlet UILabel *profilePhotoLabel;
    __weak IBOutlet UILabel *appLanguageLabel;
    __weak IBOutlet UILabel *personalInfoLabel;
    __weak IBOutlet UILabel *headerLabel;
    __weak IBOutlet TPKeyboardAvoidingScrollView *_scrollView;
}

- (IBAction)goToNextStep:(id)sender;
- (IBAction)makePhotoAction:(id)sender;
- (IBAction)loadPhotoAction:(id)sender;
- (IBAction)deletePhotoAction:(id)sender;
- (IBAction)chooseBirthdayAction:(id)sender;
- (IBAction)chooseGenderAction:(id)sender;
- (IBAction)chooseLenguageAction:(id)sender;


@end

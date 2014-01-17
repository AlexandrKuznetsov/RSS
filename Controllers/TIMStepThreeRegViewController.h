//
//  TIMStepThreeRegViewController.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMRegistrationViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "TIMContinueButton.h"

#define SCROLL_HEIGHT 548
#define TESXTVIEW_STANDART_HEIGHT 28
#define PICKER_RECT CGRectMake(0, 200, 320, 200)

enum FieldType {
    Country = 1,
    Interests,
    Profession
    };

@interface TIMStepThreeRegViewController : TIMRegistrationViewController <UITextViewDelegate, UITextFieldDelegate, UIPickerViewDataSource , UIPickerViewDelegate, CLLocationManagerDelegate> {
    NSArray *_pickerDataSource;
}

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *aboutFieldPlaceholder;
@property (weak, nonatomic) IBOutlet UITextView *aboutTextView;
@property (weak, nonatomic) IBOutlet UIImageView *registerBackgrImageView;
@property (weak, nonatomic) IBOutlet TIMContinueButton *regButtonOutlet;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *interstsLabel;
@property (weak, nonatomic) IBOutlet UILabel *professionLabel;
@property (weak, nonatomic) IBOutlet UITextField *cityNameField;
@property (weak, nonatomic) IBOutlet UITextField *countryNameField;
@property (weak, nonatomic) IBOutlet UILabel *interestsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentProfessionLabel;


- (IBAction)finishRegistration:(id)sender;

@end

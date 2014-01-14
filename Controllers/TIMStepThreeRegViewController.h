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

@interface TIMStepThreeRegViewController : TIMRegistrationViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *aboutFieldPlaceholder;
@property (weak, nonatomic) IBOutlet UITextView *aboutTextView;
@property (weak, nonatomic) IBOutlet UIImageView *registerBackgrImageView;
@property (weak, nonatomic) IBOutlet TIMContinueButton *regButtonOutlet;

- (IBAction)finishRegistration:(id)sender;

@end

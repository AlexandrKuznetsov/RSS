//
//  TIMStepOneRegViewController.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMRegistrationViewController.h"
#import "TIMStepTwoRegViewController.h"


@interface TIMStepOneRegViewController : TIMRegistrationViewController{
    
    __weak IBOutlet UILabel *top1label;
    __weak IBOutlet UIButton *continueBtn;
    __weak IBOutlet UITextField *repeatPasswordTextField;
    __weak IBOutlet UITextField *passwordTextField;
    __weak IBOutlet UITextField *mailTextField;
    
}

- (IBAction)goToNextStep:(id)sender;

@end

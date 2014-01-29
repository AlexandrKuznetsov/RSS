//
//  TIMResetPassController.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 29.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMRegistrationViewController.h"

@interface TIMResetPassController : TIMRegistrationViewController < UITextFieldDelegate >{
    
    __weak IBOutlet UITextField *oldMailField;
    __weak IBOutlet UITextField *newPassField;
    __weak IBOutlet UITextField *confirmPassField;
}
- (IBAction)hideAction:(id)sender;

@end

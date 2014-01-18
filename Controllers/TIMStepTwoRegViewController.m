//
//  TIMStepTwoRegViewController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMStepTwoRegViewController.h"


@interface TIMStepTwoRegViewController ()

@end

@implementation TIMStepTwoRegViewController

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
    if (!self.mapView) {
        [self.locationManager startUpdatingLocation];
    }
    int maxY = CGRectGetMaxY(nextStepBtn.frame) + REGISTRATION_OFFSET_FROM_NEXT_STEP_BTN;
    [_scrollView setContentSize:CGSizeMake(_scrollView.contentSize.width,
                                           maxY)];
    [self createCustomFonts];
}


- (void)createCustomFonts{
    top2Label.font = [UIFont boldFontWithSize:17];
    makePhotoLabel.font = [UIFont lightFontWithSize:11];
    loadPhotoButton.font = [UIFont lightFontWithSize:11];
    deletePhotoLabel.font = [UIFont lightFontWithSize:11];
    userNameLabel.font = [UIFont lightFontWithSize:13];
    userLanguageLabel.font = [UIFont lightFontWithSize:13];
    userGenderLabel.font = [UIFont lightFontWithSize:13];
    birthdayLabel.font = [UIFont lightFontWithSize:13];
    userSecondNameLabel.font = [UIFont lightFontWithSize:13];
    //for textFields
    userLanguageTextField.font = [UIFont lightFontWithSize:15];
    userGenderTextField.font = [UIFont lightFontWithSize:15];
    birthdayTextField.font = [UIFont lightFontWithSize:15];
    userSecondNameTextField.font = [UIFont lightFontWithSize:15];
    userNameTextField.font = [UIFont lightFontWithSize:15];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)goToNextStep:(id)sender {
    //if ([self checkIsDataValid]) {
        [[TIMRegistrationModel sharedInstance] saveName:userNameTextField.text
                                                surname:userSecondNameTextField.text
                                               birthday:birthdayTextField.text
                                                 gender:userGenderTextField.text
                                               language:userLanguageTextField.text
                                           profilePhoto:avatarImageView.image];
       [self pushStepThree];
    //}
    
}

- (IBAction)makePhotoAction:(id)sender {
    [self callImagePickerControllerForMakePhoto:YES];
}

- (IBAction)loadPhotoAction:(id)sender {
    [self callImagePickerControllerForMakePhoto:NO];
}

- (IBAction)deletePhotoAction:(id)sender {
    avatarImageView.image = [UIImage imageNamed:@"default-avatar.png"];
}

#pragma mark - Navigation

- (void)pushStepThree {
    TIMStepThreeRegViewController *stepThreeController = [[TIMStepThreeRegViewController alloc]
                                                          initWithNibName:@"TIMStepThreeRegViewController"
                                                          bundle:[NSBundle mainBundle]];
    stepThreeController.mapView = self.mapView;
    [self.navigationController pushViewController:stepThreeController animated:YES];
}


#pragma mark - Image Controller

- (void)callImagePickerControllerForMakePhoto:(BOOL)isMakePhoto{
    UIImagePickerController* imageController = [[UIImagePickerController alloc] init];
    imageController.delegate = self;
    if (isMakePhoto) {
        imageController.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imageController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imageController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo{
    
    avatarImageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Checks 

- (BOOL)checkIsDataValid{
    NSString* problem = [self checkName:userNameTextField.text
                                surname:userSecondNameTextField.text
                               birthday:birthdayTextField.text
                                 gender:userGenderTextField.text];
    if (!problem) {
        return YES;
    } else {
        UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:@"Ошибка"
                                                           message:problem
                                                          delegate:nil
                                                 cancelButtonTitle:@"Закрыть"
                                                 otherButtonTitles:nil, nil];
        [alerView show];
        return NO;
    }
}

@end

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
    [self setBorderWidht:4.0 color:[UIColor whiteColor]
            cornerRadius:avatarImageView.frame.size.width/2 toView:avatarImageView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToNextStep:(id)sender {
    [self pushStepThree];
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

- (IBAction)chooseBirthdayAction:(id)sender {
}

- (IBAction)chooseGenderAction:(id)sender {
}

- (IBAction)chooseLenguageAction:(id)sender {
}

- (void)pushStepThree {
    TIMStepThreeRegViewController *stepThreeController = [[TIMStepThreeRegViewController alloc]
                                                          initWithNibName:@"TIMStepThreeRegViewController"
                                                          bundle:[NSBundle mainBundle]];
    stepThreeController.mapView = self.mapView;
    [self.navigationController pushViewController:stepThreeController animated:YES];
}

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

@end

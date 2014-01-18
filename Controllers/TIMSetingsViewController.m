//
//  TIMSetingsViewController.m
//  TrueIMPRESSION
//
//  Created by fist on 1/17/14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMSetingsViewController.h"

@interface TIMSetingsViewController ()

@end

@implementation TIMSetingsViewController

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
    self.navigationItem.title = @"Настройки";
    [self createAppearence];
    photoBtnCover.photoDelegate = self;
    photoBtnsAvatar.photoDelegate = self;
    photoBtnCover.tag = coverInSettings;
    photoBtnsAvatar.tag = avatarInSettings;
    // Do any additional setup after loading the view from its nib.
}

- (void)createAppearence{
    [self setBorderWidht:4 color:[UIColor whiteColor] cornerRadius:0 toView:_imageViewCover];
    [self createNavigationOkBtn];
    [self setFontsToTextViewsInView:self.view];
    [self setValuesToView];
    [self calculateAboutMySelsBlock];
}

- (void)setValuesToView{
    
}

- (void)calculateAboutMySelsBlock{
    CGSize blockSize;
    CGSize maxSize = CGSizeMake(textViewAboutMySelf.frame.size.width, CGFLOAT_MAX);
    
    blockSize = [textViewAboutMySelf sizeThatFits:maxSize];
    
    textViewAboutMySelf.frame = CGRectMake(textViewAboutMySelf.frame.origin.x,
                                           textViewAboutMySelf.frame.origin.y,
                                           textViewAboutMySelf.frame.size.width,
                                           blockSize.height);
    [self viewsOffset];
}

- (void)viewsOffset{

    textViewAboveMySelfInfo.frame = CGRectMake(textViewAboveMySelfInfo.frame.origin.x,
                                               CGRectGetMaxY(textViewAboutMySelf.frame),
                                               textViewAboveMySelfInfo.frame.size.width,
                                               textViewAboveMySelfInfo.frame.size.height);
    
    imageViewFon.frame = CGRectMake(imageViewFon.frame.origin.x,
                                    imageViewFon.frame.origin.y,
                                    imageViewFon.frame.size.width,
                                    CGRectGetMaxY(textViewAboveMySelfInfo.frame) - 78);
    
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width,
                                           CGRectGetMaxY(textViewAboveMySelfInfo.frame))];
}

- (void)setFontsToTextViewsInView:(UIView*)editingView{
    for (UIView* view in [editingView subviews]) {
        if ([[view subviews] count] > 0) {
            [self setFontsToTextViewsInView:view];
        }
        if ([view isKindOfClass:([UILabel class])]) {
            UILabel* currentLabel = (UILabel*)view;
            if (currentLabel.font.pointSize == 13) {
                currentLabel.font = [UIFont lightFontWithSize:currentLabel.font.pointSize];
            }
        }
        if ([view isKindOfClass:([UITextField class])]) {
            UITextField* currentTextField = (UITextField*)view;
            currentTextField.font = [UIFont lightFontWithSize:currentTextField.font.pointSize];
        }
        if ([view isKindOfClass:([UITextView class])]) {
            UITextView* currentTextView = (UITextView*)view;
            currentTextView.font = [UIFont lightFontWithSize:currentTextView.font.pointSize];
        }
    }
}

- (void)createNavigationOkBtn{
    UIButton* okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(0, 0, 29, 29);
    [okBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [okBtn setImage:[UIImage imageNamed:@"btn_ok.png"] forState:UIControlStateNormal];
    UIBarButtonItem* okBarButton = [[UIBarButtonItem alloc] initWithCustomView:okBtn];
    [self.navigationItem setRightBarButtonItem:okBarButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(id)sender {
    NSLog(@"Ok");
}

- (IBAction)swicherBtnAction:(id)sender {
    UIImage* image;
    if (!anonymousUser) {
        image = [UIImage imageNamed:@"off.png"];
    } else {
        image = [UIImage imageNamed:@"on.png"];
    }
    anonymousUser = !anonymousUser;
    [swicherBtn setImage:image forState:UIControlStateNormal];
}

#pragma mark - ImagePickerCall

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
    switch (currentImageView) {
        case avatarInSettings:
            _imageViewAvatar.image = image;
            break;
        case coverInSettings:
            _imageViewCover.image = image;
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TIMPhotoButtonsDelegate

- (void)makePhoto:(TIMPhotoButtons*)photoButtons{
    currentImageView = photoButtons.tag;
    [self callImagePickerControllerForMakePhoto:YES];
}

- (void)loadPhoto:(TIMPhotoButtons*)photoButtons{
    currentImageView = photoButtons.tag;
    [self callImagePickerControllerForMakePhoto:NO];
}

- (void)deletePhoto:(TIMPhotoButtons*)photoButtons{
    switch (photoButtons.tag) {
        case avatarInSettings:
            _imageViewAvatar.image = [UIImage imageNamed:@"default-avatar.png"];
            break;
        case coverInSettings:
            _imageViewCover.image = [UIImage imageNamed:@"default-wallpaper.png"];
            break;
        default:
            break;
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    [self calculateAboutMySelsBlock];
}

@end

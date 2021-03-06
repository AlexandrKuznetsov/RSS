//
//  TIMSetingsViewController.m
//  TrueIMPRESSION
//
//  Created by fist on 1/17/14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMSetingsViewController.h"
#import "TIMLeftSideViewController.h"

@interface TIMSetingsViewController () {
    NSArray *_interests;
    NSArray* _professions;
}

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
    self.navigationItem.title = @"Настройки профиля";
    [self createAppearence];
    photoBtnCover.photoDelegate = self;
    photoBtnsAvatar.photoDelegate = self;
    photoBtnCover.tag = coverInSettings;
    photoBtnsAvatar.tag = avatarInSettings;
    // Do any additional setup after loading the view from its nib.
}

//- (void)loadData{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    __weak TIMSetingsViewController* weakSelf = self;
//    [[TIMLocalUserInfo sharedInstance] loadSettingsWithCompletition:^(NSError *error, id response) {
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        if (!error) {
//            [weakSelf setValuesToView];
//        } else {
//            [weakSelf showError:[error localizedDescription]];
//        }
//    }];
//}

- (void)createAppearence{
    self.interestsLabel.font = [UIFont lightFontWithSize:13.0f];
    self.professionsLabel.font = [UIFont lightFontWithSize:13.0f];
    [self setBorderWidht:4 color:[UIColor whiteColor] cornerRadius:0 toView:_imageViewCover];
    [self createNavigationOkBtn];
    [self setFontsToTextViewsInView:self.view];
    [self setValuesToView];
//    [self loadData];
}

- (void)setValuesToView{
    self.professionsLabel.text = [[TIMLocalUserInfo sharedInstance] professionText];
    
    textFieldMyImpressions.text = [[TIMLocalUserInfo sharedInstance]privacyString: [[TIMLocalUserInfo sharedInstance] privacyImpressions]];
    textFieldMyInterests.text = [[TIMLocalUserInfo sharedInstance]privacyString:[[TIMLocalUserInfo sharedInstance] privacyInterest]];
    textFiewlMyLocation.text = [[TIMLocalUserInfo sharedInstance]privacyString:[[TIMLocalUserInfo sharedInstance] privacyPlace]];
    textFiewldMyProfession.text = [[TIMLocalUserInfo sharedInstance]privacyString:[[TIMLocalUserInfo sharedInstance] privacyProfession]];
    
    NSString* country = [[TIMLocalUserInfo sharedInstance] country];
    textFieldCountry.text = country;
    TIMModelWithStaticData* staticData = [[TIMModelWithStaticData alloc] init];
    self.currentCountry = [staticData getCounryDictWithCountryName:country];
    if ([[TIMLocalUserInfo sharedInstance] privacyOn] == 1) {
        anonymousUser = YES;
    } else {
        anonymousUser = NO;
    }
    [self swicherBtnAction:nil];
    if (!_staticModel) {
        _staticModel = [[TIMModelWithStaticData alloc] init];
    }
//    NSDictionary* interestsDict = [_staticModel formatInterestsDictionaryFromString:[[TIMLocalUserInfo sharedInstance] interests]];
    _interestsLabel.text = [_staticModel formatInterestsString:[[TIMLocalUserInfo sharedInstance] interests].count];
    _interests = [[TIMLocalUserInfo sharedInstance] interests];
    _professionsLabel.text = [[TIMLocalUserInfo sharedInstance] professionText];
    textFieldCity.text = [[TIMLocalUserInfo sharedInstance] city];
    textFieldBirthday.text = [[TIMLocalUserInfo sharedInstance] birthday];
    textFieldSeconName.text = [[TIMLocalUserInfo sharedInstance] surname];
    textFieldName.text = [[TIMLocalUserInfo sharedInstance] name];
    if ([[[TIMLocalUserInfo sharedInstance] aboutMe] length] > 0) {
        textViewAboutMySelf.text = [[TIMLocalUserInfo sharedInstance] aboutMe];
    }
    if (![[TIMLocalUserInfo sharedInstance] userPhoto]) {
        [self changeImageAtImageView:_imageViewAvatar withGender:[[TIMLocalUserInfo sharedInstance] gender]];
    } else {
        _imageViewAvatar.image = [[TIMLocalUserInfo sharedInstance] userPhoto];
    }
    if ([[TIMLocalUserInfo sharedInstance] userWalpaper]) {
        _imageViewCover.image = [[TIMLocalUserInfo sharedInstance] userWalpaper];
    }
    [self calculateAboutMySelsBlock];
}

- (void)writeDataToProfile {
    [[TIMLocalUserInfo sharedInstance] setPrivacyImpressions:
     [self integerFromString:textFieldMyImpressions.text]];
    [[TIMLocalUserInfo sharedInstance] setPrivacyInterest:
     [self integerFromString:textFieldMyInterests.text]];
    [[TIMLocalUserInfo sharedInstance] setPrivacyPlace:
     [self integerFromString:textFiewlMyLocation.text]];
    [[TIMLocalUserInfo sharedInstance] setPrivacyProfession:
     [self integerFromString:textFiewldMyProfession.text]];
    if (_professions) {
        [[TIMLocalUserInfo sharedInstance] setProfession:_professions];
    }
    if (_interests) {
        [[TIMLocalUserInfo sharedInstance] setInterests:_interests];
    }
    [[TIMLocalUserInfo sharedInstance] setCountry:self.currentCountry[@"title"]];
    [[TIMLocalUserInfo sharedInstance] setCity:textFieldCity.text];
    [[TIMLocalUserInfo sharedInstance] setBirthday:textFieldBirthday.text];
    [[TIMLocalUserInfo sharedInstance] setSurname:textFieldSeconName.text];
    [[TIMLocalUserInfo sharedInstance] setName:textFieldName.text];
    
    NSInteger anonymous;
    if (anonymousUser) {
        anonymous = 1;
    } else {
        anonymous = 0;
    }
    [[TIMLocalUserInfo sharedInstance] setPrivacyOn:anonymous];
    if ([textViewAboutMySelf.text isEqualToString:@"Пару строк о себе..."]) {
        [[TIMLocalUserInfo sharedInstance] setAboutMe:@""];
    } else {
        [[TIMLocalUserInfo sharedInstance] setAboutMe:textViewAboutMySelf.text];
    }
    [[TIMLocalUserInfo sharedInstance] saveUserInfoInUserDefaults];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak TIMSetingsViewController* weakSelf = self;
    [[TIMLocalUserInfo sharedInstance] saveSettingsWithCompletition:^(NSError *error, id response) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (!error) {
            [TIMLocalUserInfo sharedInstance].needUpdate = YES;
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            [weakSelf setValuesToView];
            
            id controller = self.menuContainerViewController.leftMenuViewController;
            [controller initNamesArray];
        } else {
            [weakSelf showError:[error localizedDescription]];
        }
    }];
}

- (void)showError:(NSString*)error{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка!" message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
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
    NSLog(@"%f", CGRectGetMaxY(textViewAboveMySelfInfo.frame) - 78);
    imageViewBottomFon.frame = CGRectMake(imageViewBottomFon.frame.origin.x,
                                    imageViewBottomFon.frame.origin.y,
                                    imageViewBottomFon.frame.size.width,
                                    CGRectGetMaxY(textViewAboveMySelfInfo.frame) - 78);
    
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width,
                                           CGRectGetMaxY(textViewAboveMySelfInfo.frame))];
}

- (void)setFontsToTextViewsInView:(UIView*)editingView {
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
    [okBtn setImage:[UIImage imageNamed:@"btn_ok_white.png"] forState:UIControlStateNormal];
    [okBtn setImage:[UIImage imageNamed:@"btn_ok_white_on.png"] forState:UIControlStateHighlighted];
    UIBarButtonItem* okBarButton = [[UIBarButtonItem alloc] initWithCustomView:okBtn];
    [self.navigationItem setRightBarButtonItem:okBarButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(id)sender {
    [self writeDataToProfile];
}

- (IBAction)swicherBtnAction:(id)sender {
    if (sender) {
        anonymousUser = !anonymousUser;
    }
    UIImage* image;
    if (!anonymousUser) {
        image = [UIImage imageNamed:@"off.png"];
    } else {
        image = [UIImage imageNamed:@"on.png"];
    }
    [swicherBtn setImage:image forState:UIControlStateNormal];
}

- (IBAction)loadInterests:(id)sender {
    [self pushTableViewForLoadProfessions:NO];
}

- (IBAction)loadProfession:(id)sender {
    [self pushTableViewForLoadProfessions:YES];
}

#pragma mark - Professions Delegate

- (void)tableViewForProfessions:(BOOL)isForProfessions pickedData:(NSArray *)data {
    if (isForProfessions) {
        self.professionsLabel.text = [data lastObject];
        _professions = [NSArray arrayWithArray:data];
    } else {
        NSString* interestString;
        if (!_staticModel) {
            _staticModel = [[TIMModelWithStaticData alloc] init];
        }
        _interests = [NSArray arrayWithArray:data];
        if (data.count == 1 && [[data lastObject] isEqualToString:@""]) {
            self.interestsLabel.text = [data lastObject];
            interestString = [data lastObject];
        } else {
            self.interestsLabel.text = [_staticModel formatInterestsString:data.count];
            interestString = [[TIMRegistrationModel sharedInstance] stringFromInterestsArray:_interests];
        }
        [[TIMLocalUserInfo sharedInstance] setInterests:_interests];
    }
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
            [[TIMLocalUserInfo sharedInstance] setUserPhoto:_imageViewAvatar.image];
            break;
        case coverInSettings:
            _imageViewCover.image = image;
            [[TIMLocalUserInfo sharedInstance] setUserWalpaper:_imageViewCover.image];
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
            [[TIMLocalUserInfo sharedInstance] setUserPhoto:nil];
            [self changeImageAtImageView:_imageViewAvatar withGender:[[TIMLocalUserInfo sharedInstance] gender]];
            break;
        case coverInSettings:
            _imageViewCover.image = nil;
            [[TIMLocalUserInfo sharedInstance] setUserWalpaper:nil];
            break;
        default:
            break;
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    [self calculateAboutMySelsBlock];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"Пару строк о себе..."]) {
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Пару строк о себе...";
    }
}

#pragma mark - Navigation 

- (void)pushTableViewForLoadProfessions:(BOOL)prof {
    TIMTableViewController *tableController = [[TIMTableViewController alloc]
                                               initWithNibName:@"TIMTableViewController"
                                               bundle:[NSBundle mainBundle]];
    tableController.isProfessions = prof;
    tableController.dataDelegate = self;
    [self.navigationController pushViewController:tableController animated:YES];
}

- (NSInteger)integerFromString:(NSString*)string{
    if ([string isEqualToString:@"Все"]) {
        return 0;
    }
    if ([string isEqualToString:@"Только я"]) {
        return 1;
    }
    if ([string isEqualToString:@"Только друзья"]) {
        return 2;
    }
    return 0;
}

@end

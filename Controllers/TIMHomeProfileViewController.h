//
//  TIMHomeProfileViewController.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMViewController.h"
#import "TIMRegistrationNavController.h"
#import "TIMLoginViewController.h"
#import "TIMHomeNavButtonsView.h"
#import "TIMProfileImpressionCell.h"
#import "TIMProfileInfoCell.h"
#import "TIMSetingsViewController.h"
#import "TIMLocalUserInfo.h"
#import "TIMLocalUserInfo.h"


@interface TIMHomeProfileViewController : TIMViewController <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) TIMHomeNavButtonsView *buttonsView;
@property (strong, nonatomic) TIMLocalUserInfo *localUserInfo;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *surnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *impressionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *placesLabel;
@property (weak, nonatomic) IBOutlet UILabel *imprTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeesTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *settingsOutlet;
@property (weak, nonatomic) IBOutlet TIMRoundedImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;
@property (weak, nonatomic) IBOutlet UIImageView *wallpaperImageView;

- (IBAction)settingBtnAction:(id)sender;


@end

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

@interface TIMHomeProfileViewController : TIMViewController <
UITableViewDataSource,
UITableViewDelegate
>

@property (strong, nonatomic) TIMHomeNavButtonsView *buttonsView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *impressionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *placesLabel;
@property (weak, nonatomic) IBOutlet UILabel *imprTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeesTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *settingsOutlet;

- (IBAction)settingBtnAction:(id)sender;


@end

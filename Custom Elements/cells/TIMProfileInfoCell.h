//
//  TIMProfileInfoCell.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 13.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+TIFonts.h"

@interface TIMProfileInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *professionLabel;
@property (weak, nonatomic) IBOutlet UILabel *interestLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutLabeel;

@property (weak, nonatomic) IBOutlet UILabel *professionTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *interestsTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutTextLabel;

- (void)cellDesign;

@end

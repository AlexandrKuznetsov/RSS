//
//  TIMProfileInfoCell.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 13.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMProfileInfoCell.h"

@implementation TIMProfileInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)cellDesign {
    self.professionTextLabel.font = [UIFont boldFontWithSize:12.0f];
    self.interestsTextLabel.font = [UIFont boldFontWithSize:12.0f];
    self.aboutTextLabel.font = [UIFont boldFontWithSize:12.0f];
    self.professionLabel.font = [UIFont regularFontWithSize:12.0f];
    self.interestLabel.font = [UIFont regularFontWithSize:12.0f];
    self.aboutLabeel.font = [UIFont regularFontWithSize:12.0f];
}

@end

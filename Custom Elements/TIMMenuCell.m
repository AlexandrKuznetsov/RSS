//
//  TIMMenuCell.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 26.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMMenuCell.h"

@implementation TIMMenuCell

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
    UIView *bgColorView = [[UIView alloc] init];
    if (self.canSelect) {
        bgColorView.backgroundColor = [UIColor colorWithRed:49/255.0f green:49/255.0f blue:49/255.0f alpha:1];
    } else {
        bgColorView.backgroundColor = [UIColor clearColor];
    }
    [self setSelectedBackgroundView:bgColorView];
}

- (void)setCellText:(NSString *)cellText {
    _cellText = cellText;
    self.nameLabel.text = _cellText;
    [self customDesign];
}

- (void)customDesign {
    self.nameLabel.font = [UIFont semiBoldFontWithSize:18.0f];
}

- (void)setIsProfile:(BOOL)isProfile {
    _isProfile = isProfile;
    if (_isProfile) {
        self.nameLabel.font = [UIFont boldFontWithSize:20.0f];
        self.iconImageView.image = [UIImage imageNamed:@"icon_profile_swipemenu"];
        self.iconImageView.hidden = NO;
    }
}

- (void)setIsExit:(BOOL)isExit {
    _isExit = isExit;
    if (_isExit) {
        self.iconImageView.hidden = NO;
        self.iconImageView.image = [UIImage imageNamed:@"icon_logout"];
    }
}

@end

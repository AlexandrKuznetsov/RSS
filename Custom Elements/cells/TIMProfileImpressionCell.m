//
//  TIMProfileImpressionCell.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 13.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMProfileImpressionCell.h"

@implementation TIMProfileImpressionCell

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

- (void)customFonts {
    self.imprNameLabel.font = [UIFont boldFontWithSize:14.0f];
    self.locationLabel.font = [UIFont semiBoldFontWithSize:10.0f];
    self.dateLabel.font = [UIFont regularFontWithSize:10.0f];
}

@end

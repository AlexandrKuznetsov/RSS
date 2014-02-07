//
//  TIMNoImressionsCell.m
//  TrueIMPRESSION
//
//  Created by fist on 2/7/14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMNoImressionsCell.h"
#import "UIFont+TIFonts.h"

@implementation TIMNoImressionsCell

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

- (void)customFonts{
    self.textLabel.font = [UIFont regularFontWithSize:10.0f];
}

@end

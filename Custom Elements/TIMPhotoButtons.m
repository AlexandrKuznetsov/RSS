//
//  TIMPhotoButtons.m
//  TrueIMPRESSION
//
//  Created by fist on 1/17/14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMPhotoButtons.h"

@implementation TIMPhotoButtons

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"TIMPhotoButtons" owner:self options:nil];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.view];
        [self createCustomFonts];
    }
    return self;
}

- (void)createCustomFonts{
    makePhotoLabel.font = [UIFont lightFontWithSize:11];
    loadPhotoLabel.font = [UIFont lightFontWithSize:11];
    deletePhotoLabel.font = [UIFont lightFontWithSize:11];
    
    [makeButton setImage:[UIImage imageNamed:@"make_on.png"] forState:UIControlStateHighlighted];
    [loadButton setImage:[UIImage imageNamed:@"load_on.png"] forState:UIControlStateHighlighted];
    [deleteButton setImage:[UIImage imageNamed:@"remove_on.png"] forState:UIControlStateHighlighted];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)makePhotoAction:(id)sender {
    [_photoDelegate makePhoto:self];
}

- (IBAction)loadPhotoAction:(id)sender {
    [_photoDelegate loadPhoto:self];
}

- (IBAction)deletePhotoAction:(id)sender {
    [_photoDelegate deletePhoto:self];
}

@end

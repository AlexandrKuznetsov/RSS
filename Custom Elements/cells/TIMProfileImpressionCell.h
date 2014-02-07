//
//  TIMProfileImpressionCell.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 13.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+TIFonts.h"

@interface TIMProfileImpressionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewPlace;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *imprNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;

- (void)customFonts;
- (void)makeNoImpressionCell;

@end

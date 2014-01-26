//
//  TIMMenuCell.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 26.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+TIFonts.h"

@interface TIMMenuCell : UITableViewCell {

}
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) NSString *cellText;
@property (assign, nonatomic) BOOL isProfile;
@property (assign, nonatomic) BOOL isExit;
@property (assign, nonatomic) BOOL canSelect;
@end

//
//  TIMPhotoButtons.h
//  TrueIMPRESSION
//
//  Created by fist on 1/17/14.
//  Copyright (c) 2014 Impression. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIFont+TIFonts.h"


@class TIMPhotoButtons;

@protocol TIMPhotoButtonsDelegate <NSObject>

- (void)makePhoto:(TIMPhotoButtons*)photoButtons;
- (void)loadPhoto:(TIMPhotoButtons*)photoButtons;
- (void)deletePhoto:(TIMPhotoButtons*)photoButtons;

@end

@interface TIMPhotoButtons : UIView{
    
    
    __weak IBOutlet UIButton *deleteButton;
    __weak IBOutlet UIButton *loadButton;
    __weak IBOutlet UIButton *makeButton;
    __weak IBOutlet UILabel *deletePhotoLabel;
    __weak IBOutlet UILabel *loadPhotoLabel;
    __weak IBOutlet UILabel *makePhotoLabel;
}

@property (strong, nonatomic) IBOutlet UIView* view;
@property (weak, nonatomic) id<TIMPhotoButtonsDelegate> photoDelegate;

- (IBAction)makePhotoAction:(id)sender;
- (IBAction)loadPhotoAction:(id)sender;
- (IBAction)deletePhotoAction:(id)sender;



@end

//
//  TIMHomeNavButtonsView.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 13.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TIMHomeNavButtonsView : UIView {
}

@property (weak, nonatomic) IBOutlet UIButton *feedBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *searchBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *friendsBtnOutlet;
+ (TIMHomeNavButtonsView *)loadView;

@end

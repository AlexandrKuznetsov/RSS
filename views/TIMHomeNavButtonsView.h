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
+ (TIMHomeNavButtonsView *)loadView;

@end

//
//  TIMViewController.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIFont+TIFonts.h"

@interface TIMViewController : UIViewController

- (void)setBorderWidht:(CGFloat)widht
                 color:(UIColor*)color
          cornerRadius:(CGFloat)cornerRadius
                toView:(UIView*)view;

- (void)showAlertViewWithMessage:(NSString*)massege;

@end

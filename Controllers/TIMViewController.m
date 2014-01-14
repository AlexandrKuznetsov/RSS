//
//  TIMViewController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMViewController.h"

@interface TIMViewController ()

@end

@implementation TIMViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self customBackButtonItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customBackButtonItem{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 22)];
    UIImage *buttonImage = [UIImage imageNamed:@"header-back-button.png"];
    UIImage *buttonHiglitedImage = [UIImage imageNamed:@"header-back-button-down.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:buttonHiglitedImage forState:UIControlStateHighlighted];
    int xPosition;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        xPosition = 0;
    } else {
        xPosition = customView.frame.size.width-22;
    }
    button.frame = CGRectMake(xPosition, 0, 22, 22);
    [customView addSubview:button];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* customBackBtn = [[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.leftBarButtonItem = customBackBtn;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    self.navigationItem.hidesBackButton = YES;
}

- (void)setBorderWidht:(CGFloat)widht
                 color:(UIColor*)color
          cornerRadius:(CGFloat)cornerRadius
                toView:(UIView*)view{
    
    view.layer.shouldRasterize = YES;
    view.backgroundColor = [UIColor clearColor];
    [view.layer setCornerRadius:cornerRadius];
    [view.layer setBorderColor:[color CGColor]];
    [view.layer setBorderWidth:widht];
    view.layer.masksToBounds = YES;
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGSize)sizeString:(NSString *)string forLabel:(UILabel *)label {
    CGSize maximumLabelSize = CGSizeMake(CGRectGetWidth(label.frame),9999);
    
    return [string sizeWithFont:label.font
                                      constrainedToSize:maximumLabelSize
                                          lineBreakMode:label.lineBreakMode];
}


@end

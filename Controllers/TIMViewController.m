//
//  TIMViewController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMViewController.h"
#import <MFSideMenu/MFSideMenu.h>

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
	[self setupBarButtonsItems];
    if([UIViewController instancesRespondToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout=UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupBarButtonsItems {
    if([[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
        self.navigationItem.leftBarButtonItem = [self customButtonWithImageName:@"btn_menu"
                                                                       selector:@selector(showMenu)];
    } else {
        [self customBackButtonItem];
    }
}

- (void)customBackButtonItem{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 29)];
    UIImage *buttonImage = [UIImage imageNamed:@"btn_back_biggreen"];
    UIImage *buttonHiglitedImage = [UIImage imageNamed:@"btn_back_biggreen_on"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:buttonHiglitedImage forState:UIControlStateHighlighted];
    int xPosition;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        xPosition = 0;
    } else {
        xPosition = customView.frame.size.width-22;
    }
    button.frame = CGRectMake(xPosition, 0, 29, 29);
    [customView addSubview:button];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* customBackBtn = [[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.leftBarButtonItem = customBackBtn;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    self.navigationItem.hidesBackButton = YES;
}


- (UIBarButtonItem *)customButtonWithImageName:(NSString *)imageName selector:(SEL)aSel {
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 36)];
    UIButton *customButton = [[UIButton alloc] initWithFrame:customView.bounds];
    [customButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:@"btn_menu_on.png"]
                  forState:UIControlStateHighlighted];
    [customButton addTarget:self action:aSel forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:customButton];
    return [[UIBarButtonItem alloc] initWithCustomView:customView];
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

- (void)showMenu {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        [self setupBarButtonsItems];
    }];
}

- (CGSize)sizeString:(NSString *)string forLabel:(UILabel *)label {
    CGSize maximumLabelSize = CGSizeMake(CGRectGetWidth(label.frame),9999);
    
    return [string sizeWithFont:label.font
                                      constrainedToSize:maximumLabelSize
                                          lineBreakMode:label.lineBreakMode];
}

- (void)showAlertViewWithMessage:(NSString*)massege{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:massege delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
}

@end

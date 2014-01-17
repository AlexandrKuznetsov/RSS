//
//  TIMNavigationViewController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMNavigationViewController.h"

@interface TIMNavigationViewController ()

@end

@implementation TIMNavigationViewController

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
    UIImage *navBarBackgroundImage;
    if ([self is_ios7]) {
        navBarBackgroundImage = [UIImage imageNamed:@"top_panel.png"];
    } else {
        navBarBackgroundImage = [UIImage imageNamed:@"top_panel.png"];
    }
    [self.navigationBar setBackgroundImage:navBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (BOOL)is_ios7 {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7.0) {
        return YES;
    } else return NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

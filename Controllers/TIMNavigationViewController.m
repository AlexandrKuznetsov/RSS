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
    UIImage *navBarBackgroundImage = [[UIImage imageNamed:@"header-title.png"]
                                      resizableImageWithCapInsets:UIEdgeInsetsMake(20, 0, 20, 0)];
    [self.navigationBar setBackgroundImage:navBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [self backButtonCustomizaton];
}

- (void)backButtonCustomizaton {

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

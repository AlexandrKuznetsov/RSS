//
//  TIMStepOneRegViewController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMStepOneRegViewController.h"

@interface TIMStepOneRegViewController ()

@end

@implementation TIMStepOneRegViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToNextStep:(id)sender {
    [self pushStepTwo];
}

- (void)pushStepTwo {
    TIMStepTwoRegViewController *stepTwoController = [[TIMStepTwoRegViewController alloc]
                                                      initWithNibName:@"TIMStepTwoRegViewController"
                                                      bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:stepTwoController animated:YES];
}

@end

//
//  TIMStepTwoRegViewController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMStepTwoRegViewController.h"

@interface TIMStepTwoRegViewController ()

@end

@implementation TIMStepTwoRegViewController

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
    if (!self.mapView) {
        [self.locationManager startUpdatingLocation];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToNextStep:(id)sender {
    [self pushStepThree];
}

- (void)pushStepThree {
    TIMStepThreeRegViewController *stepThreeController = [[TIMStepThreeRegViewController alloc]
                                                          initWithNibName:@"TIMStepThreeRegViewController"
                                                          bundle:[NSBundle mainBundle]];
    stepThreeController.mapView = self.mapView;
    [self.navigationController pushViewController:stepThreeController animated:YES];
}

@end

//
//  TIMResetPassController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 29.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMResetPassController.h"

@interface TIMResetPassController ()

@end

@implementation TIMResetPassController

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
    self.navigationItem.title = @"Изменить пароль";
}

- (void)viewWillAppear:(BOOL)animate {
    [super viewWillAppear:YES];
    [super getCrrentUserLocation];
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

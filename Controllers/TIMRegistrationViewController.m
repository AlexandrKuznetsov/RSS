//
//  TIMRegistrationViewController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMRegistrationViewController.h"

@interface TIMRegistrationViewController ()

@end

@implementation TIMRegistrationViewController

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
    self.navigationItem.title = @"Регистрация";
    [self customBackButtonItem];
    if (_mapView) {
        [self addingMapAndmoveToBack];
    } else {
        [self getCrrentUserLocation];
    }
}

- (void)makeRaundedRectToView:(UIView*)view withCornerRadius:(CGFloat)radius{
    view.layer.cornerRadius = radius;
}

- (void)getCrrentUserLocation{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
}

- (void)createBackgroundMap:(CLLocation*)location{
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [_mapView setCenterCoordinate:location.coordinate];
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
    [_mapView setRegion:region animated:NO];
    [self addingMapAndmoveToBack];
}

- (void)addingMapAndmoveToBack{
    [self.view addSubview:_mapView];
    [self.view sendSubviewToBack:_mapView];
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
    self.navigationItem.hidesBackButton = YES;
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation{
    [manager stopUpdatingLocation];
    [self createBackgroundMap:newLocation];
}

@end

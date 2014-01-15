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
    if(_mapView){
        [self addingMapAndmoveToBack];
    } else {
        [self getCrrentUserLocation];
    }
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

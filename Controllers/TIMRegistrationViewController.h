//
//  TIMRegistrationViewController.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMViewController.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "UIFont+TIFonts.h"
#import "TIMRegistrationModel.h"
#import "NSObject+CheckData.h"

@interface TIMRegistrationViewController : TIMViewController <CLLocationManagerDelegate>{
    
}

@property (strong, nonatomic) MKMapView* mapView;
@property (strong, nonatomic) CLLocationManager* locationManager;

@end

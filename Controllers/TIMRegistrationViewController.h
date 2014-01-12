//
//  TIMRegistrationViewController.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TIMRegistrationViewController : UIViewController <CLLocationManagerDelegate>{
    
}

@property (strong, nonatomic) MKMapView* mapView;
@property (strong, nonatomic) CLLocationManager* locationManager;

- (void)makeRaundedRectToView:(UIView*)view withCornerRadius:(CGFloat)radius;

@end

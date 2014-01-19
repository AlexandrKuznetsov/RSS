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
#import "TIMModelWithStaticData.h"
#import "NSObject+CheckData.h"

#define PICKER_RECT CGRectMake(0, 200, 320, 216)

typedef enum {
    name = 100,
    secondName = 101,
    birthday = 102,
    gender = 103,
    language = 104,
    city = 105,
    country = 106,
    privacyMyPlace = 107,
    privacyMyInterests = 108,
    privacyMyImpressions = 109,
    privacyMyProfession = 110
}textFieldEnum;

typedef enum {
    avatarInRegistration = 10,
    avatarInSettings = 11,
    coverInSettings = 12
}photoBtnsEnam;

@interface TIMRegistrationViewController : TIMViewController <CLLocationManagerDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>{
    TIMModelWithStaticData *_staticModel;
}

@property (strong, nonatomic) NSArray* pickerDataSource;
@property (weak, nonatomic) UITextField* activeTextField;
@property (strong, nonatomic) MKMapView* mapView;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) NSDictionary *currentCountry;

- (void)getCrrentUserLocation;
- (void)saveLocationCountry:(NSString *)locationCountry;

@end

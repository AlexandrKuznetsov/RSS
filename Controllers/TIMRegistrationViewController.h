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
#import <MBProgressHUD/MBProgressHUD.h>
#import "TIMTableViewController.h"
#import "TIMLocalUserInfo.h"

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
    privacyMyProfession = 110,
    interests = 111,
    profession = 112,
    notifications = 113,
    search = 114,
    synchronization = 115
}textFieldEnum;

typedef NS_ENUM(NSInteger, photoBtnsEnam) {
    avatarInRegistration = 10,
    avatarInSettings = 11,
    coverInSettings = 12
};

@interface TIMRegistrationViewController : TIMViewController <CLLocationManagerDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>{
    TIMModelWithStaticData *_staticModel;
}

@property (strong, nonatomic) NSArray* pickerDataSource;
@property (weak, nonatomic) UITextField* activeTextField;
@property (strong, nonatomic) MKMapView* mapView;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) NSMutableDictionary *currentCountry;

@property (strong, nonatomic) NSString *placeholderText;

- (void)getCrrentUserLocation;
- (void)saveLocationCountry:(NSString *)locationCountry;
- (void)changeImageAtImageView:(UIImageView*)imageView withGender:(NSString*)gender;

@end

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
        self.backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
        self.backgroundView.backgroundColor = [UIColor colorWithRed:239/255.0f green:237/255.0f blue:233/255.0f alpha:1];
        [self.view addSubview:self.backgroundView];
        [self.view sendSubviewToBack:self.backgroundView];
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
    [self.backgroundView removeFromSuperview];
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

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.activeTextField = textField;
    switch (textField.tag) {
        case birthday:
            [self createDatePickerToTextField:textField];
            break;
        case gender:
        {
            NSArray* genderArray = [NSArray arrayWithObjects:@"Мужской", @"Женский", nil];
            [self createTextPikerToTextField:textField
                              withDataSource:genderArray];
        }
            break;
        case language:
        {
            NSArray* languageArray = [NSArray arrayWithObjects:@"English", @"Русский", nil];
            [self createTextPikerToTextField:textField
                              withDataSource:languageArray];
        }
            break;
        case country:
        {
            NSArray* languageArray = [NSArray arrayWithObjects:@"Country1", @"Country2", nil];
            [self createTextPikerToTextField:textField
                              withDataSource:languageArray];
        }
            break;
        case privacyMyPlace:
        {
            NSArray* sharedArray = [NSArray arrayWithObjects:@"все",
                                    @"только я",
                                    @"только друзья",nil];
            [self createTextPikerToTextField:textField
                              withDataSource:sharedArray];
        }
            break;
        case privacyMyInterests:
        {
            NSArray* sharedArray = [NSArray arrayWithObjects:@"все", @"только я", @"только друзья",nil];
            [self createTextPikerToTextField:textField
                              withDataSource:sharedArray];
        }
            break;
        case privacyMyImpressions:
        {
            NSArray* sharedArray = [NSArray arrayWithObjects:@"все", @"только я", @"только друзья",nil];
            [self createTextPikerToTextField:textField
                              withDataSource:sharedArray];
        }
            break;
        case privacyMyProfession:
        {
            NSArray* sharedArray = [NSArray arrayWithObjects:@"все", @"только я", @"только друзья",nil];
            [self createTextPikerToTextField:textField
                              withDataSource:sharedArray];
        }
            break;
        default:
            break;
    }
}

#pragma mark - DatePicker

- (void)createDatePickerToTextField:(UITextField*)textField{
    UIDatePicker* datePiker = [[UIDatePicker alloc] initWithFrame:PICKER_RECT];
    datePiker.datePickerMode = UIDatePickerModeDate;
    [datePiker addTarget:self action:@selector(changebirthdayValue:) forControlEvents:UIControlEventValueChanged];
    textField.inputView = datePiker;
}

- (void)changebirthdayValue:(UIDatePicker*)picker{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.YYYY"];
    NSString* dateString = [dateFormatter stringFromDate:picker.date];
    _activeTextField.text = dateString;
}

#pragma mark - TextPicker

- (void)createTextPikerToTextField:(UITextField*)textField
                    withDataSource:(NSArray*)dataSource{
    _pickerDataSource = dataSource;
    UIPickerView* pikerView = [[UIPickerView alloc] initWithFrame:PICKER_RECT];
    pikerView.showsSelectionIndicator = YES;
    pikerView.delegate = self;
    pikerView.dataSource = self;
    textField.inputView = pikerView;
}

#pragma mark - UIPikerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _pickerDataSource[row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    return _pickerDataSource.count;
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component{
        _activeTextField.text = _pickerDataSource[row];
}

@end

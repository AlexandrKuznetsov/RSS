//
//  TIMStepThreeRegViewController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMStepThreeRegViewController.h"

@interface TIMStepThreeRegViewController () {
    NSArray *_interests;
}

@end

@implementation TIMStepThreeRegViewController

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
    [super getCrrentUserLocation];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    [self design];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI

- (void)design {
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), SCROLL_HEIGHT);
    [self customizeFonts];
}

- (void)setCountryLabel:(NSString *)county city:(NSString *)city {
    [super saveLocationCountry:county];
    self.countryNameField.text = county;
    self.cityNameField.text = city;
}

- (void)customizeFonts {
    self.cityLabel.font = [UIFont lightFontWithSize:13];
    self.countryLabel.font = [UIFont lightFontWithSize:13];
    self.interstsLabel.font = [UIFont lightFontWithSize:13];
    self.profLabel.font = [UIFont lightFontWithSize:13];
    
    self.interestsCountLabel.font = [UIFont lightFontWithSize:13];
    self.professionLabel.font = [UIFont lightFontWithSize:13];
    
    self.cityNameField.font = [UIFont lightFontWithSize:15];
    self.countryNameField.font = [UIFont lightFontWithSize:15];

    self.aboutTextView.font = [UIFont lightFontWithSize:15];
}

- (void)resizeViewsByDelta:(CGFloat)deltaHeight {
    
    CGRect fieldView = self.aboutFieldPlaceholder.frame;
    fieldView.size.height = self.aboutFieldPlaceholder.frame.size.height + deltaHeight;
    self.aboutFieldPlaceholder.frame = fieldView;

    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.contentSize.height + deltaHeight);

    CGRect buttonFrame = self.regButtonOutlet.frame;
    buttonFrame.origin.y = self.regButtonOutlet.frame.origin.y + deltaHeight;
    self.regButtonOutlet.frame = buttonFrame;
    
    CGRect imageViewFrame = self.registerBackgrImageView.frame;
    imageViewFrame.size.height = self.registerBackgrImageView.frame.size.height + deltaHeight;
    self.registerBackgrImageView.frame = imageViewFrame;
}

#pragma mark - Actions

- (IBAction)selectProfession:(id)sender {
    [self presentTableViewControllerForProfessions:YES];
}

- (IBAction)selectInterests:(id)sender {
    [self presentTableViewControllerForProfessions:NO];
}

- (IBAction)finishRegistration:(id)sender {
    if ([self checkIsDataValid]) {
        [[TIMRegistrationModel sharedInstance] saveCountry:self.currentCountry
                                                      city:self.cityNameField.text];
        [[TIMRegistrationModel sharedInstance] saveInterests:_interests
                                                  profession:self.professionLabel.text
                                                       about:self.aboutTextView.text];
        [[TIMLocalUserInfo sharedInstance] saveUserInfoInUserDefaults];
        [self dismissRegistration];
    }
}

#pragma mark - Navigation

- (void)dismissRegistration {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)presentTableViewControllerForProfessions:(BOOL)profession {
    TIMTableViewController *tableController = [[TIMTableViewController alloc]
                                               initWithNibName:@"TIMTableViewController"
                                               bundle:[NSBundle mainBundle]];
    tableController.isProfessions = profession;
    tableController.dataDelegate = self;
    [self.navigationController pushViewController:tableController animated:YES];
}


#pragma mark - Delegates

- (void)tableViewForProfessions:(BOOL)isForProfessions pickedData:(NSArray *)data {
    if (isForProfessions) {
        self.professionLabel.text = [data lastObject];
    } else {
        _interests = [NSArray arrayWithArray:data];
        _staticModel = [[TIMModelWithStaticData alloc] init];
        self.interestsCountLabel.text = [_staticModel formatInterestsString:_interests.count];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    if ([self is_ios7]) {
        CGFloat oldFrameHeight = textView.frame.size.height;
        CGSize textViewSize = [self text:textView.text sizeWithFont:[UIFont lightFontWithSize:15.0f] constrainedToSize:CGSizeMake(265,9999)];
        CGFloat textHeight = textViewSize.height;
        CGRect newFrame = textView.frame;
        newFrame.size.height = textViewSize.height;
        textView.frame = newFrame;
        
        CGFloat deltaHeight = textHeight - oldFrameHeight;
        NSLog(@"delta %f", deltaHeight);
        [self resizeViewsByDelta:deltaHeight];
    } else {
        CGFloat oldFrameHeight = textView.frame.size.height;
        CGRect newFrame = textView.frame;
        newFrame.size.height = textView.contentSize.height;
        textView.frame = newFrame;
        CGFloat newFrameHeight = textView.frame.size.height;
        CGFloat deltaHeight = newFrameHeight - oldFrameHeight;
        [self resizeViewsByDelta:deltaHeight];
    }
}

#pragma mark - Checkings 

- (BOOL)checkIsDataValid{
    NSString* problem = [self checkCity:self.cityNameField.text
                                country:self.countryNameField.text];
    if (!problem) {
        return YES;
    } else {
        UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:@"Ошибка"
                                                           message:problem
                                                          delegate:nil
                                                 cancelButtonTitle:@"Закрыть"
                                                 otherButtonTitles:nil, nil];
        [alerView show];
        return NO;
    }
}

- (BOOL)is_ios7 {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7.0) {
        return YES;
    } else return NO;
}

- (CGSize)text:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        CGRect frame = [text boundingRectWithSize:size
                                          options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                       attributes:@{NSFontAttributeName:font}
                                          context:nil];
        return frame.size;
    } else {
        return [text sizeWithFont:font constrainedToSize:size];
    }
}


#pragma mark - Location Delegate 

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *myPlacemark = [placemarks objectAtIndex:0];
        NSString *country = myPlacemark.country;
        NSString *city = myPlacemark.addressDictionary[@"City"];
        [self setCountryLabel:country city:city];
    }];
    [self.locationManager stopUpdatingLocation];
}

// this delegate method is called if an error occurs in locating your current location
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self setCountryLabel:@"Австралия" city:@""];
}

@end

//
//  TIMStepThreeRegViewController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMStepThreeRegViewController.h"

@interface TIMStepThreeRegViewController () {
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
    if (!self.mapView) {
        [self.locationManager startUpdatingLocation];
    }
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

- (void)customizeFonts {
    self.cityLabel.font = [UIFont lightFontWithSize:13];
    self.countryLabel.font = [UIFont lightFontWithSize:13];
    self.interstsLabel.font = [UIFont lightFontWithSize:13];
    self.professionLabel.font = [UIFont lightFontWithSize:13];
    
    self.interestsCountLabel.font = [UIFont lightFontWithSize:13];
    self.currentProfessionLabel.font = [UIFont lightFontWithSize:13];
    
    self.cityNameField.font = [UIFont lightFontWithSize:15];
    self.countryNameField.font = [UIFont lightFontWithSize:15];
    
    [self.cityNameField setValue:[UIColor colorWithRed:48/255.0 green:56/255.0 blue:68/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [self.countryNameField setValue:[UIColor colorWithRed:48/255.0 green:56/255.0 blue:68/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    
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

- (IBAction)finishRegistration:(id)sender {
    [self dismissRegistration];
}


#pragma mark - Navigation

- (void)dismissRegistration {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Delegates 

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


@end

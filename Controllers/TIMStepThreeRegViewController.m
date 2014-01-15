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
    [self saveStandartUIValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI

- (void)design {
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), SCROLL_HEIGHT);
}

- (void)saveStandartUIValues {
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

- (void)makeStandartSizes {
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
    if (textView.text.length == 0) {
        //[self makeStandartSizes];
        //TODO не ресайзится при полном быстром удалении
    }
    CGFloat oldFrameHeight = textView.frame.size.height;
    CGRect newFrame = textView.frame;
    newFrame.size.height = textView.contentSize.height;
    textView.frame = newFrame;
    CGFloat newFrameHeight = textView.frame.size.height;
    
    CGFloat deltaHeight = newFrameHeight - oldFrameHeight;
    [self resizeViewsByDelta:deltaHeight];
}



@end

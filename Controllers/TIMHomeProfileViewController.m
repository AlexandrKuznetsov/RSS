//
//  TIMHomeProfileViewController.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 11.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMHomeProfileViewController.h"

@interface TIMHomeProfileViewController ()

@end

@implementation TIMHomeProfileViewController

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
    [self checkForLoginInformation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkForLoginInformation {
    //проверка на информацию о логине. При отсутвии - переход на экран с логином.
    //На данный момент переход на экран логина осуществляется всегда для разработки экранов регистрации
    [self pushLoginViewController];
}

- (void)pushLoginViewController {
    TIMLoginViewController *loginController = [[TIMLoginViewController alloc]
                                               initWithNibName:@"TIMLoginViewController"
                                               bundle:[NSBundle mainBundle]];
    TIMRegistrationNavController *registrationNavigation = [[TIMRegistrationNavController alloc]
                                                            initWithRootViewController:loginController];
    [self presentViewController:registrationNavigation animated:NO completion:nil];
}

@end

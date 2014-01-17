//
//  TIMRegistrationModel.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 17.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMRegistrationModel.h"

@implementation TIMRegistrationModel {
    NSString *_login;
    NSString *_password;
    NSString *_name;
    NSString *_surname;
    NSString *_birthdayDate;
    NSString *_gender;
    NSString *_language;
    UIImage *_profilePhoto;
}

static TIMRegistrationModel *sharedInstance = nil;

+ (TIMRegistrationModel *)sharedInstance{
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[super alloc] init];
    });
    return sharedInstance;
}

- (void)saveLogin:(NSString *)loginEmail password:(NSString *)password {
    _login = [loginEmail copy];
    _password = [password copy];
}

- (void)saveName:(NSString *)aName
         surname:(NSString *)aSurname
        birthday:(NSString *)aBirthday
          gender:(NSString *)aGender
        language:(NSString *)aLanguage
    profilePhoto:(UIImage *)aPhoto {
    
    _name = [aName copy];
    _surname = [aSurname copy];
    _birthdayDate = [aBirthday copy];
    _gender = [aGender copy];
    if (_language)
        _language = [aLanguage copy];
    if (_profilePhoto)
        _profilePhoto = [aPhoto copy];
}

@end

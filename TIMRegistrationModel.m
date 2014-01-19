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
    NSString *_city;
    NSString *_country;
    NSString *_interests;
    NSString *_profession;
    NSString *_aboutMe;
}

static TIMRegistrationModel *sharedInstance = nil;

+ (TIMRegistrationModel *)sharedInstance{
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[super alloc] init];
    });
    return sharedInstance;
}

- (void)saveLogin:(NSString *)loginEmail
         password:(NSString *)password {
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
    [TIMLocalUserInfo sharedInstance].name = _name;
    _surname = [aSurname copy];
    [TIMLocalUserInfo sharedInstance].surname = _surname;
    _birthdayDate = [aBirthday copy];
    [TIMLocalUserInfo sharedInstance].birthday = _birthdayDate;
    _gender = [aGender copy];
    [TIMLocalUserInfo sharedInstance].gender = _gender;
    if (_language) {
        _language = [aLanguage copy];
        [TIMLocalUserInfo sharedInstance].defaultLanguage = _language;
    }
    if (_profilePhoto) {
        _profilePhoto = [aPhoto copy];
        [TIMLocalUserInfo sharedInstance].userPhoto = _profilePhoto;
    }
}

- (void)saveCountry:(NSDictionary *)aCountry
               city:(NSString *)aCity {
    _country = aCountry[@"title"];
    [TIMLocalUserInfo sharedInstance].country = aCountry;
    _city = [aCity copy];
    [TIMLocalUserInfo sharedInstance].city = _city;
}

- (void)saveInterests:(NSArray *)anIntersts
           profession:(NSString *)profession
                about:(NSString *)about {
    if (about) {
        _aboutMe = [about copy];
        [TIMLocalUserInfo sharedInstance].aboutMe = _aboutMe;
    }
    if (profession) {
        _profession = [profession copy];
        [TIMLocalUserInfo sharedInstance].profession = _profession;
    }
    if (anIntersts) {
        _interests = [self stringFromInterestsArray:anIntersts];
        [TIMLocalUserInfo sharedInstance].interests = _interests;
    }
}

- (NSString *)stringFromInterestsArray:(NSArray *)array {
    NSMutableString *interests = [[NSMutableString alloc] init];
    for (NSString *interest in array) {
        [interests appendString:[NSString stringWithFormat:@"%@, ",interest]];
    }
    return [interests substringToIndex:[interests length] - 2];
}

@end

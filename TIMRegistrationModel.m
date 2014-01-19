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
    if (aLanguage) {
        _language = [aLanguage copy];
        [TIMLocalUserInfo sharedInstance].defaultLanguage = _language;
    }
    if (aPhoto) {
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

- (void)registerRequestWithCompletition:(void(^)(NSString *errorDescription, BOOL status))completition {
    self.loadCompletionBlock = completition;
    TIMAPIRequests *requests = [[TIMAPIRequests alloc] init];
    [requests registerWithEmail:_login password:_password withCompletition:^(NSError *error, id response) {
        if (error) {
            if ((error.code == NSURLErrorNotConnectedToInternet) || (error.code == NSURLErrorTimedOut)) {
                self.loadCompletionBlock(@"Отсутствует интернет подключение!", NO);
            } else {
                self.loadCompletionBlock(@"Пользователь с таким адресом уже зарегистрирован", NO);
            }
        } else {
            self.loadCompletionBlock(nil, YES);
        }
    }];
}

- (void)loadProfessionsWithCompletition:(void(^)(NSArray *data, BOOL status, NSString *error))completitionBlock {
    self.loadDataBlock = completitionBlock;
    TIMAPIRequests *requests = [[TIMAPIRequests alloc] init];
    [requests loadProfessionsWithCompletition:^(NSError *error, id response) {
        if (error) {
            if ((error.code == NSURLErrorNotConnectedToInternet) || (error.code == NSURLErrorTimedOut)) {
                self.loadDataBlock(nil, NO, @"Отсутствует интернет подключение!");
            } else {
                self.loadDataBlock(nil,NO,@"Ошибка при загрузке");
            }
        } else {
            self.loadDataBlock([self parseResponse:response], YES, nil);
        }
    }];
}

- (NSArray *)parseResponse:(id)response {
    NSMutableArray *responseStringsArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in response) {
        NSString *stringResponse = [dict objectForKey:@"title"];
        [responseStringsArray addObject:stringResponse];
    }
    return responseStringsArray;
}

@end

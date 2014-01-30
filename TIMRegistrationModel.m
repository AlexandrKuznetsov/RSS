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
        sharedInstance = [[self alloc] init];
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
    [[TIMLocalUserInfo sharedInstance] setName:_name];
    _surname = [aSurname copy];
    [[TIMLocalUserInfo sharedInstance] setSurname:_surname];
    _birthdayDate = [aBirthday copy];
    [[TIMLocalUserInfo sharedInstance] setBirthday:_birthdayDate];
    _gender = [aGender copy];
    [[TIMLocalUserInfo sharedInstance] setGender:_gender];
//    if (aLanguage) {
//        _language = [aLanguage copy];
//        [[TIMLocalUserInfo sharedInstance] setDefaultLanguage:_language];
//    }
//    if (aPhoto) {
//        _profilePhoto = [aPhoto copy];
//        [[TIMLocalUserInfo sharedInstance] setUserPhoto:_profilePhoto];
//    }
}

- (void)saveCountry:(NSDictionary *)aCountry
               city:(NSString *)aCity {
    _country = aCountry[@"title"];
    [[TIMLocalUserInfo sharedInstance] setCountry:_country];
    [[TIMLocalUserInfo sharedInstance] setCity:aCity];
}

- (void)saveInterests:(NSString *)anIntersts
           profession:(NSString *)profession
                about:(NSString *)about {
    if (about) {
        [[TIMLocalUserInfo sharedInstance] setAboutMe:about];
    }
    if (profession) {
        [[TIMLocalUserInfo sharedInstance] setProfession:profession];
    }
    if (anIntersts) {
        [[TIMLocalUserInfo sharedInstance] setInterests:anIntersts];
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
    [[TIMAPIRequests sharedManager] registerWithEmail:_login password:_password withCompletition:^(NSError *error, id response) {
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
    [[TIMAPIRequests sharedManager] loadProfessionsWithCompletition:^(NSError *error, id response) {
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

- (void)loadInterestsWithCompletition:(void(^)(NSArray *data, BOOL status, NSString *error))completitionBlock {
    self.loadDataBlock = completitionBlock;
    [[TIMAPIRequests sharedManager] loadInterestsWithCompletition:^(NSError *error, id response) {
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

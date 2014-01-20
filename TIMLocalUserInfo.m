//
//  TIMLocalUserInfo.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 19.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMLocalUserInfo.h"

@implementation TIMLocalUserInfo

@synthesize name = _name;
@synthesize surname = _surname;
@synthesize birthday = _birthday;
@synthesize gender = _gender;
@synthesize defaultLanguage = _defaultLanguage;
@synthesize country = _country;
@synthesize city = _city;
@synthesize interests = _interests;
@synthesize profession = _profession;
@synthesize aboutMe = _aboutMe;
@synthesize userPhoto = _userPhoto;
@synthesize userWalpaper = _userWalpaper;
@synthesize userFlag = _userFlag;

static TIMLocalUserInfo *sharedInstance = nil;

+ (TIMLocalUserInfo *)sharedInstance{
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (BOOL)readUserFromUserDefaults {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user"]) {
        self.user = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults]
                                                                   objectForKey:@"user"]];
        return YES;
    } else {
        self.user = [[NSMutableDictionary alloc] init];
        return NO;
    }
}

- (void)saveUserInfoInUserDefaults {
    [[NSUserDefaults standardUserDefaults] setObject:self.user forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (NSString *)createUserDirectoryForPhotos {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *nameString = @"User";
    
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:nameString];
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:&error]; //Create folder
    }
    return dataPath;
    
}

- (NSString *)saveImage:(UIImage *)image withName:(NSString *)name {
    NSString* imagePath = [[self createUserDirectoryForPhotos]
                           stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpeg",name]];
    NSData* data = UIImageJPEGRepresentation(image, 0.9f);
    if (data) {
        if ([data writeToFile:imagePath atomically:YES]) {
            return imagePath;
        } else {
            return nil;
        }
    }
    else
        return nil;
}

- (UIImage *)imageByFolderPath:(NSString *)path {
    NSData *image = [NSData dataWithContentsOfFile:path];
    return [UIImage imageWithData:image];
}

#pragma mark - Setters 



- (void)setName:(NSString *)name {
    if (!name) {
     name = @"";
    }
    _name = [name copy];
    [self.user setObject:name forKey:@"name"];
}

- (void)setSurname:(NSString *)surname {
    if (!surname) {
        surname = @"";
    }
    _surname = [surname copy];
    [self.user setObject:surname forKey:@"surname"];
}

- (void)setBirthday:(NSString *)birthday {
    if (!birthday) {
        birthday = @"";
    }
    _birthday = [birthday copy];
    [self.user setObject:birthday forKey:@"birthday"];
}

- (void)setGender:(NSString *)gender {
    if (!gender) {
        gender = @"";
    }
    _gender = [gender copy];
    [self.user setObject:gender forKey:@"gender"];
}

- (void)setDefaultLanguage:(NSString *)defaultLanguage {
    if (!defaultLanguage) {
        defaultLanguage = @"";
    }
    _defaultLanguage = [defaultLanguage copy];
    [self.user setObject:defaultLanguage forKey:@"defaultLanguage"];
}

- (void)setCountry:(NSDictionary *)country {
    _country = country;
    [self.user setObject:country forKey:@"country"];
}

- (void)setCity:(NSString *)city {
    if (!city) {
        city = @"";
    }
    _city = [city copy];
    [self.user setObject:city forKey:@"city"];
}

- (void)setInterests:(NSString *)interests {
    if (!interests) {
        interests = @"";
    }
    _interests = interests;
    [self.user setObject:interests forKey:@"interests"];
}

- (void)setProfession:(NSString *)profession {
    if (!profession) {
        profession = @"";
    }
    _profession = [profession copy];
    [self.user setObject:profession forKey:@"profession"];
}

- (void)setAboutMe:(NSString *)aboutMe {
    if (!aboutMe) {
        aboutMe = @"";
    }
    _aboutMe = [aboutMe copy];
    [self.user setObject:aboutMe forKey:@"aboutMe"];
}

- (void)setUserPhoto:(UIImage *)userPhoto {
    if (!userPhoto) {
        userPhoto = [UIImage imageNamed:@"default-wallpaper.png"];
    }
    _userPhoto = userPhoto;
    [self.user setObject:[self saveImage:_userPhoto withName:@"avatar"] forKey:@"avatar"];
}

- (void)setUserWalpaper:(UIImage *)userWalpaper {
    if (!userWalpaper) {
        userWalpaper = [UIImage imageNamed:@"default-avatar.png"];
    }
    _userWalpaper = userWalpaper;
    [self.user setObject:[self saveImage:userWalpaper withName:@"walpaper"] forKey:@"walpaper"];
}

- (void)setEmail:(NSString *)email{
    if (!email) {
        email = @"";
    }
    _email = [email copy];
    [self.user setObject:email forKey:@"email"];
}

- (void)setPrivacyImpressions:(NSString *)privacyImpressions{
    if (!privacyImpressions) {
        privacyImpressions = @"";
    }
    _privacyImpressions = [privacyImpressions copy];
    [self.user setObject:privacyImpressions forKey:@"privacyImpressions"];
}

- (void)setPrivacyInterest:(NSString *)privacyInterest{
    if (!privacyInterest) {
        privacyInterest = @"";
    }
    _privacyInterest = [privacyInterest copy];
    [self.user setObject:privacyInterest forKey:@"privacyInterest"];
}

- (void)setPrivacyOn:(NSString *)privacyOn{
    if (!privacyOn) {
        privacyOn = @"";
    }
    _privacyOn = [privacyOn copy];
    [self.user setObject:privacyOn forKey:@"privacyOn"];
}

- (void)setPrivacyPlace:(NSString *)privacyPlace{
    if (!privacyPlace) {
        privacyPlace = @"";
    }
    _privacyPlace = [privacyPlace copy];
    [self.user setObject:privacyPlace forKey:@"privacyPlace"];

}

- (void)setPrivacyProfession:(NSString *)privacyProfession{
    if (!privacyProfession) {
        privacyProfession = @"";
    }
    _privacyProfession = [privacyProfession copy];
    [self.user setObject:privacyProfession forKey:@"privacyProfession"];

}

#pragma mark - Getters

- (NSString *)name {
    return [self.user objectForKey:@"name"];
}

- (NSString *)surname {
    return [self.user objectForKey:@"surname"];
}

- (NSString *)birthday {
    return [self.user objectForKey:@"birthday"];
}

- (NSString *)gender {
    return [self.user objectForKey:@"gender"];
}

- (NSString *)defaultLanguage {
    return [self.user objectForKey:@"defaultLanguage"];
}

- (NSDictionary *)country {
    NSDictionary *countryDict = [self.user objectForKey:@"country"];
    return countryDict;
}

- (NSString *)city {
    return [self.user objectForKey:@"city"];
}

- (NSString *)interests {
    return [self.user objectForKey:@"interests"];
}

- (NSString *)profession {
    return [self.user objectForKey:@"profession"];
}

- (NSString *)aboutMe {
    return [self.user objectForKey:@"aboutMe"];
}

- (UIImage *)userPhoto {
    return [self imageByFolderPath:[self.user objectForKey:@"avatar"]];
}

- (UIImage *)userWalpaper {
    return [self imageByFolderPath:[self.user objectForKey:@"walpaper"]];
}

- (UIImage *)userFlag {
    NSDictionary *countryDict = [self.user objectForKey:@"country"];
    NSString *countryId = countryDict[@"id"];
    return [UIImage imageNamed:[NSString stringWithFormat:@"flag_%@", countryId]];
}

- (void)loadSettingsWithCompletition:(void(^)(NSError *error, id response))completitionBlock{
    self.loadDataBlock = completitionBlock;
    NSLog(@"%@", [[TIMAPIRequests sharedManager] client1]);
    
    [[[TIMAPIRequests sharedManager] client1] getPath:@"/api/settings" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        if (![operation.responseString hasPrefix:@"ERROR"]) {
            NSError* jsonError;
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonError];
            if (!jsonError) {
                self.loadDataBlock(nil, jsonArray);
            }else{
                self.loadDataBlock(jsonError, nil);
            }
        } else {
            self.loadDataBlock([NSError trueErrorWithServerResponseString:operation.responseString], nil);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.loadDataBlock(error, nil);
    }];
}

- (void)saveSettingsWithCompletition:(void(^)(NSError *error, id response))completitionBlock{
    self.loadDataBlock = completitionBlock;
    [[[TIMAPIRequests sharedManager] client1] postPath:@"/api/update_settings" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", operation.responseString);
        NSLog(@"%@", operation.response.allHeaderFields);
        if (![operation.responseString hasPrefix:@"ERROR"]) {
            NSError* jsonError;
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonError];
            if (!jsonError) {
                self.loadDataBlock(nil, jsonArray);
                [self saveUserInfoInUserDefaults];
            }else{
                self.loadDataBlock(jsonError, nil);
            }
        } else {
            self.loadDataBlock([NSError trueErrorWithServerResponseString:operation.responseString], nil);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.loadDataBlock(error, nil);
    }];
}

- (void)parseResponse:(id)response{
    if ([response isKindOfClass:([NSDictionary class])]) {
        self.name = [response objectForKey:@"first_name"];
        self.surname = [response objectForKey:@"last_name"];
        self.email = [response objectForKey:@"email"];
        self.city = [response objectForKey:@"city"];
        self.country = [response objectForKey:@"country"];
        self.birthday = [response objectForKey:@"year_born"];
        self.gender = [response objectForKey:@"sex"];
        self.defaultLanguage = [response objectForKey:@"language"];
        self.avatarName = [response objectForKey:@"avatar_file_name"];
        self.wallpaperName = [response objectForKey:@"wallpaper_file_name"];
        self.profession = [response objectForKey:@"profession"];
        
        self.interests = [response objectForKey:@"interests"];
        
        self.aboutMe = [response objectForKey:@"description"];
        self.privacyOn = [response objectForKey:@"privacy_on"];
        self.privacyPlace = [response objectForKey:@"privacy_place"];
        self.privacyInterest = [response objectForKey:@"privacy_interest"];
        self.privacyImpressions = [response objectForKey:@"privacy_impressions"];
        self.privacyProfession = [response objectForKey:@"privacy_profession"];
    }
}

- (NSDictionary*)userSettingDictionary{
    NSDictionary* userDictionary = @{@"first_name": _name,
                                     @"last_name": _surname,
                                     @"email": _email,
                                     @"city": _city,
                                     @"country": _country,
                                     @"year_born": _birthday,
                                     @"sex": _gender,
                                     @"language": _defaultLanguage,
                                     @"description": _aboutMe,
//                                     @"created_at": @"",
//                                     @"updated_at": @"",
//                                     @"encrypted_password": @"",
//                                     @"reset_password_token": @"",
//                                     @"reset_password_sent_at": @"",
//                                     @"remember_created_at": @"",
//                                     @"sign_in_count": @"",
//                                     @"current_sign_in_at": @"",
//                                     @"last_sign_in_at": @"",
//                                     @"current_sign_in_ip": @"",
//                                     @"last_sign_in_ip": @"",
                                     @"avatar_file_name": _avatarName,
//                                     @"avatar_content_type": @"",
//                                     @"avatar_file_size": @"",
//                                     @"avatar_updated_at": @"",
                                     @"wallpaper_file_name": _wallpaperName,
//                                     @"wallpaper_content_type": @"",
//                                     @"wallpaper_file_size": @"",
//                                     @"wallpaper_updated_at": @"",
                                     @"profession": _profession,
                                     @"interests": _interests,
                                     @"privacy_on": _privacyOn,
                                     @"privacy_place": _privacyPlace,
                                     @"privacy_interest": _privacyInterest,
                                     @"privacy_impressions": _privacyImpressions,
                                     @"privacy_profession": _privacyProfession,
                                     };
    return userDictionary;
}

@end

//
//  TIMLocalUserInfo.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 19.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMLocalUserInfo.h"
#import "TIMKeychain.h"

@implementation TIMLocalUserInfo

@synthesize name = _name;
@synthesize surname = _surname;
@synthesize birthday = _birthday;
@synthesize gender = _gender;
//@synthesize defaultLanguage = _defaultLanguage;
@synthesize city = _city;
@synthesize interests = _interests;
@synthesize profession = _profession;
@synthesize aboutMe = _aboutMe;
@synthesize userPhoto = _userPhoto;
@synthesize userWalpaper = _userWalpaper;
@synthesize userFlag = _userFlag;
@synthesize privacyImpressions = _privacyImpressions;
@synthesize privacyInterest = _privacyInterest;
@synthesize privacyOn = _privacyOn;
@synthesize privacyPlace = _privacyPlace;
@synthesize privacyProfession = _privacyProfession;
@synthesize email = _email;

static TIMLocalUserInfo *sharedInstance = nil;

+ (TIMLocalUserInfo *)sharedInstance{
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init{
    self = [super init];
    if (self) {
        [self initializeData];
    }
    return self;
}

- (void)initializeData{
    self.user = [NSMutableDictionary dictionaryWithDictionary:
                 [[NSUserDefaults standardUserDefaults] objectForKey:@"user"]];
    if (!self.user) {
        self.user = [[NSMutableDictionary alloc] init];
    }
    self.needUpdate = YES;
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

- (void)deleteLocalUser{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
    [self resetUserInfo];
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
    if (!name || [name isKindOfClass:([NSNull class])]) {
        name = @"";
    }
    _name = [name copy];
    [self.user setObject:name forKey:@"name"];
}

- (void)setSurname:(NSString *)surname {
    if (!surname || [surname isKindOfClass:([NSNull class])]) {
        surname = @"";
    }
    _surname = [surname copy];
    [self.user setObject:surname forKey:@"surname"];
}

- (void)setBirthday:(NSString *)birthday {
    if (!birthday || [birthday isKindOfClass:([NSNull class])]) {
        birthday = @"";
    }
    _birthday = [birthday copy];
    [self.user setObject:birthday forKey:@"birthday"];
}

- (void)setGender:(NSString *)gender {
    if (!gender || [gender isKindOfClass:([NSNull class])]) {
        gender = @"";
    }
    _gender = [gender copy];
    [self.user setObject:gender forKey:@"gender"];
}

//- (void)setDefaultLanguage:(NSString *)defaultLanguage {
//    if (!defaultLanguage || [defaultLanguage isKindOfClass:([NSNull class])]) {
//        defaultLanguage = @"";
//    }
//    _defaultLanguage = [defaultLanguage copy];
//    [self.user setObject:defaultLanguage forKey:@"defaultLanguage"];
//}

- (void)setCountry:(NSString *)country {
    if (!country || [country isKindOfClass:([NSNull class])]) {
        country = @"";
    }
    [self.user setObject:country forKey:@"country"];
}

- (void)setCity:(NSString *)city {
    if (!city || [city isKindOfClass:([NSNull class])]) {
        city = @"";
    }
    _city = [city copy];
    [self.user setObject:city forKey:@"city"];
}

- (void)setInterests:(NSArray *)interests {
    if (!interests || [interests isKindOfClass:([NSNull class])]) {
        interests = [NSArray array];
    }
    _interests = [interests copy];
    [self.user setObject:interests forKey:@"interests"];
}

- (void)setProfession:(NSArray *)profession {
    if (!profession || [profession isKindOfClass:([NSNull class])]) {
        profession = [NSArray array];
    }
    _profession = [profession copy];
    [self.user setObject:profession forKey:@"profession"];
}

- (void)setAboutMe:(NSString *)aboutMe {
    if (!aboutMe || [aboutMe isKindOfClass:([NSNull class])]) {
        aboutMe = @"";
    }
    _aboutMe = [aboutMe copy];
    [self.user setObject:aboutMe forKey:@"aboutMe"];
}

//- (void)setUserPhoto:(UIImage *)userPhoto {
//    if (!userPhoto || [userPhoto isKindOfClass:([NSNull class])]) {
//        userPhoto = [UIImage imageNamed:@"default-avatar.png"];
//    }
//    _userPhoto = userPhoto;
//    [self.user setObject:[self saveImage:_userPhoto withName:@"avatar"] forKey:@"avatar"];
//}
//
//- (void)setUserWalpaper:(UIImage *)userWalpaper {
//    if (!userWalpaper || [userWalpaper isKindOfClass:([NSNull class])]) {
//        userWalpaper = [[UIImage alloc] init];
//    }
//    _userWalpaper = userWalpaper;
//    NSString* imagePath = [self saveImage:_userWalpaper withName:@"walpaper"];
//    if (imagePath) {
//        [self.user setObject:imagePath forKey:@"walpaper"];
//    }
//}

- (void)setEmail:(NSString *)email{
    if (!email || [email isKindOfClass:([NSNull class])]) {
        email = @"";
    }
    _email = [email copy];
    [self.user setObject:email forKey:@"email"];
}

- (void)setPrivacyImpressions:(NSInteger)privacyImpressions{
    if (!privacyImpressions) {
        privacyImpressions = 2;
    }
    _privacyImpressions = privacyImpressions;
    [self.user setObject:[NSNumber numberWithInteger:privacyImpressions]
                  forKey:@"privacyImpressions"];
}

- (void)setPrivacyInterest:(NSInteger)privacyInterest{
    if (!privacyInterest) {
        privacyInterest = 2;
    }
    _privacyInterest = privacyInterest;
    [self.user setObject:[NSNumber numberWithInteger:privacyInterest]
                  forKey:@"privacyInterest"];
}

- (void)setPrivacyOn:(NSInteger)privacyOn{
    if (!privacyOn) {
        privacyOn = 1;
    }
    _privacyOn = privacyOn;
    [self.user setObject:[NSNumber numberWithInteger:privacyOn]
                  forKey:@"privacyOn"];
}

- (void)setPrivacyPlace:(NSInteger)privacyPlace{
    if (!privacyPlace) {
        privacyPlace = 0;
    }
    _privacyPlace = privacyPlace;
    [self.user setObject:[NSNumber numberWithInteger:privacyPlace]
                  forKey:@"privacyPlace"];

}

- (void)setAvatarName:(NSString *)avatarName{
    if (!avatarName || [avatarName isKindOfClass:([NSNull class])]) {
        avatarName = @"";
    }
    _avatarName = [avatarName copy];
    if (![_avatarName isEqualToString:@""]) {
        NSString* urlString = [NSString stringWithFormat:@"%@%@", [[TIMAPIRequests sharedManager] server], avatarName];
        NSURL* url = [NSURL URLWithString:urlString];
        NSData* imageData = [NSData dataWithContentsOfURL:url];
        if (imageData.length > 0) {
            _userPhoto = [UIImage imageWithData:imageData];
        } else {
            _userPhoto = nil;
        }
    }
    [self.user setObject:avatarName forKey:@"avatarName"];
}

- (void)setWallpaperName:(NSString *)wallpaperName{
    if (!wallpaperName || [wallpaperName isKindOfClass:([NSNull class])]) {
        wallpaperName = @"";
    }
    _wallpaperName = [wallpaperName copy];
    if (![_wallpaperName isEqualToString:@""]) {
        NSString* urlString = [NSString stringWithFormat:@"%@%@", [[TIMAPIRequests sharedManager] server], _wallpaperName];
        NSURL* url = [NSURL URLWithString:urlString];
        NSData* imageData = [NSData dataWithContentsOfURL:url];
        if (imageData.length > 0) {
            _userWalpaper = [UIImage imageWithData:imageData];
        } else {
            _userWalpaper = nil;
        }
    }
    [self.user setObject:wallpaperName forKey:@"wallpaperName"];
}

- (void)setPrivacyProfession:(NSInteger)privacyProfession{
    if (!privacyProfession) {
        privacyProfession = 2;
    }
    _privacyProfession = privacyProfession;
    [self.user setObject:[NSNumber numberWithInteger:privacyProfession]
                  forKey:@"privacyProfession"];

}

- (void)setUserPhoto:(UIImage *)userPhoto{
    _isAvatarChanged = YES;
    if (!userPhoto) {
        _userPhoto = nil;
        return;
    }
    _userPhoto = [userPhoto copy];
}

- (void)setUserWalpaper:(UIImage *)userWalpaper{
    _isWalpaperChanged = YES;
    if (!userWalpaper) {
        _userWalpaper = nil;
        return;
    }
    _userWalpaper = [userWalpaper copy];
}

#pragma mark - Getters

- (NSString *)name {
    if ([self.user objectForKey:@"name"]) {
        return [self.user objectForKey:@"name"];
    } else {
        return @"";
    }
}

- (NSString *)surname {
    if ([self.user objectForKey:@"surname"]) {
        return [self.user objectForKey:@"surname"];
    } else {
        return @"";
    }
}

- (NSString *)birthday {
    if ([self.user objectForKey:@"birthday"]) {
        return [self.user objectForKey:@"birthday"];
    } else {
        return @"";
    }
}

- (NSString *)gender {
    if ([self.user objectForKey:@"gender"]) {
        NSLog(@"gender %@", [self.user objectForKey:@"gender"]);
        return [self.user objectForKey:@"gender"];
    } else {
        return @"";
    }
}

- (NSString *)defaultLanguage {
    if ([self.user objectForKey:@"defaultLanguage"]) {
        return [self.user objectForKey:@"defaultLanguage"];
    } else {
        return @"English";
    }
}

- (NSString *)country {
    if ([self.user objectForKey:@"country"]) {
        NSString *country = [self.user objectForKey:@"country"];
        return country;
    } else {
        return @"";
    }
}

- (NSString*)email{
    if ([self.user objectForKey:@"email"]) {
        return [self.user objectForKey:@"email"];
    } else {
        return @"";
    }
}

- (NSInteger)privacyOn{
    if ([self.user objectForKey:@"privacyOn"]) {
        return [[self.user objectForKey:@"privacyOn"] integerValue];
    } else {
        return 0;
    }
}

- (NSInteger)privacyPlace{
    if ([self.user objectForKey:@"privacyPlace"]) {
        return [[self.user objectForKey:@"privacyPlace"] integerValue];
    } else {
        return 0;
    }
}

- (NSInteger)privacyInterest{
    if ([self.user objectForKey:@"privacyInterest"]) {
        return [[self.user objectForKey:@"privacyInterest"] integerValue];
    } else {
        return 1;
    }
}

- (NSInteger)privacyImpressions{
    if ([self.user objectForKey:@"privacyImpressions"]) {
        return [[self.user objectForKey:@"privacyImpressions"] integerValue];
    } else {
        return 2;
    }
}

- (NSInteger)privacyProfession{
    if ([self.user objectForKey:@"privacyProfession"]) {
        return [[self.user objectForKey:@"privacyProfession"] integerValue];
    } else {
        return 2;
    }
}

- (NSString *)city {
    if ([self.user objectForKey:@"city"]) {
        return [self.user objectForKey:@"city"];
    } else {
        return @"";
    }
}

- (NSArray *)interests {
    if ([self.user objectForKey:@"interests"]) {
        return [self.user objectForKey:@"interests"];
    } else {
        return [NSArray array];
    }
}

- (NSArray *)profession {
    if ([self.user objectForKey:@"profession"]) {
        return [self.user objectForKey:@"profession"];
    } else {
        return [NSArray array];
    }
}

- (NSString *)aboutMe {
    if ([self.user objectForKey:@"aboutMe"]) {
        return [self.user objectForKey:@"aboutMe"];
    } else {
        return @"";
    }
}

- (BOOL)isInterestExist:(NSString*)interest{
    for (NSDictionary* singleInterest in _interests) {
        
        if ([singleInterest[@"name"] isEqualToString:interest]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isProfessionExist:(NSString*)profession{
    for (NSDictionary* singleInterest in _profession) {
        
        if ([singleInterest[@"name"] isEqualToString:profession]) {
            return YES;
        }
    }
    return NO;
}

- (UIImage *)userFlag {
    NSString* countryString = [self.user objectForKey:@"country"];
    TIMModelWithStaticData* staticData = [[TIMModelWithStaticData alloc] init];
    NSDictionary *countryDict = [staticData getCounryDictWithCountryName:countryString];
    NSString *countryId = countryDict[@"id"];
    return [UIImage imageNamed:[NSString stringWithFormat:@"flag_%@", countryId]];
}

- (void)loadSettingsWithCompletition:(void(^)(NSError *error, id response))completitionBlock{
    self.loadDataBlock = completitionBlock;
//    NSDictionary* someData = [TIMKeychain load:KEYCHAIN_SERVICE];
    
    [[[TIMAPIRequests sharedManager] client1] postPath:@"/api/profile" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        if (![operation.responseString hasPrefix:@"ERROR"]) {
            NSError* jsonError;
            NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonError];
            if (!jsonError) {
                id errorsArray = jsonArray[@"errors"];
                if ([errorsArray count] > 0) {
                    NSError* error;
                    if (![errorsArray isKindOfClass:([NSArray class])]) {
                        for (NSString* key in errorsArray) {
                            if ([errorsArray[key] isEqualToString:@"not logged"]) {
                                error = [NSError errorWithDomain:@"TrueImpression" code:12015 userInfo:nil];
                            }
                        }
                    } else {
                        for (NSDictionary* errorDict in errorsArray) {
                            for (NSString* key in errorDict) {
                                if ([errorDict[key] isEqualToString:@"not logged"]) {
                                    error = [NSError errorWithDomain:@"TrueImpression" code:12015 userInfo:nil];
                                }
                            }
                        }
                    }
                    self.loadDataBlock(error, nil);
                } else {
                    [self parseResponse:jsonArray[@"data"]];
                    self.loadDataBlock(nil, jsonArray);
                }
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
//    NSDictionary* someData = [TIMKeychain load:KEYCHAIN_SERVICE];
    NSMutableDictionary* allDAtaDict = [NSMutableDictionary
                                        dictionaryWithDictionary:[self userSettingDictionary]];
//    [allDAtaDict setValuesForKeysWithDictionary:someData];
    NSMutableURLRequest* request = [[[TIMAPIRequests sharedManager] client1] multipartFormRequestWithMethod:@"POST" path:@"/api/profile" parameters:allDAtaDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if (_isAvatarChanged) {
            NSData* avaData;
            if (self.userPhoto) {
                avaData = UIImageJPEGRepresentation(self.userPhoto, 0.8);
            } else {
                avaData = [NSData data];
            }
                [formData appendPartWithFileData:avaData
                                            name:@"avatar"
                                        fileName:[@"avatar" stringByAppendingString:@".jpg"]
                                        mimeType:@"image/jpeg"];
                _isAvatarChanged = NO;
            
        }
        if (_isWalpaperChanged) {
            NSData* walpaperData;
            if (self.userWalpaper) {
                walpaperData = UIImageJPEGRepresentation(self.userWalpaper, 0.8);
                [formData appendPartWithFileData:walpaperData
                                            name:@"wallpaper"
                                        fileName:[@"wallpaper" stringByAppendingString:@".jpg"]
                                        mimeType:@"image/jpeg"];
                _isWalpaperChanged = NO;
            }
        }
    }];
    
    [[[[TIMAPIRequests sharedManager] client1] HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString* responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (![operation.responseString hasPrefix:@"ERROR"]) {
            [self saveUserInfoInUserDefaults];
            self.loadDataBlock(nil, nil);
        } else {
            self.loadDataBlock([NSError trueErrorWithServerResponseString:operation.responseString], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.loadDataBlock(error, nil);
    }] start];
}

- (void)parseResponse:(id)response {
    if ([response isKindOfClass:([NSDictionary class])]) {
        self.name = [response objectForKey:@"firstName"];
        self.surname = [response objectForKey:@"lastName"];
        self.email = [response objectForKey:@"email"];
        self.city = [response objectForKey:@"city"];
        [self setCountry:[response objectForKey:@"country"]];
        self.birthday = [response objectForKey:@"birthday"];
        self.gender = [response objectForKey:@"sex"];
//        self.defaultLanguage = [response objectForKey:@"language"];
        self.avatarName = [response objectForKey:@"avatar"];
        self.wallpaperName = [response objectForKey:@"wallpaper"];
        self.profession = [response objectForKey:@"professions"];
        self.interests = [response objectForKey:@"interests"];
        self.aboutMe = [response objectForKey:@"about"];
        self.privacyOn = (long)[[response objectForKey:@"privacyOn"] integerValue];
        self.privacyPlace = (long)[[response objectForKey:@"privacyPlace"] integerValue];
        self.privacyInterest = (long)[[response objectForKey:@"privacyInterest"] integerValue];
        self.privacyImpressions = [[response objectForKey:@"privacyImpressions"] integerValue];
        self.privacyProfession = [[response objectForKey:@"privacyProfession"] integerValue];
        [self calculateDescriptionAboutMeSizes];
    }
}

- (NSDictionary*)userSettingDictionary{
    NSDictionary* userDictionary = @{@"firstName": self.name,
                                     @"lastName": self.surname,
                                     @"email": self.email,
                                     @"city": self.city,
                                     @"country": self.user[@"country"],
                                     @"birthday": self.birthday,
                                     @"sex": self.gender,
                                     @"about": self.aboutMe,
                                     @"professions": [self professionsIds],
                                     @"interests": [self interestsIds],
                                     @"privacyOn": [NSNumber numberWithInteger:self.privacyOn],
                                     @"privacyPlace": [NSNumber numberWithInteger:self.privacyPlace],
                                     @"privacyInterest": [NSNumber numberWithInteger:self.privacyInterest],
                                     @"privacyImpressions": [NSNumber numberWithInteger:self.privacyImpressions],
                                     @"privacyProfession": [NSNumber numberWithInteger:self.privacyProfession],
                                     };
    return userDictionary;
}

- (NSArray*)professionsIds{
    NSMutableArray* idsArray = [[NSMutableArray alloc] init];
    for (NSDictionary* profesion in self.profession) {
        [idsArray addObject:profesion[@"id"]];
    }
    return idsArray;
}

- (NSArray*)interestsIds{
    NSMutableArray* idsArray = [[NSMutableArray alloc] init];
    for (NSDictionary* interes in self.interests) {
        [idsArray addObject:interes[@"id"]];
    }
    return idsArray;
}

- (void)calculateDescriptionAboutMeSizes{
    
    NSNumber* aboutMySelf;
    if ([self.aboutMe isEqualToString:@""]) {
        aboutMySelf = [NSNumber numberWithInt:1];
    } else {
        aboutMySelf = [self calculateHeightForText:self.aboutMe];
    }
    self.descrAboutMeSizes = @{@"interests": [self calculateHeightForText:self.interests],
                               @"aboutMe": aboutMySelf,
                               @"cellHeight": [NSNumber numberWithFloat:162.0 - 16*2]};
}

- (NSNumber*)calculateHeightForText:(id)interests{
    NSMutableString* interestsString = [[NSMutableString alloc] init];
    if ([interests isKindOfClass:([NSArray class])]) {
        [interestsString appendString:[self interestsText]];
//        for (NSString* interest in interests) {
//            [interestsString appendString:interest];
//            if (![interest isEqualToString:[interests lastObject]]) {
//                [interestsString appendString:@","];
//            }
//        }
    } else {
        [interestsString appendString:interests];
    }
    CGSize labelsSize = CGSizeMake(251, CGFLOAT_MAX);
    CGSize size;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
         CGRect frame = [interestsString boundingRectWithSize:labelsSize
                                          options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                       attributes:@{NSFontAttributeName:[UIFont regularFontWithSize:12.0f]}
                                          context:nil];
        size = frame.size;
        size.height += 1;
    } else {
        size = [interestsString sizeWithFont:[UIFont regularFontWithSize:12.0f]
                 constrainedToSize:labelsSize];
    }
    return [NSNumber numberWithFloat:size.height];
}

- (NSString*)professionText{
    NSMutableString* professionString = [[NSMutableString alloc] init];
    for (NSString* profession in _profession) {
        [professionString appendString:profession];
        if (![profession isEqualToString:[_profession lastObject]]) {
            [professionString appendString:@","];
        }
    }
    return professionString;
}

- (NSString*)interestsText{
    NSMutableString* interestsString = [[NSMutableString alloc] init];
    for (NSDictionary* interest in _interests) {
        [interestsString appendString:interest[@"name"]];
        if (![interest[@"name"] isEqualToString:[_interests lastObject][@"name"]]) {
            [interestsString appendString:@","];
        }
    }
    return interestsString;
}

- (void)resetUserInfo{
    [self setName:nil];
    [self setSurname:nil];
    [self setEmail:nil];
    [self setCity:nil];
    [self setBirthday:nil];
    [self setGender:nil];
//    [self setDefaultLanguage:nil];
    [self setAvatarName:nil];
    [self setWallpaperName:nil];
    [self setProfession:nil];
    [self setInterests:nil];
    [self setAboutMe:nil];
    
    [self setUserPhoto:nil];
    [self setUserWalpaper:nil];
    [self setUserFlag:nil];
}

- (void)addImagesToRequestWithFormData:(id<AFMultipartFormData>)formData{
    
}

-(void)updateUserSettingsWithDictionary:(NSDictionary*)params
                                 images:(NSArray*)images
                              imageKeys:(NSArray*)imageKeys
                     andCompletionBlock:(void(^)(NSError* error))completionBlock{
    
    NSMutableDictionary* advancedDict = [params mutableCopy];
    
    NSString* email = [[NSUserDefaults standardUserDefaults] valueForKey:@"email"];
    NSString* password = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
    
    if (email) {
        advancedDict[@"email"] = email;
    }
    
    if (password) {
        advancedDict[@"password"] = password;
    }
    
    NSMutableURLRequest* request = [[[TIMAPIRequests sharedManager] client1] multipartFormRequestWithMethod:@"POST" path:advancedDict[@"email"] parameters:advancedDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (images.count == imageKeys.count && imageKeys.count > 0) {
            for (int i=0;i<images.count;i++) {
                UIImage* image = images[i];
                
                if ([image isKindOfClass:[NSNull class]] || !image) {
                    continue;
                }
                
                NSString* imageKey = imageKeys[i];
                
                NSData* data = UIImageJPEGRepresentation(image, 0.8);
                
                [formData appendPartWithFileData:data
                                            name:imageKey
                                        fileName:[imageKey stringByAppendingString:@".jpg"]
                                        mimeType:@"image/jpeg"];
            }
        }
    }];
    
    [[[[TIMAPIRequests sharedManager] client1] HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([operation.responseString hasPrefix:@"OK"]) {
            completionBlock(nil);
            [self saveUserInfoInUserDefaults];
        }else{
            NSLog(@"Reponse: %@", operation.responseString);
            completionBlock([NSError trueErrorWithServerResponseString:operation.responseString]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(completionBlock){
            completionBlock(error);
        }
    }] start];
}

#pragma mark - Reachbility

- (void)connected {
    reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    if ((internetStatus) != (NotReachable)) {
        _isConnection = YES;
    } else {
        _isConnection = NO;
    }
}

- (void)checkNetworkStatus:(NSNotification *)notice {
    // called after network status changes
    
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:
        {
            _isConnection = NO;
            break;
        }
        case ReachableViaWiFi:
        {
            _isConnection = YES;
            break;
        }
        case ReachableViaWWAN:
        {
            _isConnection = YES;
            break;
        }
    }
}

- (NSString*)privacyString:(NSInteger)type{
    switch (type) {
        case 0:
            return @"Все";
            break;
        case 1:
            return @"Только я";
            break;
        case 2:
            return @"Только друзья";
            break;
        default:
            break;
    }
    return nil;
}

@end

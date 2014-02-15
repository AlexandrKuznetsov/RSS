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
@synthesize defaultLanguage = _defaultLanguage;
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

- (void)setDefaultLanguage:(NSString *)defaultLanguage {
    if (!defaultLanguage || [defaultLanguage isKindOfClass:([NSNull class])]) {
        defaultLanguage = @"";
    }
    _defaultLanguage = [defaultLanguage copy];
    [self.user setObject:defaultLanguage forKey:@"defaultLanguage"];
}

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

- (void)setInterests:(NSString *)interests {
    if (!interests || [interests isKindOfClass:([NSNull class])]) {
        interests = @"";
    }
    _interests = [interests copy];
    [self.user setObject:interests forKey:@"interests"];
}

- (void)setProfession:(NSString *)profession {
    if (!profession || [profession isKindOfClass:([NSNull class])]) {
        profession = @"";
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

- (void)setPrivacyImpressions:(NSString *)privacyImpressions{
    if (!privacyImpressions || [privacyImpressions isKindOfClass:([NSNull class])]) {
        privacyImpressions = @"только друзья";
    }
    _privacyImpressions = [privacyImpressions copy];
    [self.user setObject:privacyImpressions forKey:@"privacyImpressions"];
}

- (void)setPrivacyInterest:(NSString *)privacyInterest{
    if (!privacyInterest || [privacyInterest isKindOfClass:([NSNull class])]) {
        privacyInterest = @"только я";
    }
    _privacyInterest = [privacyInterest copy];
    [self.user setObject:privacyInterest forKey:@"privacyInterest"];
}

- (void)setPrivacyOn:(NSString *)privacyOn{
    if (!privacyOn || [privacyOn isKindOfClass:([NSNull class])]) {
        privacyOn = @"";
    }
    _privacyOn = [privacyOn copy];
    [self.user setObject:privacyOn forKey:@"privacyOn"];
}

- (void)setPrivacyPlace:(NSString *)privacyPlace{
    if (!privacyPlace || [privacyPlace isKindOfClass:([NSNull class])]) {
        privacyPlace = @"все";
    }
    _privacyPlace = [privacyPlace copy];
    [self.user setObject:privacyPlace forKey:@"privacyPlace"];

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

- (void)setPrivacyProfession:(NSString *)privacyProfession{
    if (!privacyProfession || [privacyProfession isKindOfClass:([NSNull class])]) {
        privacyProfession = @"только друзья";
    }
    _privacyProfession = [privacyProfession copy];
    [self.user setObject:privacyProfession forKey:@"privacyProfession"];

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

- (NSString*)privacyOn{
    if ([self.user objectForKey:@"privacyOn"]) {
        return [self.user objectForKey:@"privacyOn"];
    } else {
        return @"";
    }
}

- (NSString*)privacyPlace{
    if ([self.user objectForKey:@"privacyPlace"]) {
        return [self.user objectForKey:@"privacyPlace"];
    } else {
        return @"";
    }
}

- (NSString*)privacyInterest{
    if ([self.user objectForKey:@"privacyInterest"]) {
        return [self.user objectForKey:@"privacyInterest"];
    } else {
        return @"";
    }
}

- (NSString*)privacyImpressions{
    if ([self.user objectForKey:@"privacyImpressions"]) {
        return [self.user objectForKey:@"privacyImpressions"];
    } else {
        return @"";
    }
}

- (NSString*)privacyProfession{
    if ([self.user objectForKey:@"privacyProfession"]) {
        return [self.user objectForKey:@"privacyProfession"];
    } else {
        return @"";
    }
}

- (NSString *)city {
    if ([self.user objectForKey:@"city"]) {
        return [self.user objectForKey:@"city"];
    } else {
        return @"";
    }
}

- (NSString *)interests {
    if ([self.user objectForKey:@"interests"]) {
        return [self.user objectForKey:@"interests"];
    } else {
        return @"";
    }
}

- (NSString *)profession {
    if ([self.user objectForKey:@"profession"]) {
        return [self.user objectForKey:@"profession"];
    } else {
        return @"";
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
    NSArray* interestArray = [_interests componentsSeparatedByString:@"|"];
    for (NSString* singleInterest in interestArray) {
        
        if ([singleInterest isEqualToString:interest]) {
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
    NSDictionary* someData = [TIMKeychain load:KEYCHAIN_SERVICE];
    
    [[[TIMAPIRequests sharedManager] client1] postPath:@"/api/settings" parameters:someData success:^(AFHTTPRequestOperation *operation, id responseObject) {

        if (![operation.responseString hasPrefix:@"ERROR"]) {
            NSError* jsonError;
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonError];
            if (!jsonError) {
                [self parseResponse:jsonArray];
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
    NSDictionary* someData = [TIMKeychain load:KEYCHAIN_SERVICE];
    NSMutableDictionary* allDAtaDict = [NSMutableDictionary
                                        dictionaryWithDictionary:[self userSettingDictionary]];
    [allDAtaDict setValuesForKeysWithDictionary:someData];
    NSMutableURLRequest* request = [[[TIMAPIRequests sharedManager] client1] multipartFormRequestWithMethod:@"POST" path:@"/api/update_settings" parameters:allDAtaDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
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
        self.name = [response objectForKey:@"first_name"];
        self.surname = [response objectForKey:@"last_name"];
        self.email = [response objectForKey:@"email"];
        self.city = [response objectForKey:@"city"];
        [self setCountry:[response objectForKey:@"country"]];
        self.birthday = [response objectForKey:@"born_date"];
        self.gender = [response objectForKey:@"sex"];
        self.defaultLanguage = [response objectForKey:@"app_lang"];
        self.avatarName = [response objectForKey:@"avatar"];
        self.wallpaperName = [response objectForKey:@"wallpaper"];
        self.profession = [response objectForKey:@"profession"];
        self.interests = [response objectForKey:@"interests"];
        self.aboutMe = [response objectForKey:@"about"];        
        self.privacyOn = [response objectForKey:@"privacy_on"];
        self.privacyPlace = [response objectForKey:@"privacy_place"];
        self.privacyInterest = [response objectForKey:@"privacy_interest"];
        self.privacyImpressions = [response objectForKey:@"privacy_impressions"];
        self.privacyProfession = [response objectForKey:@"privacy_profession"];
        [self calculateDescriptionAboutMeSizes];
    }
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

- (NSNumber*)calculateHeightForText:(NSString*)text{
    CGSize labelsSize = CGSizeMake(251, CGFLOAT_MAX);
    CGSize size;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
         CGRect frame = [text boundingRectWithSize:labelsSize
                                          options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                       attributes:@{NSFontAttributeName:[UIFont regularFontWithSize:12.0f]}
                                          context:nil];
        size = frame.size;
        size.height += 1;
    } else {
        size = [text sizeWithFont:[UIFont regularFontWithSize:12.0f]
                 constrainedToSize:labelsSize];
    }
    return [NSNumber numberWithFloat:size.height];
}

- (NSDictionary*)userSettingDictionary{
    NSDictionary* userDictionary = @{@"first_name": self.name,
                                     @"last_name": self.surname,
                                     @"email": self.email,
                                     @"city": self.city,
                                     @"country": self.user[@"country"],
                                     @"born_date": self.birthday,
                                     @"sex": self.gender,
                                     @"app_lang": self.defaultLanguage,
                                     @"about": self.aboutMe,
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

//                                     @"avatar_file_name": self.avatarName,
                                     
//                                     @"avatar_content_type": @"",
//                                     @"avatar_file_size": @"",
//                                     @"avatar_updated_at": @"",
                                     
//                                     @"wallpaper_file_name": self.wallpaperName,
                                     
//                                     @"wallpaper_content_type": @"",
//                                     @"wallpaper_file_size": @"",
//                                     @"wallpaper_updated_at": @"",
                                     @"profession": self.profession,
                                     @"interests": self.interests,
                                     @"privacy_on": self.privacyOn,
                                     @"privacy_place": self.privacyPlace,
                                     @"privacy_interest": self.privacyInterest,
                                     @"privacy_impressions": self.privacyImpressions,
                                     @"privacy_profession": self.privacyProfession,
                                     };
    return userDictionary;
}

- (void)resetUserInfo{
    [self setName:nil];
    [self setSurname:nil];
    [self setEmail:nil];
    [self setCity:nil];
    [self setBirthday:nil];
    [self setGender:nil];
    [self setDefaultLanguage:nil];
    [self setAvatarName:nil];
    [self setWallpaperName:nil];
    [self setProfession:nil];
    [self setInterests:nil];
    [self setAboutMe:nil];
    [self setPrivacyOn:nil];
    [self setPrivacyPlace:nil];
    [self setPrivacyInterest:nil];
    [self setPrivacyImpressions:nil];
    [self setPrivacyProfession:nil];
    
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

@end

//
//  TIMLocalUserInfo.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 19.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIMAPIRequests.h"
#import "TIMModelWithStaticData.h"
#import "UIFont+TIFonts.h"
#import "Reachability.h"

@interface TIMLocalUserInfo : NSObject{
    Reachability* reachability;
}

@property (nonatomic, copy) void(^loadDataBlock)(NSError *error, id response);

@property (strong, nonatomic) NSMutableDictionary *user;


@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *surname;
@property (copy, nonatomic) NSString* email;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *birthday;
@property (copy, nonatomic) NSString *gender;
//@property (copy, nonatomic) NSString *defaultLanguage;
@property (copy, nonatomic) NSString *avatarName;
@property (copy, nonatomic) NSString *wallpaperName;
@property (copy, nonatomic) NSArray *profession;
@property (copy, nonatomic) NSArray *interests;
@property (assign, nonatomic) BOOL isWalpaperChanged;
@property (assign, nonatomic) BOOL isAvatarChanged;
@property (copy, nonatomic) NSString *aboutMe;
@property (strong, nonatomic) NSDictionary* descrAboutMeSizes;
@property (assign, nonatomic) NSInteger privacyOn;
@property (assign, nonatomic) NSInteger privacyPlace;
@property (assign, nonatomic) NSInteger privacyInterest;
@property (assign, nonatomic) NSInteger privacyImpressions;
@property (assign, nonatomic) NSInteger privacyProfession;
@property (assign, nonatomic) BOOL isConnection;
@property (strong, nonatomic) UIImage *userPhoto;
@property (strong, nonatomic) UIImage *userWalpaper;
@property (strong, nonatomic) UIImage *userFlag;
@property (assign, nonatomic) BOOL needUpdate;

+ (TIMLocalUserInfo *)sharedInstance;
- (BOOL)readUserFromUserDefaults;
- (void)saveUserInfoInUserDefaults;
- (void)loadSettingsWithCompletition:(void(^)(NSError *error, id response))completitionBlock;
- (void)saveSettingsWithCompletition:(void(^)(NSError *error, id response))completitionBlock;
- (void)setCountry:(NSString *)country;
- (NSString *)country;
- (void)deleteLocalUser;
- (void)connected;
- (BOOL)isInterestExist:(NSString*)interest;
- (BOOL)isProfessionExist:(NSString*)profession;
- (NSString*)professionText;
- (NSString*)interestsText;
- (NSString*)privacyString:(NSInteger)type;

@end

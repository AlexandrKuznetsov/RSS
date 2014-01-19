//
//  TIMLocalUserInfo.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 19.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TIMLocalUserInfo : NSObject

@property (strong, nonatomic) NSMutableDictionary *user;


@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *surname;
@property (strong, nonatomic) NSString *birthday;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *defaultLanguage;
@property (strong, nonatomic) NSDictionary *country;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *interests;
@property (strong, nonatomic) NSString *profession;
@property (strong, nonatomic) NSString *aboutMe;

@property (strong, nonatomic) UIImage *userPhoto;
@property (strong, nonatomic) UIImage *userWalpaper;
@property (strong, nonatomic) UIImage *userFlag;


+ (TIMLocalUserInfo *)sharedInstance;
- (BOOL)readUserFromUserDefaults;
- (void)saveUserInfoInUserDefaults;

@end

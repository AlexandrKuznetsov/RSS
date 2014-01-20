//
//  TIMRegistrationModel.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 17.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIMLocalUserInfo.h"
#import "TIMAPIRequests.h"

@interface TIMRegistrationModel : NSObject

+ (TIMRegistrationModel *)sharedInstance;
- (void)registerRequestWithCompletition:(void(^)(NSString *errorDescription, BOOL status))completition;
@property (nonatomic, copy) void (^loadCompletionBlock)(NSString *errorDescription, BOOL status);
@property (nonatomic, copy) void (^loadDataBlock)(NSArray *data, BOOL status, NSString *error);

- (void)saveLogin:(NSString *)loginEmail
         password:(NSString *)password;

- (void)saveName:(NSString *)aName
         surname:(NSString *)aSurname
        birthday:(NSString *)aBirthday
          gender:(NSString *)aGender
        language:(NSString *)aLanguage
    profilePhoto:(UIImage *)aPhoto;

- (void)saveInterests:(NSArray *)anIntersts
           profession:(NSString *)profession
                about:(NSString *)about;

- (void)saveCountry:(NSDictionary *)aCountry
               city:(NSString *)aCity;

- (void)loadProfessionsWithCompletition:(void(^)(NSArray *data, BOOL status, NSString *error))completitionBlock;
- (void)loadInterestsWithCompletition:(void(^)(NSArray *data, BOOL status, NSString *error))completitionBlock;
- (NSString *)stringFromInterestsArray:(NSArray *)array;

@end

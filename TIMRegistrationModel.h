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

@end

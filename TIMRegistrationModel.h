//
//  TIMRegistrationModel.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 17.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIMLocalUserInfo.h"

@interface TIMRegistrationModel : NSObject

+ (TIMRegistrationModel *)sharedInstance;

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

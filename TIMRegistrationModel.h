//
//  TIMRegistrationModel.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 17.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@end

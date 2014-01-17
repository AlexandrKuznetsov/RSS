//
//  NSString+CheckData.m
//  TrueIMPRESSION
//
//  Created by fist on 1/12/14.
//  Copyright (c) 2014 Impression. All rights reserved.
//


#import "NSObject+CheckData.h"


@implementation NSObject (CheckData)

- (NSString*)checkFirsStepRegistration:(NSString*)mail
                             pass:(NSString*)pass
                   andConfirmPass:(NSString*)confirmPass{

    if (![self isStringNotEmpty:mail]) {
        return @"Поле email обязательно для заполнения";
    }
    if (![self isStringNotEmpty:pass]) {
        return @"Поле пароль обязательно для заполнения";
    }
    if (![self isStringNotEmpty:confirmPass]) {
        return @"Поле \"Подтвердите пароль\" обязательно для заполнения";
    }
    if (![self isValidMail:mail]) {
         return @"Неверно указана почта";
    }
    if (![self isPassword:(NSString*)pass equalToConfirmPassword:confirmPass]) {
        return @"Пароли не совпадают";
    }
    return nil;
}

- (NSString *)checkName:(NSString *)aName
                surname:(NSString *)aSurname
               birthday:(NSString *)aBirthday
                 gender:(NSString *)aGender {
    if (![self isStringNotEmpty:aName]) {
        return @"Имя не может быть пустым";
    }
    if (![self isStringNotEmpty:aSurname]) {
        return @"Поле фамилии не может быть пустым";
    }
    if (![self isStringNotEmpty:aBirthday]) {
        return @"Дата рождения обязательна для заполнения";
    }
    if (![self isStringNotEmpty:aGender]) {
        return @"Пол обязателен для заполнения";
    }
    return nil;
}


- (NSString *)checkCity:(NSString *)aCity
                country:(NSString *)aCountry {
    if (![self isStringNotEmpty:aCity]) {
        return @"Поле города не может быть пустым";
    }
    if (![self isStringNotEmpty:aCountry]) {
        return @"Поле страны не может быть пустым";
    }
    return nil;
}


- (BOOL)isValidMail:(NSString*)mail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:mail];
}

- (BOOL)isPassword:(NSString*)pass equalToConfirmPassword:(NSString*)confirmPassword{
    if (![pass isEqualToString:confirmPassword]) {
        return NO;
    }
    return YES;
}

- (BOOL)isStringNotEmpty:(NSString*)string{
    if (string.length > 0) {
        return YES;
    }
    return NO;
}

@end

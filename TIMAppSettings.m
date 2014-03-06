//
//  TIMAppSettings.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 04.02.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMAppSettings.h"

@implementation TIMAppSettings

+ (instancetype)parseResponse:(id)response {
    TIMAppSettings *appSettings = [[TIMAppSettings alloc] init];
    appSettings.facebook = [appSettings nonEmptyObjectFromResponse:response forKey:@"socialFacebook"];
    appSettings.google = [appSettings nonEmptyObjectFromResponse:response forKey:@"socialGoogle"];
    appSettings.odnoklassniki = [appSettings nonEmptyObjectFromResponse:response forKey:@"socialOk"];
    appSettings.twitter = [appSettings nonEmptyObjectFromResponse:response forKey:@"socialTwitter"];
    appSettings.vk = [appSettings nonEmptyObjectFromResponse:response forKey:@"socialVk"];
    appSettings.notifications = [appSettings nonEmptyObjectFromResponse:response forKey:@"pushNotifications"];
    appSettings.mails = [appSettings nonEmptyFromResponse:response forKey:@"emailNotifications"];
    appSettings.search = [appSettings nonEmptyFromResponse:response forKey:@"defaultSearchType"];
    appSettings.sync = [appSettings nonEmptyFromResponse:response forKey:@"syncType"];
    return appSettings;
}

- (BOOL)nonEmptyObjectFromResponse:(id)response forKey:(NSString *)key {
    if (![[response objectForKey:key] isKindOfClass:[NSNull class]]) {
        return [[response objectForKey:key] boolValue];
    } else {
        return NO;
    }
}

- (id)nonEmptyFromResponse:(id)response forKey:(NSString *)key {
    if (![[response objectForKey:key] isKindOfClass:[NSNull class]]) {
        return [response objectForKey:key];
    } else {
        return nil;
    }
}


@end

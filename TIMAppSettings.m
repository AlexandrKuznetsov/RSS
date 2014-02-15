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
    appSettings.facebook = [appSettings nonEmptyObjectFromResponse:response forKey:@"social_facebook"];
    appSettings.google = [appSettings nonEmptyObjectFromResponse:response forKey:@"social_google"];
    appSettings.odnoklassniki = [appSettings nonEmptyObjectFromResponse:response forKey:@"social_ok"];
    appSettings.twitter = [appSettings nonEmptyObjectFromResponse:response forKey:@"social_twitter"];
    appSettings.vk = [appSettings nonEmptyObjectFromResponse:response forKey:@"social_vk"];
    appSettings.notifications = [appSettings nonEmptyObjectFromResponse:response forKey:@"push_notifications"];
    appSettings.mails = [appSettings nonEmptyFromResponse:response forKey:@"email_notifications"];
    appSettings.language = [appSettings nonEmptyFromResponse:response forKey:@"default_language"];
    appSettings.search = [appSettings nonEmptyFromResponse:response forKey:@"default_search_type"];
    appSettings.sync = [appSettings nonEmptyFromResponse:response forKey:@"sync_type"];
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

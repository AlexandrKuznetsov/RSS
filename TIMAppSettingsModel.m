//
//  TIMAppSettingsModel.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 04.02.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMAppSettingsModel.h"

@implementation TIMAppSettingsModel

static TIMAppSettingsModel *sharedInstance = nil;

+ (TIMAppSettingsModel *)sharedInstance{
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        self.needUpdate = YES;
    }
    return self;
}

- (void)loadSettingsWithCompletition:(void(^)(NSError *error, id response))completitionBlock{
    self.loadDataBlock = completitionBlock;
    NSDictionary* someData = [TIMKeychain load:KEYCHAIN_SERVICE];
    
    [[[TIMAPIRequests sharedManager] client1] postPath:@"/api/app_settings" parameters:someData success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (![operation.responseString hasPrefix:@"ERROR"]) {
            NSError* jsonError;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonError];
            if (!jsonError) {
                self.loadDataBlock(nil, [self parseResponse:dict]);
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

- (void)saveSettingsWithCompletition:(void (^)(NSError *, id))completitionBlock {
    self.loadDataBlock = completitionBlock;
    NSDictionary* someData = [TIMKeychain load:KEYCHAIN_SERVICE];
    NSMutableDictionary* allDAtaDict = [NSMutableDictionary
                                        dictionaryWithDictionary:[self userSettingDictionary]];
    [allDAtaDict setValuesForKeysWithDictionary:someData];
    [[[TIMAPIRequests sharedManager] client1] postPath:@"/api/update_app_settings" parameters:allDAtaDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (![operation.responseString hasPrefix:@"ERROR"]) {
            self.loadDataBlock(nil, nil);
        } else {
            self.loadDataBlock([NSError trueErrorWithServerResponseString:operation.responseString], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.loadDataBlock(error, nil);
    }];
}

- (void)changePasswordWithCompletition:(void (^)(NSError *, id))completitionBlock {
    self.loadDataBlock = completitionBlock;
    NSDictionary* someData = [TIMKeychain load:KEYCHAIN_SERVICE];
    NSMutableDictionary* allDAtaDict = [NSMutableDictionary
                                        dictionaryWithDictionary:@{@"new_password": self.passNew
                                                                   }];
    [allDAtaDict setValuesForKeysWithDictionary:someData];
    [[[TIMAPIRequests sharedManager] client1] postPath:@"/api/update_password" parameters:allDAtaDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (![operation.responseString hasPrefix:@"ERROR"]) {
            self.loadDataBlock(nil, nil);
        } else {
            self.loadDataBlock([NSError trueErrorWithServerResponseString:operation.responseString], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.loadDataBlock(error, nil);
    }];
}

- (NSDictionary*)userSettingDictionary{
    NSDictionary* userDictionary = @{@"push_notifications": @(self.pushEnabled),
                                     @"social_facebook": @(self.fbEnabled),
                                     @"social_vk": @(self.VkEnabled),
                                     @"social_ok": @(self.odniklEnabled),
                                     @"social_google": @(self.googleEnabled),
                                     @"social_twitter": @(self.twitterEnabled),
                                     @"email_notifications" : self.mails,
                                     @"default_language" : @"ru",
                                     @"default_search_type" : self.search,
                                     @"sync_type" : self.sync
                                     };
    
    return userDictionary;
}


- (id)parseResponse:(id)response {
    return [TIMAppSettings parseResponse:response];
}

@end

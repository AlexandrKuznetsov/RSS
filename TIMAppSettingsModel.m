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
    [[[TIMAPIRequests sharedManager] client1] getPath:@"/api/settings" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (![operation.responseString hasPrefix:@"ERROR"]) {
            NSError* jsonError;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonError];
            if (!jsonError) {
                self.loadDataBlock(nil, [self parseResponse:dict[@"data"]]);
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
    NSMutableDictionary* allDAtaDict = [NSMutableDictionary
                                        dictionaryWithDictionary:[self userSettingDictionary]];
    [[[TIMAPIRequests sharedManager] client1] postPath:@"/api/settings" parameters:allDAtaDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString* newStr = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", newStr);
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
                                        dictionaryWithDictionary:@{@"newPassword": self.passNew
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
    NSDictionary* userDictionary = @{@"pushNotifications": @(self.pushEnabled),
                                     @"socialFacebook": @(self.fbEnabled),
                                     @"socialVk": @(self.VkEnabled),
                                     @"socialOk": @(self.odniklEnabled),
                                     @"socialGoogle": @(self.googleEnabled),
                                     @"socialTwitter": @(self.twitterEnabled),
                                     @"emailNotifications" : self.mails,
                                     @"defaultSearchType" : self.search,
                                     @"syncType" : self.sync
                                     };
    
    return userDictionary;
}


- (id)parseResponse:(id)response {
    return [TIMAppSettings parseResponse:response];
}

@end

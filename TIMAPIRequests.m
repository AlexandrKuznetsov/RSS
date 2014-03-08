//
//  TIMAPIRequests.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 19.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMAPIRequests.h"
#import "TIMKeychain.h"

@implementation TIMAPIRequests

- (id)init {
    if (self = [super init]) {
        NSURL *url = [NSURL URLWithString:@"http://37.252.121.145"];
        _client1 = [[AFHTTPClient alloc] initWithBaseURL:url];
    }
    return self;
}

+ (id)sharedManager{
    static TIMAPIRequests *sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString*)server{
    return @"http://37.252.121.145";
}

- (void)postEmail:(NSString *)login
         password:(NSString *)password
 withCompletition:(void(^)(NSError *error, id response))completitionBlock {
    NSDictionary* userDataDictionary = @{@"email": login, @"password": password};
    self.loadCompletionBlock = completitionBlock;
    [TIMKeychain deleteData:KEYCHAIN_SERVICE];
    [TIMKeychain save:KEYCHAIN_SERVICE data:userDataDictionary];
    NSDictionary* dict = [TIMKeychain load:KEYCHAIN_SERVICE];
    NSLog(@"%@, %@", dict[@"email"], dict[@"password"]);
    [_client1 postPath:@"/api/login" parameters:userDataDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error = nil;
        NSDictionary* responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                           options:NSJSONReadingAllowFragments
                                                                             error:&error];
        if (!error && [responseDictionary[@"errors"] count] == 0) {
            self.loadCompletionBlock(nil, responseDictionary[@"data"]);
        } else {
            NSError* serverError = [NSError errorWithDomain:NSPOSIXErrorDomain code:kCFURLErrorBadServerResponse userInfo:nil];
            self.loadCompletionBlock(serverError, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.loadCompletionBlock(error, nil);
    }];
}

- (void)registerWithEmail:(NSString *)login
                 password:(NSString *)password
         withCompletition:(void(^)(NSError *error, id response))completitionBlock {
    NSDictionary* userDataDictionary = @{@"email": login, @"password": password};
    self.loadCompletionBlock = completitionBlock;
    [TIMKeychain deleteData:KEYCHAIN_SERVICE];
    [TIMKeychain save:KEYCHAIN_SERVICE data:userDataDictionary];
    [_client1 postPath:@"/api/register" parameters:userDataDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString* newStr = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", newStr);
        if ([operation.responseString hasPrefix:@"OK"]) {
            self.loadCompletionBlock(nil, responseObject);
        } else {
            self.loadCompletionBlock([NSError trueErrorWithServerResponseString:operation.responseString],nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.loadCompletionBlock(error, nil);
    }];
}

- (void)loadProfessionsWithCompletition:(void(^)(NSError *error, id response))completitionBlock {
    self.loadCompletionBlock = completitionBlock;
    [_client1 getPath:@"/profession" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSError* jsonError;
            NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonError];
        NSArray* errorArray = jsonArray[@"error"];
        if ([errorArray count] < 1) {
            if (!jsonError) {
                self.loadCompletionBlock(nil, jsonArray[@"data"][@"list"]);
            }else{
                self.loadCompletionBlock(jsonError, nil);
            }
        } else {
            self.loadCompletionBlock([NSError trueErrorWithServerResponseString:operation.responseString], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.loadCompletionBlock(error, nil);
    }];
}


- (void)loadInterestsWithCompletition:(void(^)(NSError *error, id response))completitionBlock {
    self.loadCompletionBlock = completitionBlock;
    [_client1 getPath:@"/interest" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSError* jsonError;
            NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonError];
        NSArray* errorArray = jsonArray[@"error"];
        if ([errorArray count] < 1) {
            if (!jsonError) {
                NSArray* responseArray = jsonArray[@"data"][@"list"];
                self.loadCompletionBlock(nil, responseArray);
            }else{
                self.loadCompletionBlock(jsonError, nil);
            }
        } else {
            self.loadCompletionBlock([NSError trueErrorWithServerResponseString:operation.responseString], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.loadCompletionBlock(error, nil);
    }];
}


- (void)loadStatisticsWithCompletition:(void(^)(NSError *error, id response))completitionBlock {
    self.loadCompletionBlock = completitionBlock;
    [_client1 getPath:@"/api/stats" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (![operation.responseString hasPrefix:@"ERROR"]) {
            NSError* jsonError;
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonError];
            if (!jsonError) {
                self.loadCompletionBlock(nil, jsonDictionary);
            }else{
                self.loadCompletionBlock(jsonError, nil);
            }
        } else {
            self.loadCompletionBlock([NSError trueErrorWithServerResponseString:operation.responseString], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.loadCompletionBlock(error, nil);
    }];
}


- (void)sendPasswordOnMail:(NSString *)mail withCompletition:(void(^)(NSError *error, id response))completitionBlock {
    self.loadCompletionBlock = completitionBlock;
    [_client1 postPath:@"/users/password" parameters:@{@"user[email]": mail} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([operation.responseString hasPrefix:@"OK"]) {
            self.loadCompletionBlock(nil, responseObject);
        } else {
            self.loadCompletionBlock([NSError trueErrorWithServerResponseString:operation.responseString],nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.loadCompletionBlock(error, nil);
    }];
}

@end

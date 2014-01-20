//
//  TIMAPIRequests.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 19.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMAPIRequests.h"

@implementation TIMAPIRequests

- (id)init {
    if (self = [super init]) {
        NSURL *url = [NSURL URLWithString:@"http://true-impressions.com/"];
        _client1 = [[AFHTTPClient alloc] initWithBaseURL:url];
    }
    return self;
}

+ (id)sharedManager{
    static TIMAPIRequests *sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[super alloc] init];
    });
    return sharedInstance;
}

- (void)postEmail:(NSString *)login
         password:(NSString *)password
 withCompletition:(void(^)(NSError *error, id response))completitionBlock {
    self.loadCompletionBlock = completitionBlock;
    [_client1 postPath:@"/api/login" parameters:@{@"email": login, @"password": password} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", operation.response.allHeaderFields);
        if ([operation.responseString hasPrefix:@"OK"]) {
            self.loadCompletionBlock(nil, responseObject);
        } else {
            self.loadCompletionBlock([NSError trueErrorWithServerResponseString:operation.responseString],nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.loadCompletionBlock(error, nil);
    }];
}

- (void)registerWithEmail:(NSString *)login
                 password:(NSString *)password
         withCompletition:(void(^)(NSError *error, id response))completitionBlock {
    self.loadCompletionBlock = completitionBlock;
    [_client1 postPath:@"/api/register" parameters:@{@"email": login, @"password": password} success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    [_client1 getPath:@"/professions.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (![operation.responseString hasPrefix:@"ERROR"]) {
            NSError* jsonError;
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonError];
            if (!jsonError) {
                self.loadCompletionBlock(nil, jsonArray);
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



@end

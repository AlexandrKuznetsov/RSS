//
//  TIMAPIRequests.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 19.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Reachability.h"
#import "NSError+True.h"

@interface TIMAPIRequests : NSObject {
}

@property (strong, nonatomic) AFHTTPClient *client1;

@property (nonatomic, copy) void (^loadCompletionBlock)(NSError *error, id JSON);

+ (id)sharedManager;

- (void)loadStatisticsWithCompletition:(void(^)(NSError *error, id response))completitionBlock;

- (void)postEmail:(NSString *)login
         password:(NSString *)password
 withCompletition:(void(^)(NSError *error, id response))completitionBlock;

- (void)registerWithEmail:(NSString *)login
                 password:(NSString *)password
         withCompletition:(void(^)(NSError *error, id response))completitionBlock;

- (void)sendPasswordOnMail:(NSString *)mail
          withCompletition:(void(^)(NSError *error, id response))completitionBlock;

- (void)loadProfessionsWithCompletition:(void(^)(NSError *error, id response))completitionBlock;
- (void)loadInterestsWithCompletition:(void(^)(NSError *error, id response))completitionBlock;
- (BOOL)connected;

@end

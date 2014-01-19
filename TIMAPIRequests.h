//
//  TIMAPIRequests.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 19.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "NSError+True.h"

@interface TIMAPIRequests : NSObject {
    AFHTTPClient *_client;
}

@property (nonatomic, copy) void (^loadCompletionBlock)(NSError *error, id JSON);

- (void)postEmail:(NSString *)login
         password:(NSString *)password
 withCompletition:(void(^)(NSError *error, id response))completitionBlock;

@end

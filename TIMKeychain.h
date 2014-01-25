//
//  TIMKeychain.h
//  TrueIMPRESSION
//
//  Created by fist on 1/25/14.
//  Copyright (c) 2014 Impression. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface TIMKeychain : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteData:(NSString *)service;

@end

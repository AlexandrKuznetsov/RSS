//
//  TIMAppSettingsModel.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 04.02.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIMKeychain.h"
#import "TIMAPIRequests.h"
#import "TIMAppSettings.h"

@interface TIMAppSettingsModel : NSObject

@property BOOL pushEnabled;
@property BOOL fbEnabled;
@property BOOL VkEnabled;
@property BOOL odniklEnabled;
@property BOOL googleEnabled;
@property BOOL twitterEnabled;
@property BOOL needUpdate;
@property (strong, nonatomic) NSNumber *mails;
@property (strong, nonatomic) NSNumber *language;
@property (strong, nonatomic) NSNumber *sync;
@property (strong, nonatomic) NSNumber *search;

@property (strong, nonatomic) NSString *passNew;

+ (TIMAppSettingsModel *)sharedInstance;
- (void)loadSettingsWithCompletition:(void(^)(NSError *error, id response))completitionBlock;
- (void)saveSettingsWithCompletition:(void(^)(NSError *error, id response))completitionBlock;
- (void)changePasswordWithCompletition:(void (^)(NSError *, id))completitionBlock;
@property (nonatomic, copy) void(^loadDataBlock)(NSError *error, id response);

@end

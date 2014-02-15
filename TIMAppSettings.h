//
//  TIMAppSettings.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 04.02.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TIMAppSettings : NSObject

@property (assign, nonatomic) BOOL facebook;
@property (assign, nonatomic) BOOL google;
@property (assign,nonatomic) BOOL odnoklassniki;
@property (assign, nonatomic) BOOL twitter;
@property (assign, nonatomic) BOOL vk;
@property (assign, nonatomic) BOOL notifications;
@property (strong, nonatomic) NSNumber *mails;
@property (strong, nonatomic) NSNumber *language;
@property (strong, nonatomic) NSNumber *sync;
@property (strong, nonatomic) NSNumber *search;

+ (instancetype)parseResponse:(id)response;

@end

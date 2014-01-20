//
//  TIMStatisticsModel.h
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 20.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIMStatistic.h"
#import "TIMAPIRequests.h"

@interface TIMStatisticsModel : NSObject

@property (nonatomic, copy) void (^loadDataBlock)(TIMStatistic *data, BOOL status, NSString *error);

- (void)loadStatisticWithCompletition:(void(^)(TIMStatistic *data, BOOL status, NSString *error))completition;

@end

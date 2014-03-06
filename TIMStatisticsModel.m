//
//  TIMStatisticsModel.m
//  TrueIMPRESSION
//
//  Created by Vdovichenko Dmitry on 20.01.14.
//  Copyright (c) 2014 Impression. All rights reserved.
//

#import "TIMStatisticsModel.h"

@implementation TIMStatisticsModel

- (void)loadStatisticWithCompletition:(void(^)(TIMStatistic *data, BOOL status, NSString *error))completition {
    self.loadDataBlock = completition;
    [[TIMAPIRequests sharedManager] loadStatisticsWithCompletition:^(NSError *error, id response) {
        if (error) {
            if ((error.code == NSURLErrorNotConnectedToInternet) || (error.code == NSURLErrorTimedOut)) {
                self.loadDataBlock(nil, NO, @"Отсутствует интернет подключение!");
            } else {
                self.loadDataBlock(nil,NO,@"Ошибка при загрузке");
            }
        } else {
            self.loadDataBlock([self parseResponse:response], YES, nil);
        }
    }];
}

- (TIMStatistic *)parseResponse:(NSDictionary *)response {
    TIMStatistic *statistic = [[TIMStatistic alloc] init];
    statistic.users = [response [@"data"][@"users"] integerValue];
    statistic.locations = [response [@"data"][@"locations"] integerValue];
    statistic.impressions = [response [@"data"][@"impressions"] integerValue];
    return statistic;
}

@end

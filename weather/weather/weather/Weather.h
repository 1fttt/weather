//
//  Weather.h
//  weather
//
//  Created by 房彤 on 2020/8/6.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Weather : NSObject

@property NSString *cityNameStr;
@property NSString *cityWeatherStr;
@property NSString *cityTemperatureStr;

@property NSString *todayStr;
@property NSString *today;
@property NSString *todayHighTempStr;
@property NSString *todayLowTempStr;

@property NSMutableArray *weekArr;

@property NSMutableArray *hourArr;
@property NSMutableArray *hourImageViewArr;
@property NSMutableArray *hourTempArr;

@property NSString *str;

@property NSString *leftTitleStr;
@property NSString *rightTitleStr;
@property NSString *leftContentStr;
@property NSString *rightContentStr;

@property NSMutableArray *leftArr;
@property NSMutableArray *rightArr;


@end

NS_ASSUME_NONNULL_END

//
//  FirstTableViewCell.h
//  weather
//
//  Created by 房彤 on 2020/8/4.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstTableViewCell : UITableViewCell

//city
@property UILabel *cityNameLabel;
@property UILabel *cityWeatherLabel;
@property UILabel *cityTemperatureLabel;

@property UILabel *todayLabel;

//today
@property UILabel *weekLabel;
@property UIImageView *weatherViewImage;
@property UILabel *highTemperatureLabel;
@property UILabel *lowTemperatureLabel;

@property UIScrollView *scrollView;

@property UILabel *Label;
@property UILabel *label;

@property UILabel *leftTitleLabel;
@property UILabel *rightTitleLabel;
@property UILabel *leftContentLabel;
@property UILabel *rightContentLabel;

@end

NS_ASSUME_NONNULL_END

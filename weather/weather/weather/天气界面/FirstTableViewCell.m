//
//  FirstTableViewCell.m
//  weather
//
//  Created by 房彤 on 2020/8/4.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "FirstTableViewCell.h"


@implementation FirstTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
    if([self.reuseIdentifier isEqualToString:@"cityWeather"]) {
        
        _cityNameLabel = [[UILabel alloc] init];
        _cityWeatherLabel = [[UILabel alloc] init];
        _cityTemperatureLabel = [[UILabel alloc] init];
        
        
        [self.contentView addSubview:_cityNameLabel];
        [self.contentView addSubview:_cityWeatherLabel];
        [self.contentView addSubview:_cityTemperatureLabel];
       
    } else if([self.reuseIdentifier isEqualToString:@"todayWeather"]) {
        
        _weekLabel = [[UILabel alloc] init];
        _todayLabel = [[UILabel alloc] init];
        _highTemperatureLabel = [[UILabel alloc] init];
        _lowTemperatureLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_weekLabel];
        [self.contentView addSubview:_todayLabel];
        [self.contentView addSubview:_highTemperatureLabel];
        [self.contentView addSubview:_lowTemperatureLabel];
               
        
    } else if([self.reuseIdentifier isEqualToString:@"scrollerView"]) {
        _scrollView = [[UIScrollView alloc] init];
        [self.contentView addSubview:_scrollView];
        
        
        
    } else if([self.reuseIdentifier isEqualToString:@"weekWeather"]) {
        
        _weekLabel = [[UILabel alloc] init];
        _weatherViewImage = [[UIImageView alloc] init];
        _highTemperatureLabel = [[UILabel alloc] init];
        _lowTemperatureLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_weekLabel];
        [self.contentView addSubview:_weatherViewImage];
        [self.contentView addSubview:_highTemperatureLabel];
        [self.contentView addSubview:_lowTemperatureLabel];
        
        
    } else if([self.reuseIdentifier isEqualToString:@"label"]) {
        
        _Label = [[UILabel alloc] init];
        _label = [[UILabel alloc] init];
        [self.contentView addSubview:_Label];
        [self.contentView addSubview:_label];
        
        
    } else if([self.reuseIdentifier isEqualToString:@"content"]) {
        
        _leftTitleLabel = [[UILabel alloc] init];
        _rightTitleLabel = [[UILabel alloc] init];
        _leftContentLabel = [[UILabel alloc] init];
        _rightContentLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_leftTitleLabel];
        [self.contentView addSubview:_rightTitleLabel];
        [self.contentView addSubview:_leftContentLabel];
        [self.contentView addSubview:_rightContentLabel];
        
    }
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    _cityNameLabel.frame = CGRectMake(107, 65, 200, 67);
    _cityWeatherLabel.frame = CGRectMake(132, 128, 150, 30);
    _cityTemperatureLabel.frame = CGRectMake(107, 168, 200, 110);
    
    _cityNameLabel.textAlignment = NSTextAlignmentCenter;
    _cityWeatherLabel.textAlignment = NSTextAlignmentCenter;
    _cityTemperatureLabel.textAlignment = NSTextAlignmentCenter;
    
    _cityNameLabel.font = [UIFont systemFontOfSize:45];
    _cityWeatherLabel.font = [UIFont systemFontOfSize:19];
    _cityTemperatureLabel.font = [UIFont fontWithName:@"Heiti SC" size:110];
    //Heiti SC  Hiragino Maru Gothic ProN    Heiti TC
    
    _cityNameLabel.textColor = [UIColor colorWithWhite:0.96 alpha:1];
    _cityWeatherLabel.textColor = [UIColor colorWithWhite:0.84 alpha:1];
    _cityTemperatureLabel.textColor = [UIColor colorWithWhite:0.93 alpha:1];
    
    //星期
    _weekLabel.frame = CGRectMake(20, 5, 80, 35);
    _todayLabel.frame = CGRectMake(107, 7, 40, 35);
    _weatherViewImage.frame = CGRectMake(170, 3, 43, 43);
    _highTemperatureLabel.frame = CGRectMake(293, 5, 45, 35);
    _lowTemperatureLabel.frame = CGRectMake(360, 5, 45, 35);
    
    _weekLabel.font = [UIFont systemFontOfSize:23];
    _todayLabel.font = [UIFont systemFontOfSize:19];
    _highTemperatureLabel.font = [UIFont systemFontOfSize:23];
    _lowTemperatureLabel.font = [UIFont systemFontOfSize:23];
    
    
    _weekLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
    _todayLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
    _highTemperatureLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
    _lowTemperatureLabel.textColor = [UIColor colorWithWhite:0.68 alpha:1];
    
    //小时
    _scrollView.frame = CGRectMake(0, 0, 414, 120);
    _scrollView.backgroundColor = [UIColor clearColor];
    
    
    _Label.frame = CGRectMake(20, 10, 390, 37);
    _label.frame = CGRectMake(20, 40, 390, 37);
    _Label.font = [UIFont systemFontOfSize:20.3];
    _label.font = [UIFont systemFontOfSize:20.3];
    
    _Label.textColor = [UIColor colorWithWhite:0.96 alpha:1];
    _label.textColor = [UIColor colorWithWhite:0.96 alpha:1];
    
    
    _leftTitleLabel.frame = CGRectMake(20, 9, 80, 12);
    _rightTitleLabel.frame = CGRectMake(210, 9, 80, 12);
    _leftContentLabel.frame = CGRectMake(20, 23, 190, 60);
    _rightContentLabel.frame = CGRectMake(210, 23, 190, 60);
    
    _leftContentLabel.font = [UIFont systemFontOfSize:30];
    _rightContentLabel.font = [UIFont systemFontOfSize:30];
    
    
    _leftTitleLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1];
    _rightTitleLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1];
    _leftContentLabel.textColor = [UIColor colorWithWhite:0.94 alpha:1];
    _rightContentLabel.textColor = [UIColor colorWithWhite:0.94 alpha:1];

    
 
}





@end

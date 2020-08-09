//
//  CityTableViewCell.m
//  weather
//
//  Created by 房彤 on 2020/8/4.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "CityTableViewCell.h"


@implementation CityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _cityLabel = [[UILabel alloc] init];
    _timeLabel = [[UILabel alloc] init];
    _temperatureLabel = [[UILabel alloc] init];
    
    [self.contentView addSubview:_cityLabel];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_temperatureLabel];
    
    return self;
}

- (void)layoutSubviews {
    _cityLabel.frame = CGRectMake(30, 40, 200, 60);
    _cityLabel.font = [UIFont systemFontOfSize:40];
    _cityLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    _timeLabel.frame = CGRectMake(30, 16, 100, 29);
    _timeLabel.font = [UIFont systemFontOfSize:18];
    _timeLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    _temperatureLabel.frame = CGRectMake(300, 18, 110, 80);
    _temperatureLabel.font = [UIFont fontWithName:@"Heiti SC" size:63];
    _temperatureLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
}


@end

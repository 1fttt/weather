//
//  FirstViewController.m
//  weather
//
//  Created by 房彤 on 2020/8/4.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "FirstViewController.h"
#import "CityViewController.h"
#import "FirstTableViewCell.h"
#import "WeekWeather.h"

@interface FirstViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, NSURLSessionDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];

    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bj8.jpg"]];
    [self.view addSubview:_scrollView];

    [self.view addSubview:_pageControl];
//    _pageControl.currentPage = _scrollView.contentOffset.x / 414;
    [_pageControl addTarget:self action:@selector(pressChangePage:) forControlEvents:UIControlEventValueChanged];
    
    
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(357, 830, 37, 37);
    [_addButton setImage:[UIImage imageNamed:@"gengduo1.png"] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(pressCity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addButton];
    
    
    for(int i = 0; i < _weatherArray.count; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(i * 414, 0, 414, 820) style:UITableViewStylePlain];
        [self.scrollView addSubview:tableView];
        tableView.backgroundColor = [UIColor clearColor];
        [tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"cityWeather"];
        [tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"todayWeather"];
       // [tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"scrollerView"];
        [tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"weekWeather"];
        [tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"label"];
        [tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"content"];
        tableView.tag = i;
        tableView.delegate = self;
        tableView.dataSource = self;
    }
//    _isBegin = 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 14;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        return 290;
    } else if(indexPath.row == 2) {
        return 120;
    } else if((indexPath.row > 2 && indexPath.row < 9) || indexPath.row == 1) {
        return 50;
    } else if(indexPath.row == 9) {
        return 90;
    } else {
        return 90;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    for(int i = 0; i < _weatherArray.count; i++) {
        if(tableView.tag == i) {
            Weather *weather = [[Weather alloc] init];
            weather = _weatherArray[i];
            if(indexPath.row == 0) {
                FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityWeather" forIndexPath:indexPath];
                
                cell.cityNameLabel.text = weather.cityNameStr;
                NSLog(@"%@", cell.cityNameLabel.text);
                cell.cityWeatherLabel.text = weather.cityWeatherStr;
                cell.cityTemperatureLabel.text = weather.cityTemperatureStr;
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];
                return cell;
            
            }
    
            if(indexPath.row == 1) {
                FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todayWeather" forIndexPath:indexPath];
                cell.weekLabel.text = weather.todayStr;
                cell.todayLabel.text = weather.today;
                cell.highTemperatureLabel.text = weather.todayHighTempStr;
                cell.lowTemperatureLabel.text = weather.todayLowTempStr;
                cell.backgroundColor = [UIColor clearColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            if(indexPath.row == 2) {
            
                FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scrollerView"];
                if (cell == nil) {
                    cell = [[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"scrollerView"];
                   
                    for(int i = 0; i < weather.hourArr.count; i++) {
                        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25 + i * 81, 10, 50, 30)];
                      
                        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:weather.hourImageViewArr[i]]];
                        imageView.frame = CGRectMake(20 + i * 81, 40, 50, 40);
                        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(33 + i * 81, 75, 50, 30)];
                        
                        label.text = weather.hourArr[i];
                        tempLabel.text = weather.hourTempArr[i];
                        
                        label.textColor = [UIColor colorWithWhite:0.9 alpha:1];
                        tempLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
                        [cell.scrollView addSubview:label];
                        [cell.scrollView  addSubview:imageView];
                        [cell.scrollView addSubview:tempLabel];
                        
                }
                    
                      
                cell.scrollView.contentSize = CGSizeMake(weather.hourArr.count * 83 , 120);
                
                cell.backgroundColor = [UIColor clearColor];
                
                }
            
                return cell;
            }
            if(indexPath.row > 2 && indexPath.row < 9) {
                FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weekWeather" forIndexPath:indexPath];
                WeekWeather *weekWeather = [[WeekWeather alloc] init];
                weekWeather = weather.weekArr[indexPath.row - 3];
                
                cell.weekLabel.text = weekWeather.weekStr;
                
                cell.weatherViewImage.image = [UIImage imageNamed:weekWeather.weatherViewImage];
                cell.highTemperatureLabel.text = weekWeather.highTemperatureStr;
                cell.lowTemperatureLabel.text = weekWeather.lowTemperatureStr;
            
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];
                return cell;
            }
            
            if(indexPath.row == 9) {
                FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"label" forIndexPath:indexPath];
                NSString *str = [NSString stringWithFormat:@"今天：今日%@。当前温度%@;", weather.cityWeatherStr, weather.cityTemperatureStr];
                NSString *str1 = [NSString stringWithFormat:@"最高气温%@。", weather.todayHighTempStr];
                cell.Label.text = str;
                cell.label.text = str1;
                cell.backgroundColor = [UIColor clearColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                
            }
            if(indexPath.row > 9) {
                NSArray *leftArr = @[@"日出", @"气压", @"风速",  @"能见度"];
                NSArray *rightArr = @[@"日落", @"湿度", @"风速等级", @"空气质量"];
                FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"content" forIndexPath:indexPath];
                cell.leftTitleLabel.text = leftArr[indexPath.row - 10];
                cell.rightTitleLabel.text = rightArr[indexPath.row - 10];
                cell.leftContentLabel.text = weather.leftArr[indexPath.row - 10];
                cell.rightContentLabel.text = weather.rightArr[indexPath.row - 10];
                cell.backgroundColor = [UIColor clearColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                
            }
            

        }
    }
    return [tableView dequeueReusableCellWithIdentifier:@"weekWeather" forIndexPath:indexPath];

}




- (void)pressChangePage:(UIPageControl *)pageControl {
    _scrollView.contentOffset = CGPointMake(pageControl.currentPage * 414, 0) ;
}

- (void)pressCity {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLayoutSubviews {
    _isBegin = 1;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.isBegin != 0) {
        int pages = scrollView.contentOffset.x / 414;
        self.pageControl.currentPage = pages;
    }
    
}








@end

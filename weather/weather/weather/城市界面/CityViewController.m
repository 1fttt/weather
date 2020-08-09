//
//  CityViewController.m
//  weather
//
//  Created by 房彤 on 2020/8/4.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "CityViewController.h"
#import "CityTableViewCell.h"
#import "SearchViewController.h"
#import "Weather.h"
#import "WeekWeather.h"
#import "FirstViewController.h"

@interface CityViewController ()<UITableViewDelegate, UITableViewDataSource, PassValueDelegate, NSURLSessionDelegate>

@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bj10.jpg"]];
    
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(352, 820, 37, 37);
    [_addButton setImage:[UIImage imageNamed:@"jiahao2.png"] forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(pressAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addButton];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 414, 820) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    [_tableView registerClass:[CityTableViewCell class] forCellReuseIdentifier:@"ft"];
    
    _cityArray = [[NSMutableArray alloc] init];
    _idArray = [[NSMutableArray alloc] init];
    _tempArr = [[NSMutableArray alloc] init];
    _weatherArray = [[NSMutableArray alloc] init];
  
}

- (void)pressAdd {
    
    SearchViewController *searchView = [[SearchViewController alloc] init];
    searchView.delegate = self;
    searchView.existCityArr = [[NSArray alloc] init];
    searchView.existCityArr = _cityArray;
    [self presentViewController:searchView animated:YES completion:nil];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _cityArray.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ft" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    cell.cityLabel.text = _cityArray[indexPath.row];
    NSLog(@"%@", cell.cityLabel.text);

    cell.timeLabel.text = [self setTime];
    cell.temperatureLabel.text = _tempArr[indexPath.row];
    cell.backgroundColor = [UIColor colorWithWhite:0.22 alpha:0.8];
    cell.layer.cornerRadius = 15;
    cell.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.8].CGColor;
    cell.layer.borderWidth = 0.4;
    
   
    return cell;
}

- (void)passContent:(NSString *)string andID:(NSString *)idStr {
   
    [_cityArray addObject:string];
    [_idArray addObject:idStr];
    [self crestURL:string];

}

- (NSString *)setTime {

    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"HH:mm"];
    NSString *dateStr;
    dateStr=[format1 stringFromDate:date];

    NSString *string = [[NSString alloc] init];
    NSLog(@"%@",dateStr);
    int hour = [dateStr intValue];
    if(hour > 12) {
        string = @"下午";
    } else {
        string = @"上午";
    }
    NSString *timeString = [NSString stringWithFormat:@"%@  %@", string, dateStr];
    return timeString;
}
//点击当前cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    FirstViewController *view = [[FirstViewController alloc] init];
    view.weatherArray = [[NSMutableArray alloc] init];
    view.weatherArray = _weatherArray;
    
    view.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(170, 830, 80, 30)];
    view.pageControl.numberOfPages = _weatherArray.count;
    view.pageControl.currentPage = indexPath.row;
   
    view.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 414, 820)];
    view.scrollView.contentSize = CGSizeMake(414 * _weatherArray.count, 820);
    view.scrollView.contentOffset = CGPointMake(414 * indexPath.row, 0);
    view.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:view animated:YES completion:nil];
   
}


- (void)crestURL:(NSString *)str {
    str = [str  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *string = [NSString stringWithFormat:@"https://yiketianqi.com/api?version=v9&city=%@&appid=42835475&appsecret=n013OP8H", str];
    
    NSLog(@"%@",str);
    //设置请求地址
    NSURL *url = [NSURL URLWithString:string];

    //创建请求类
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //创建会话
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self  delegateQueue:[NSOperationQueue mainQueue]];

    //根据会话创建任务
    NSURLSessionTask *dataTask = [session dataTaskWithRequest:request];

    //启动任务
    [dataTask resume];


}

//接收到服务器响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(nonnull NSURLResponse *)response completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler {

    if(_data == nil) {
        _data = [[NSMutableData alloc] init];
    } else {
        _data.length = 0;
    }
    completionHandler(NSURLSessionResponseAllow);

}

//接收到数据 该方法会被调用多次
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {

    //拼接data
    [_data appendData:data];

}

//数据请求完成或请求出现错误调用的方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {

    if(error == nil) {
        id dictionary = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"----%@", dictionary);
        
        
        Weather *weather = [[Weather alloc] init];
        weather.weekArr = [[NSMutableArray alloc] init];

        weather.cityNameStr = [NSString stringWithFormat:@"%@", dictionary[@"city"]];
        weather.cityWeatherStr = [NSString stringWithFormat:@"%@", dictionary[@"data"][0][@"wea"]];
        weather.cityTemperatureStr = [NSString stringWithFormat:@"%@", dictionary[@"data"][0][@"tem"]];
        
        //今日温度
        NSString *tempstr = weather.cityTemperatureStr;
        [_tempArr addObject: tempstr];
        weather.todayStr = [NSString stringWithFormat:@"%@", dictionary[@"data"][0][@"week"]];
        weather.today = [[NSString alloc] init];
        weather.today = @"今天";
        weather.todayHighTempStr = [NSString stringWithFormat:@"%@", dictionary[@"data"][0][@"tem1"]];
        weather.todayLowTempStr = [NSString stringWithFormat:@"%@", dictionary[@"data"][0][@"tem2"]];
        
        //小时温度
        weather.hourArr = [[NSMutableArray alloc] init];
        weather.hourImageViewArr = [[NSMutableArray alloc] init];
        weather.hourTempArr = [[NSMutableArray alloc] init];
        NSArray *array = dictionary[@"data"][0][@"hours"];
        for(int i = 0; i < array.count; i++) {
            [weather.hourArr addObject:array[i][@"hours"]];
            [weather.hourImageViewArr addObject:array[i][@"wea_img"]];
            [weather.hourTempArr addObject:array[i][@"tem"]];
            
            NSLog(@"%@, %@, %@", weather.hourArr[i], weather.hourImageViewArr[i], weather.hourTempArr[i]);
        }
        
        

        //六天温度
        for(int i = 0; i < 6; i++) {
            WeekWeather *weekWeather = [[WeekWeather alloc] init];
            weekWeather.weekStr = [NSString stringWithFormat:@"%@", dictionary[@"data"][i + 1][@"week"]];
            weekWeather.weatherViewImage = [NSString stringWithFormat:@"%@", dictionary[@"data"][i + 1][@"wea_img"]];
            weekWeather.highTemperatureStr = [NSString stringWithFormat:@"%@", dictionary[@"data"][i + 1][@"tem1"]];
            weekWeather.lowTemperatureStr = [NSString stringWithFormat:@"%@", dictionary[@"data"][i + 1][@"tem2"]];
            NSLog(@"%@, %@, %@, %@", weekWeather.weekStr, weekWeather.weatherViewImage,  weekWeather.highTemperatureStr, weekWeather.lowTemperatureStr);
            [weather.weekArr addObject:weekWeather];
        }
        
        //日出日落....
        weather.leftArr = [[NSMutableArray alloc] init];
        weather.rightArr = [[NSMutableArray alloc] init];
        
        
        [weather.leftArr addObject:dictionary[@"data"][0][@"sunrise"]];
        [weather.leftArr addObject:dictionary[@"data"][0][@"pressure"]];
        [weather.leftArr addObject:dictionary[@"data"][0][@"win_meter"]];
        [weather.leftArr addObject:dictionary[@"data"][0][@"visibility"]];
        
        [weather.rightArr addObject:dictionary[@"data"][0][@"sunset"]];
        [weather.rightArr addObject:dictionary[@"data"][0][@"humidity"]];
        [weather.rightArr addObject:dictionary[@"data"][0][@"win_speed"]];
        [weather.rightArr addObject:dictionary[@"data"][0][@"air"]];
        
        

        NSLog(@"%d", weather.weekArr.count);

        NSLog(@"%@, %@, %@", weather.cityNameStr, weather.cityWeatherStr, weather.cityTemperatureStr);

        [_weatherArray addObject:weather];
        [_tableView reloadData];


    }
}


@end

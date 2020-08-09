//
//  SearchViewController.m
//  weather
//
//  Created by 房彤 on 2020/8/4.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"
#import "CityViewController.h"
#import "AppDelegate.h"


@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, NSURLSessionDataDelegate, UITextFieldDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bj2.jpg"]];
    self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.86];
    _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 23, 250, 25)];
    _topLabel.text = @"请输入城市、邮政编码或机场位置";
    _topLabel.font = [UIFont systemFontOfSize:16];
    _topLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:_topLabel];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(25, 65, 318, 42)];
    [self.view addSubview:_textField];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    _textField.textColor = [UIColor colorWithWhite:0.93 alpha:1];
    _textField.placeholder = @"搜索";
    _textField.keyboardType = UIKeyboardTypeDefault;
    _textField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fangdajing.png"]];
    _textField.leftViewMode = UITextFieldViewModeAlways;
     _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _cancelButton.frame = CGRectMake(350, 68, 50, 38);
    _cancelButton.tintColor = [UIColor colorWithWhite:0.88 alpha:1];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:19.5];
    _cancelButton.backgroundColor = [UIColor clearColor];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(pressCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelButton];
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 115, 355, 720) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[SearchTableViewCell class] forCellReuseIdentifier:@"ft"];
    [self.view addSubview:_tableView];
 //   self.cityAddMuarry = [NSMutableArray array];
    
}

- (void)pressCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cityArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ft" forIndexPath:indexPath];
    
    NSString *str = [NSString stringWithString:_cityArr[indexPath.row]];
    cell.label.text = str;
    cell.label.textColor = [UIColor colorWithWhite:0.8 alpha:1];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
} 


//对textField实时监听
- (void)textFieldDidChange:(UITextField *)textField {

    NSString *str = [NSString stringWithString:[self pinyin:textField]];
    
    //设置请求地址
    //NSString *str = [NSString stringWithFormat:@"https://geoapi.heweather.net/v2/city/lookup?location=%@&key=c2155cc73435455ebc84b8fc952d8b26", textField.text];
    NSURL *url = [NSURL URLWithString:str];
    
    //创建请求类
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //创建会话
    //delegateQueue表示协议方法在哪个线程中执行
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self  delegateQueue:[NSOperationQueue mainQueue]];
    
    //根据会话创建任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    
    //启动任务
    [dataTask resume];

}

//接收到服务器响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    
    NSLog(@"1");
    
    if(_data == nil) {
        _data = [[NSMutableData alloc] init];
    } else {
        _data.length = 0;
    }
    
    //允许接收服务器的数据
    completionHandler(NSURLSessionResponseAllow);
}

//接收到数据 该方法会被调用多次
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    NSLog(@"2");
    
    //拼接data
    [_data appendData:data];
    
}

//数据请求完成或请求出现错误调用的方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"3");
    
    //请求成功 
    if(error == nil) {
        //解析数据
        id dictionary = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"-------%@", dictionary);
        
        
        NSArray *cityArr = [dictionary objectForKey:@"location"] ;
        
        _cityArr = [[NSMutableArray alloc] init];
        _array = [[NSMutableArray alloc] init];
        _idArr = [[NSMutableArray alloc] init];
        for(int i = 0; i < cityArr.count; i++) {
            NSString *cityStr = [NSString stringWithFormat:@"%@", dictionary[@"location"][i][@"name"]];
            NSString *provinceStr = [NSString stringWithFormat:@"%@", dictionary[@"location"][i][@"adm1"]];
            NSString *idStr = [NSString stringWithString:dictionary[@"location"][i][@"id"]];
            NSString *string = [NSString stringWithFormat:@"%@,   %@", cityStr, provinceStr];
            [_cityArr addObject:string];
            [_array addObject:cityStr];
            [_idArr addObject:idStr];
            
           
        }
        [_tableView reloadData];
        
    
    }
}

//转拼音
- (NSString *)pinyin:(UITextField *)textField {
    NSString *str1 = [[NSString alloc] init];
    //判断是否为汉字
   for(int i = 0; i < [textField.text length]; i++){
       int a = [textField.text characterAtIndex:i];
       if( a > 0x4e00 && a < 0x9fff) {

           CFStringRef string1 = (CFStringRef)CFBridgingRetain(textField.text);
          // NSLog(@"%@", str);
           //  汉字转换成拼音
           CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, string1);
           //  拼音（带声调的）
           CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
           //NSLog(@"%@", string);
           //  去掉声调符号
           CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
          // NSLog(@"%@", string);
           //  CFStringRef 转换成 NSString
           NSString *strings = (NSString *)CFBridgingRelease(string);
           //  去掉空格
           NSString *cityString = [strings stringByReplacingOccurrencesOfString:@" " withString:@""];
           NSLog(@"%@", cityString);

           NSString *str = [NSString stringWithFormat:@"https://geoapi.heweather.net/v2/city/lookup?location=%@&key=c2155cc73435455ebc84b8fc952d8b26", cityString];
           return str;
       } else {
           NSString *str = [NSString stringWithFormat:@"https://geoapi.heweather.net/v2/city/lookup?location=%@&key=c2155cc73435455ebc84b8fc952d8b26", textField.text];
           return str;
       }
   }
    return str1;
}
    
//点击当前cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int i = 0;
    for( ; i < _existCityArr.count; i++) {
        if([_existCityArr[i] isEqualToString:_array[indexPath.row]]) {
            break;
        }
    }
    if(i == _existCityArr.count) {
        [self.delegate passContent:_array[indexPath.row] andID:_idArr[indexPath.row]];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已有该城市" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    

}


@end

//
//  CityViewController.h
//  weather
//
//  Created by 房彤 on 2020/8/4.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "weather.h"



NS_ASSUME_NONNULL_BEGIN

@interface CityViewController : UIViewController

@property NSMutableData *data;
@property UITableView *tableView;
@property UIButton *addButton;

@property NSMutableArray *cityArray;
@property NSMutableArray *idArray;
@property NSString *tempStr;
@property NSMutableArray *tempArr;

@property NSMutableArray *weatherArray;


@end

NS_ASSUME_NONNULL_END

//
//  SearchViewController.h
//  weather
//
//  Created by 房彤 on 2020/8/4.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityViewController.h"

@protocol PassValueDelegate <NSObject>

- (void)passContent:(NSString *)string andID:(NSString *)idStr;

@end

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : UIViewController

@property UITableView *tableView;
@property UITextField *textField;
@property UIButton *cancelButton;
@property UILabel *topLabel;

@property NSMutableArray *cityArr;
@property NSMutableData *data;
@property NSMutableArray *array;
@property NSMutableArray *idArr;

@property NSArray *existCityArr;


@property id<PassValueDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

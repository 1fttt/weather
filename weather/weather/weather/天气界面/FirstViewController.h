//
//  FirstViewController.h
//  weather
//
//  Created by 房彤 on 2020/8/4.
//  Copyright © 2020 房彤. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstViewController : UIViewController


@property UIScrollView *scrollView;
@property UIPageControl *pageControl;
@property UIButton *addButton;

@property NSMutableArray *weatherArray;
@property int isBegin;
@end

NS_ASSUME_NONNULL_END

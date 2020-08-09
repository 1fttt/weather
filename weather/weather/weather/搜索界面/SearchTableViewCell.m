//
//  SearchTableViewCell.m
//  weather
//
//  Created by 房彤 on 2020/8/4.
//  Copyright © 2020 房彤. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.label = [[UILabel alloc] init];
    [self.contentView addSubview:self.label];
    return self;
}

- (void)layoutSubviews {
    self.label.frame = CGRectMake(15, 3, 200, 40);
}

@end

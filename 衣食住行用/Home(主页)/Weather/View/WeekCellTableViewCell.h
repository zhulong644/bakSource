//
//  WeekCellTableViewCell.h
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/27.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWeather.h"

@interface WeekCellTableViewCell : UITableViewCell

@property (nonatomic, strong) FWeather *weather;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

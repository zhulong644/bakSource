//
//  MainWeatherTableViewCell.h
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/14.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Realtime.h"
#import "Life.h"

@interface MainWeatherTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 天气数据 */
@property (nonatomic, strong) Realtime *realtime;
@property (nonatomic, strong) Life *life;

@end

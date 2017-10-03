//
//  MainConstellationTableViewCell.h
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/14.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodayTomorrow.h"

@interface MainConstellationTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 今天模型 */
@property (nonatomic, strong) TodayTomorrow *today;
@end

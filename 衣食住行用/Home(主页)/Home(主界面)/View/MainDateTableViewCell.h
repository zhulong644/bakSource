//
//  MainDateTableViewCell.h
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/14.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Huang.h"

@interface MainDateTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/** 日历 */
@property (nonatomic, strong) Huang *huangli;
@end

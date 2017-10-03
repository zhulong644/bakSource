//
//  ConstellationViewController.h
//  便利小助手
//
//  Created by 朱龙 on 16/1/1.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodayTomorrow.h"
#import "WeekNextWeek.h"

@interface ConstellationViewController : UIViewController
/** 今天模型 */
@property (nonatomic, strong) TodayTomorrow *today;
/** 明天模型 */
@property (nonatomic, strong) TodayTomorrow *tomorrow;
/** 本周模型 */
@property (nonatomic, strong) WeekNextWeek *week;
/** 下周模型 */
@property (nonatomic, strong) WeekNextWeek *nextWeek;
/** 星座名称 */
@property (nonatomic, strong) NSString *name;
@end

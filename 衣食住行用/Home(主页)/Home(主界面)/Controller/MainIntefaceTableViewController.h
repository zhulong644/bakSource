//
//  MainIntefaceTableViewController.h
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/14.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Realtime.h"
#import "FWeather.h"
#import "Life.h"
#import "LInfo.h"

#import "Huang.h"

#import "TodayTomorrow.h"

#import "Movie.h"

@interface MainIntefaceTableViewController : UITableViewController
/** 美食列表 */
@property (nonatomic, strong) NSArray *foodList;
/** 实时情况 */
@property (nonatomic, strong) Realtime *realtime;
/** 天气情况 */
@property (nonatomic, strong) NSArray *weather;
/** 生活指数 */
@property (nonatomic, strong) Life *life;
/** 日历 */
@property (nonatomic, strong) Huang *huangli;
/** 星座 */
@property (nonatomic, strong) TodayTomorrow *conToday;
/** 电影列表 */
@property (nonatomic, strong) NSArray *movieList;
@end

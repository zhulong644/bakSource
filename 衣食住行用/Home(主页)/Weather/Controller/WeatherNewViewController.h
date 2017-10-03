//
//  WeatherNewViewController.h
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/27.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Realtime.h"
#import "Life.h"

@interface WeatherNewViewController : UIViewController
/** 实时情况 */
@property (nonatomic, strong) Realtime *realtime;
/** 天气情况 */
@property (nonatomic, strong) NSArray *weather;
/** 生活指数 */
@property (nonatomic, strong) Life *life;
@end

//
//  WeatherDetailedViewController.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/12.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FWeather.h"
#import "Life.h"

@interface WeatherDetailedViewController : UIViewController
/** 一周天气情况 */
@property (nonatomic, strong) FWeather *weather;
/** 生活指数 */
@property (nonatomic, strong) Life *life;
@end

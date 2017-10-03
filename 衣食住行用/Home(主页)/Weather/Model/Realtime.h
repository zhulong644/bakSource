//
//  Realtime.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/10.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"
#import "Wind.h"

@interface Realtime : NSObject
/** 城市名字 */
@property (nonatomic, copy) NSString *city_name;
/** 日期 */
@property (nonatomic, copy) NSString *date;
/** 时间 */
@property (nonatomic, copy) NSString *time;
/** 星期几 */
@property (nonatomic, copy) NSString *week;
/** 农历 */
@property (nonatomic, copy) NSString *moon;
/** 天气状况 */
@property (nonatomic, strong) Weather *weather;
/** 风 */
@property (nonatomic, strong) Wind *wind;
@end

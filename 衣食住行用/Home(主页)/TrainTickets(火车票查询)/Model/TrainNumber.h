//
//  TrainNumber.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/26.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrainNumber : NSObject
/** 火车号 */
@property (nonatomic, strong) NSString *train_no;
/** m_train_url */
@property (nonatomic, strong) NSString *m_train_url;
/** 火车类型 */
@property (nonatomic, strong) NSString *train_type;
/** 起始站 */
@property (nonatomic, strong) NSString *start_station;
/** 起始站类型 */
@property (nonatomic, strong) NSString *start_station_type;
/** 终点站 */
@property (nonatomic, strong) NSString *end_station;
/** 终点站类型 */
@property (nonatomic, strong) NSString *end_station_type;
/** 起始时间 */
@property (nonatomic, strong) NSString *start_time;
/** 终点时间 */
@property (nonatomic, strong) NSString *end_time;
/** 公交名字 */
@property (nonatomic, strong) NSString *name;
/** 全长时间 */
@property (nonatomic, strong) NSString *run_time;
/** run_distance */
@property (nonatomic, strong) NSString *run_distance;
/** 价格表 */
@property (nonatomic, strong) NSArray *price_list;
/** m_chaxun_url */
@property (nonatomic, strong) NSString *m_chaxun_url;
@end

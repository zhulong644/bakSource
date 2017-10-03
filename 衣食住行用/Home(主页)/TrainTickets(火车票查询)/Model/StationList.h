//
//  StationList.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/27.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StationList : NSObject
/** 站点序号 */
@property (nonatomic, strong) NSString *train_id;
/** 车站名称 */
@property (nonatomic, strong) NSString *station_name;
/** 到达时间*/
@property (nonatomic, strong) NSString *arrived_time;
/** 离开时间 */
@property (nonatomic, strong) NSString *leave_time;
/** 里程 */
@property (nonatomic, strong) NSString *mileage;
/** 一等座 */
@property (nonatomic, strong) NSString *fsoftSeat;
/** 二等座 */
@property (nonatomic, strong) NSString *ssoftSeat;
/** 硬座 */
@property (nonatomic, strong) NSString *hardSead;
/** 软座 */
@property (nonatomic, strong) NSString *softSeat;
/** 硬卧 */
@property (nonatomic, strong) NSString *hardSleep;
/** 软卧 */
@property (nonatomic, strong) NSString *softSleep;
/** 无座 */
@property (nonatomic, strong) NSString *wuzuo;
/** 商务座 */
@property (nonatomic, strong) NSString *swz;
/** 特等座 */
@property (nonatomic, strong) NSString *tdz;
/** 高级软卧 */
@property (nonatomic, strong) NSString *gjrw;
/** 停留 */
@property (nonatomic, strong) NSString *stay;
@end

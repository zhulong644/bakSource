//
//  BusLine.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/24.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusLine : NSObject
/** 公交名字 */
@property (nonatomic, strong) NSString *name;
/** 起始时间 */
@property (nonatomic, strong) NSString *start_time;
/** 末班时间 */
@property (nonatomic, strong) NSString *end_time;
/** 基本票价 */
@property (nonatomic, strong) NSString *basic_price;
/** 全程票价 */
@property (nonatomic, strong) NSString *total_price;
/** 路线全长 */
@property (nonatomic, strong) NSString *length;
/** 公交站点信息 */
@property (nonatomic, strong) NSArray *stationdes;
@end

//
//  Station.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/25.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Station : NSObject
/** 线路ID */
@property (nonatomic, strong) NSString *line_id;
/** 线路名称 */
@property (nonatomic, strong) NSString *name;
/** 关键名字 */
@property (nonatomic, strong) NSString *key_name;
/** 起始站 */
@property (nonatomic, strong) NSArray *front_name;
/** 终点站 */
@property (nonatomic, strong) NSArray *terminal_name;
/** 起始时间 */
@property (nonatomic, strong) NSArray *start_time;
/** 末班时间 */
@property (nonatomic, strong) NSArray *end_time;
/** 基本价格 */
@property (nonatomic, strong) NSArray *basic_price;
/** 全程价格 */
@property (nonatomic, strong) NSArray *total_price;
/** 运营公司 */
@property (nonatomic, strong) NSArray *company;
/** 全长 */
@property (nonatomic, strong) NSArray *length;

@end

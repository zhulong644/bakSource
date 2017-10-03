//
//  Guarantee.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/6.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Guarantee : NSObject
/** 设备型号 */
@property (nonatomic, copy) NSString *phone_model;
/** 设备序列号 */
@property (nonatomic, copy) NSString *serial_number;
/** IMEI号 */
@property (nonatomic, copy) NSString *imei_number;
/** 激活状态 */
@property (nonatomic, copy) NSString *active;
/** 快保修状态 */
@property (nonatomic, copy) NSString *tele_support;
/** 保修到期 */
@property (nonatomic, copy) NSString *tele_support_status;
/** 电话支持到期 */
@property (nonatomic, copy) NSString *warranty;
/** 电话支持状态 */
@property (nonatomic, copy) NSString *warranty_status;
/** 生产工厂 */
@property (nonatomic, copy) NSString *made_area;
/** 生产时间开始 */
@property (nonatomic, copy) NSString *start_date;
/** 生产时间结束 */
@property (nonatomic, copy) NSString *end_date;
/** 颜色 */
@property (nonatomic, copy) NSString *color;
/** 规格 */
@property (nonatomic, copy) NSString *size;
@end

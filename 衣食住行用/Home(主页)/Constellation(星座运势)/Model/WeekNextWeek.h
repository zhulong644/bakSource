//
//  WeekNextWeek.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/20.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeekNextWeek : NSObject
/** 日期 */
@property (nonatomic, copy) NSString *date;
/** 健康 */
@property (nonatomic, copy) NSString *health;
/** 求职 */
@property (nonatomic, copy) NSString *job;
/** 恋爱 */
@property (nonatomic, copy) NSString *love;
/** 金钱 */
@property (nonatomic, copy) NSString *money;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 周数 */
@property (nonatomic, copy) NSString *weekth;
/** 工作 */
@property (nonatomic, copy) NSString *work;
@end

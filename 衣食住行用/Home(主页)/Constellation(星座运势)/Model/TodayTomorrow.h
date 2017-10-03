//
//  Today.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/20.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodayTomorrow : NSObject
/** 日期 */
@property (nonatomic, copy) NSString *date;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 友谊星座 */
@property (nonatomic, copy) NSString *QFriend;
/** 综合指数 */
@property (nonatomic, copy) NSString *all;
/** 幸运颜色 */
@property (nonatomic, copy) NSString *color;
/** 日期时间 */
@property (nonatomic, copy) NSString *datetime;
/** 健康指数 */
@property (nonatomic, copy) NSString *health;
/** 恋爱指数 */
@property (nonatomic, copy) NSString *love;
/** 金钱指数 */
@property (nonatomic, copy) NSString *money;
/** 数字 */
@property (nonatomic, copy) NSString *number;
/** 综合指数 */
@property (nonatomic, copy) NSString *summary;
/** 工作指数 */
@property (nonatomic, copy) NSString *work;
@end

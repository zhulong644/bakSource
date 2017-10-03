//
//  Year.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/20.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Year : NSObject
/** 名字 */
@property (nonatomic, copy) NSString *name;
/** 日期 */
@property (nonatomic, copy) NSString *date;
/** 年 */
@property (nonatomic, copy) NSString *year;
/** 职业 */
@property (nonatomic, copy) NSArray *career;
/** 爱情 */
@property (nonatomic, copy) NSArray *love;
/** 健康 */
@property (nonatomic, copy) NSArray *health;
/** 财政 */
@property (nonatomic, copy) NSArray *finance;
/** 综合 */
@property (nonatomic, copy) NSString *luckyStone;
@end

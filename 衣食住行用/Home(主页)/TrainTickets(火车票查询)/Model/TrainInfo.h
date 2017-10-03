//
//  TrainInfo.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/27.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrainInfo : NSObject
/** 列车名称 */
@property (nonatomic, strong) NSString *name;
/** 始发站 */
@property (nonatomic, strong) NSString *start;
/** 终点站 */
@property (nonatomic, strong) NSString *end;
/** 开始时间 */
@property (nonatomic, strong) NSString *starttime;
/** 结束时间 */
@property (nonatomic, strong) NSString *endtime;
/** 全长 */
@property (nonatomic, strong) NSString *mileage;
@end

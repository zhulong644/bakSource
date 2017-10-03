//
//  FWeather.h
//  06-AFN01-基本使用（掌握）
//
//  Created by 朱龙 on 15/10/10.
//  Copyright © 2015年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FInfo.h"

@interface FWeather : NSObject
/** 日期 */
@property (nonatomic, copy) NSString *date;
/** 信息 */
@property (nonatomic, copy) NSString *week;
/** 星期 */
@property (nonatomic, copy) NSString *nongli;
/** 农历 */
@property (nonatomic, strong) FInfo *info;
@end

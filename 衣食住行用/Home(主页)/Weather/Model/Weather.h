//
//  Weather.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/10.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject
/** 温度 */
@property (nonatomic, copy) NSString *temperature;
/** 湿度 */
@property (nonatomic, copy) NSString *humidity;
/** 信息 */
@property (nonatomic, copy) NSString *info;
/** 图片 */
@property (nonatomic, copy) NSString *img;
@end

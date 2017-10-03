//
//  City.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/2.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject
/** 城市ID */
@property (nonatomic, copy) NSString *id;
/** 城市名称 */
@property (nonatomic, copy) NSString *city_name;
/** 城市前缀 */
@property (nonatomic, copy) NSString *city_pre;
/** 城市拼音 */
@property (nonatomic, copy) NSString *city_pinyin;
/** 城市简写 */
@property (nonatomic, copy) NSString *city_short;
/** 影院数量 */
@property (nonatomic, copy) NSString *count;
@end

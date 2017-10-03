//
//  CityList.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/15.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityList : NSObject
/** 城市ID */
@property (nonatomic, copy) NSString *id;
/** 城市名字 */
@property (nonatomic, copy) NSString *city_name;
/** city_pre */
@property (nonatomic, copy) NSString *city_pre;
/** 城市拼音 */
@property (nonatomic, copy) NSString *city_pinyin;
/** 城市缩写 */
@property (nonatomic, copy) NSString *city_short;
/** count*/
@property (nonatomic, copy) NSString *count;

@end

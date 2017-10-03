//
//  FoodList.h
//  06-AFN01-基本使用（掌握）
//
//  Created by 朱龙 on 15/10/1.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Step.h"
@interface FoodList : NSObject

/** 图片 */
@property (copy, nonatomic) NSArray *albums;
/** 食物描述描述 */
@property (copy, nonatomic) NSString *imtro;
/** 食物标题 */
@property (copy, nonatomic) NSString *title;
/** 食物ID */
@property (copy, nonatomic) NSString *id;
/** 食物配料 */
@property (copy, nonatomic) NSString *burden;
/** 食物主料 */
@property (copy, nonatomic) NSString *ingredients;
/** 食物步骤 */
@property (copy, nonatomic) NSArray *steps;
/** 用途 */
@property (copy, nonatomic) NSString *tags;

@end

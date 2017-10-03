//
//  FoodName.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/4.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodName : NSObject

/** 菜的主名称 */
@property (nonatomic, copy) NSString *name;
/** 区域(存放的都是MTRegion模型) */
@property (nonatomic, strong) NSArray *subName;

@end

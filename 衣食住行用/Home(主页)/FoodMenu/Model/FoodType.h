//
//  FoodType.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/30.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodType : NSObject
/** 分类ID */
@property (nonatomic, copy) NSString *parentId;
/** 标签名称 */
@property (nonatomic, copy) NSString *name;
/** 详细菜表 */
@property (nonatomic, strong) NSArray *list;
@end

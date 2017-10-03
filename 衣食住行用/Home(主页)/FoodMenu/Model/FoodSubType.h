//
//  FoodSubType.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/30.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodSubType : NSObject
/** 标签ID */
@property (nonatomic, copy) NSString *id;
/** 标签名称 */
@property (nonatomic, copy) NSString *name;
/** 分类ID */
@property (nonatomic, strong) NSString *parentId;
@end

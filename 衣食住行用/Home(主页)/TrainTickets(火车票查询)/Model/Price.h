//
//  Price.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/26.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Price : NSObject
/** 座位类型 */
@property (nonatomic, copy) NSString *price_type;
/** 座位价格 */
@property (nonatomic, copy) NSString *price;
@end

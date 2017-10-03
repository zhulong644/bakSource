//
//  ExpressInfo.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/6.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpressInfo : NSObject
/** 时间 */
@property (nonatomic, copy) NSString *datetime;
/** 描述 */
@property (nonatomic, copy) NSString *remark;
/** 区域 */
@property (nonatomic, copy) NSString *zone;
@end

//
//  Stats.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/24.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stats : NSObject
/** code */
@property (nonatomic, strong) NSString *code;
/** 站号 */
@property (nonatomic, strong) NSString *stationNum;
/** 站名 */
@property (nonatomic, strong) NSString *name;
/** 经纬度 */
@property (nonatomic, strong) NSString *xy;
@end

//
//  FInfo.h
//  06-AFN01-基本使用（掌握）
//
//  Created by 朱龙 on 15/10/10.
//  Copyright © 2015年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FInfo : NSObject
/** 白天 */
@property (nonatomic, strong) NSArray *day;
/** 夜晚 */
@property (nonatomic, strong) NSArray *night;
/** 黎明 */
@property (nonatomic, strong) NSArray *dawn;
@end

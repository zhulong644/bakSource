//
//  Life.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/13.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LInfo.h"

@interface Life : NSObject
/** 日期 */
@property (nonatomic, copy) NSString *date;
/** 详细信息 */
@property (nonatomic, strong)  LInfo *info;
@end

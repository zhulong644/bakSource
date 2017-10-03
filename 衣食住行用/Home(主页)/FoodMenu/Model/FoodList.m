//
//  FoodList.m
//  06-AFN01-基本使用（掌握）
//
//  Created by 朱龙 on 15/10/1.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "FoodList.h"
#import "Step.h"
#import "album.h"

@implementation FoodList
- (NSDictionary *)objectClassInArray
{
    return @{@"steps" : [Step class]};
}
@end

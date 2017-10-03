//
//  FoodName.m
//  衣食住行用
//
//  Created by 朱龙 on 15/10/4.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "FoodName.h"
#import "MJExtension.h"
#import "FoodSubName.h"

@implementation FoodName

- (NSDictionary *)objectClassInArray
{
    return @{@"subName" : [FoodSubName class]};
}

@end

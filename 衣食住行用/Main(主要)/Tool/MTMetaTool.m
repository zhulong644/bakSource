//
//  MTMetaTool.m
//  美团HD
//
//  Created by apple on 14/11/24.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "MTMetaTool.h"
#import "MJExtension.h"
#import "FoodName.h"

@implementation MTMetaTool

//static NSArray *_cities;
//+ (NSArray *)cities
//{
//    if (_cities == nil) {
//        _cities = [MTCity objectArrayWithFilename:@"cities.plist"];;
//    }
//    return _cities;
//}

static NSArray *_FoodName;
+ (NSArray *)FoodNames
{
    if (_FoodName == nil) {
        _FoodName = [FoodName objectArrayWithFilename:@"FoodMenu.plist"];;
    }
    return _FoodName;
}


@end

//
//  CitySearchView.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/2.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitySearchView : UITableViewController
/** 城市数组 */
@property (nonatomic, strong) NSArray *citys;
/** 关键字 */
@property (nonatomic, strong) NSString *searchText;
@end

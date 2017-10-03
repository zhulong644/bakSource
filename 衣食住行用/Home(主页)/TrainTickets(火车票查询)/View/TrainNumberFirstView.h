//
//  TrainNumberFirstView.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/27.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainInfo.h"

@interface TrainNumberFirstView : UITableViewController
/** 火车信息 */
@property (nonatomic, strong) TrainInfo *trainInfo;
/** 车站数组 */
@property (nonatomic, strong) NSArray *stationList;
@end

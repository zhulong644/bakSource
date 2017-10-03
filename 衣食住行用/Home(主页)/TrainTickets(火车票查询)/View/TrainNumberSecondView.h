//
//  TrainNumberSecondView.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/27.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StationList.h"
#import "TrainInfo.h"

@interface TrainNumberSecondView : UITableViewController
/** 火车信息 */
@property (nonatomic, strong) StationList *stationList;
/** 火车信息 */
@property (nonatomic, strong) TrainInfo *trainInfo;
@end

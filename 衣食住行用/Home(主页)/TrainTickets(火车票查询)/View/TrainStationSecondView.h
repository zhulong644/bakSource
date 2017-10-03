//
//  TrainStationSecondView.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/27.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainNumber.h"

@interface TrainStationSecondView : UITableViewController
/** 火车信息 */
@property (nonatomic, strong) TrainNumber *trainNumber;
@end

//
//  TrainSecondFirstView.h
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/27.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainTicket.h"

@interface TrainSecondFirstView : UITableViewController
/** 火车信息 */
@property (nonatomic, strong) TrainTicket *trainTicket;
@end

//
//  CollectionViewController.h
//  YSLTransitionAnimatorDemo
//
//  Created by yamaguchi on 2015/05/13.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UICollectionViewController
/**菜谱*/
@property (nonatomic, copy) NSMutableArray *FoodDetailedList;
/**g关键字*/
@property (nonatomic, copy) NSString *foodName;
@end

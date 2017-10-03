//
//  MovieCell.h
//  衣食住行用
//
//  Created by 朱龙 on 15/10/16.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
@interface MovieCell : UICollectionViewCell

/** 电影模型 */
@property (nonatomic, strong) Movie *movie;

@end

//
//  CollectionViewController.m
//  YSLTransitionAnimatorDemo
//
//  Created by yamaguchi on 2015/05/13.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionCell.h"
#import "CollectionDetailViewController.h"
#import "YSLTransitionAnimator.h"
#import "UIViewController+YSLTransition.h"
#import "UIImageView+WebCache.h"
#import "FoodList.h"

@interface CollectionViewController () <UICollectionViewDelegateFlowLayout, YSLTransitionAnimatorDataSource>

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"CollectionCell";

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self ysl_removeTransitionDelegate];
}

- (void)viewDidAppear:(BOOL)animated
{
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    [self ysl_addTransitionDelegate:self];
    [self ysl_pushTransitionAnimationWithToViewControllerImagePointY:statusHeight + navigationHeight
                                                   animationDuration:0.3];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"美食菜单"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.FoodDetailedList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell *cell = (CollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    FoodList *foodDetailed = self.FoodDetailedList[indexPath.row];
    NSArray *imgArray = foodDetailed.albums;
    NSString *image = imgArray[0];
    [cell.itemImage sd_setImageWithURL:[NSURL URLWithString:image]];
    cell.itemLabel.text = foodDetailed.title;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     FoodList *foodDetailed = self.FoodDetailedList[indexPath.row];
     CollectionDetailViewController *vc = [[CollectionDetailViewController alloc]init];
     vc.foodList = foodDetailed;
     self.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width / 2) - 9, (self.view.frame.size.width / 2) - 9);
}

#pragma mark -- YSLTransitionAnimatorDataSource
- (UIImageView *)pushTransitionImageView
{
    CollectionCell *cell = (CollectionCell *)[self.collectionView cellForItemAtIndexPath:[[self.collectionView indexPathsForSelectedItems] firstObject]];
    return cell.itemImage;
}

- (UIImageView *)popTransitionImageView
{
    return nil;
}


@end

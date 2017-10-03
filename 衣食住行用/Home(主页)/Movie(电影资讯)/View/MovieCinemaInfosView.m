//
//  MovieCinemaInfosView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/31.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "MovieCinemaInfosView.h"
#import "OTPageScrollView.h"
#import "OTPageView.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "TodayTomorrow.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "MovieList.h"
#import "BroadcastCell.h"

#define ScreenWidth self.view.bounds.size.width
#define ScreenHeight self.view.bounds.size.height

@interface MovieCinemaInfosView ()<OTPageScrollViewDataSource,OTPageScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *cinemaTitle;
@property (weak, nonatomic) IBOutlet UILabel *cinemaAddr;
@property (weak, nonatomic) IBOutlet UILabel *cinemaTele;
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *myViewHeight;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

/** 排期模型 */
@property (nonatomic, strong) NSArray *broadcast;

@property (nonatomic, strong) MovieList *movieList;

@end

@implementation MovieCinemaInfosView


- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:self.cinemaInfo.name];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    //上部分
    CGRect pScrollViewRect = CGRectMake(0, 130, [[UIScreen mainScreen] bounds].size.width, 160);
    OTPageView *PScrollView = [[OTPageView alloc] initWithFrame: pScrollViewRect];
    PScrollView.pageScrollView.dataSource = self;
    PScrollView.pageScrollView.delegate = self;
    PScrollView.pageScrollView.padding =50;
    PScrollView.pageScrollView.leftRightOffset = 0;
    PScrollView.pageScrollView.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width -150)/2, 30, 150, 100);
    PScrollView.backgroundColor = [UIColor lightGrayColor];
    
    [PScrollView.pageScrollView viewForRowAtIndex:2];
    [PScrollView.pageScrollView reloadData];
    [self.myView addSubview:PScrollView];
    
    self.cinemaTitle.text = self.cinemaInfo.name;
    self.cinemaAddr.text = self.cinemaInfo.address;
    self.cinemaTele.text = self.cinemaInfo.telephone;
    
    MovieList *moveList = self.movieInfoList[0];
    self.broadcast = [Broadcast objectArrayWithKeyValuesArray:moveList.broadcast];
    //决定自动布局的高度
    self.myViewHeight.constant = 300 + self.broadcast.count * 60;
    
}
- (NSInteger)numberOfPageInPageScrollView:(OTPageScrollView*)pageScrollView{
    return self.movieInfoList.count;
}
//控件中每个电影宽高的布局
- (UIView*)pageScrollView:(OTPageScrollView*)pageScrollView viewForRowAtIndex:(int)index{
    UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 140)];
    cell.backgroundColor = [UIColor grayColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    MovieList *movieList = self.movieInfoList[index];
    [imageView sd_setImageWithURL:[NSURL URLWithString:movieList.pic_url]];
    [cell addSubview:imageView];
    return cell;
}

- (CGSize)sizeCellForPageScrollView:(OTPageScrollView*)pageScrollView
{
    return CGSizeMake(100, 140);
}

- (void)pageScrollView:(OTPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index
{
   if (index == pageScrollView.contentOffset.x / pageScrollView.frame.size.width) return;
//    self.cinemaInfoTableView.movieList = self.movieInfoList[index];
    MovieList *moveList = self.movieInfoList[index];
    self.broadcast = [Broadcast objectArrayWithKeyValuesArray:moveList.broadcast];
    self.myViewHeight.constant = 300 + self.broadcast.count * 60;
    [self.myTableView reloadData];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
//    self.cinemaInfoTableView.movieList = self.movieInfoList[index];
    MovieList *moveList = self.movieInfoList[index];
    self.broadcast = [Broadcast objectArrayWithKeyValuesArray:moveList.broadcast];
    self.myViewHeight.constant = 300 + self.broadcast.count * 60;
    [self.myTableView reloadData];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
#pragma mark cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.broadcast.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BroadcastCell *cell = [BroadcastCell cellWithTableView:tableView];
    //不可点击
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Broadcast *broadcast = self.broadcast[indexPath.row];
    
    cell.broadcast = broadcast;
    
    return cell;
}

@end

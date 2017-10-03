//
//  CitySelectedView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/2.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "CitySelectedView.h"
#import "City.h"
#import "MTConst.h"
#import "CitySearchView.h"

#define ScreenWidth self.view.bounds.size.width
#define ScreenHeight self.view.bounds.size.height

@interface CitySelectedView () <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *cityTable;
/**搜索栏蒙版*/
@property (nonatomic, strong) UIImageView *searchFoodBarBoard;
/**搜索的城市名字*/
@property (nonatomic, copy) NSString *searchCityText;
/**搜索的城市列表*/
@property (nonatomic, strong) CitySearchView *searchView;
@end

@implementation CitySelectedView
- (CitySearchView *)searchView
{
    if (!_searchView) {
        CitySearchView *searchView = [[CitySearchView alloc] init];
        searchView.view.frame = CGRectMake(0, 44, ScreenWidth, ScreenHeight);
        self.searchView = searchView;
        [self.view addSubview:searchView.view];
        [self addChildViewController:searchView];
    }
    return _searchView;
}
- (UIImageView *)searchFoodBarBoard
{
    if (!_searchFoodBarBoard) {
        self.searchFoodBarBoard = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight)];
        self.searchFoodBarBoard.backgroundColor = [UIColor whiteColor];
    }
    return _searchFoodBarBoard;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //     1.设置左右按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:0 target:self action:@selector(rightMenu)];
}
- (void)rightMenu
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UISearchBar
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // 添加带有处理时间的背景图片
    self.searchFoodBarBoard.alpha = 1;
    self.searchFoodBarBoard.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.searchFoodBarBoard addGestureRecognizer:singleTouch];
    //    backView.tag = 110;
    [self.view addSubview:self.searchFoodBarBoard];
}
- (void)dismissKeyboard
{
    [self.searchBar resignFirstResponder];
    self.searchFoodBarBoard.alpha = 0;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchCityText = searchText;
    if (searchText.length) {
        self.searchView.view.hidden = NO;
        self.searchView.searchText = searchText;
        self.searchView.citys = self.citys;
    } else {
        self.searchView.view.hidden = YES;
    }
}
/**
 *  键盘退下:搜索框结束编辑文字
 */
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{

    //移除搜索结果
    self.searchView.view.hidden = YES;
    searchBar.text = nil;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//    NSLog(@"%@", self.searchCityText);

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.citys.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.selectionStyle = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    City *city = self.citys[indexPath.row];
    cell.textLabel.text = city.city_name;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    City *city = self.citys[indexPath.row];
    // 发出通知
    [MTNotificationCenter postNotificationName:MTCityDidChangeNotification object:nil userInfo:@{MTSelectCityId : city.id, MTSelectCityName : city.city_name}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

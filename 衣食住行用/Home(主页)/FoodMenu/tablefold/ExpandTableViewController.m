//
//  ExpandTableViewController.m
//  ExpandTableView
//
//  Created by 郑文明 on 16/1/8.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "ExpandTableViewController.h"
#import "ExpandCell.h"
#import "FoodType.h"
#import "FoodList.h"
#import "FoodSubType.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "MTConst.h"
#import "MJExtension.h"
#import "MBProgressHUD.h"
#import "CollectionViewController.h"
#import "LikeFoodTableViewController.h"
#import "AFNetworking.h"

#define kCell_Height 44
#define ScreenWidth self.view.bounds.size.width
#define ScreenHeight self.view.bounds.size.height

@interface ExpandTableViewController ()<UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate>
{
    UITableView         *expandTable;
    NSArray             *dataSource;
    NSMutableArray      *sectionArray;
    NSMutableArray      *stateArray;
}
/**搜索的菜谱名字*/
@property (nonatomic, copy) NSString *searchFoodText;
/**搜索栏*/
@property (nonatomic, strong) UISearchBar *searchFoodBar;
/**搜索栏蒙版*/
@property (nonatomic, strong) UIImageView *searchFoodBarBoard;

@end

@implementation ExpandTableViewController

- (UISearchBar *)searchFoodBar
{
    if (!_searchFoodBar) {
        self.searchFoodBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        self.searchFoodBar.delegate = self;
    }
    return _searchFoodBar;
}
- (UIImageView *)searchFoodBarBoard
{
    if (!_searchFoodBarBoard) {
        self.searchFoodBarBoard = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight)];
        self.searchFoodBarBoard.backgroundColor = [UIColor whiteColor];
    }
    return _searchFoodBarBoard;
}


- (void)initDataSource
{
    // 增加搜索框
    [self.view addSubview:self.searchFoodBar];
    
    dataSource = self.foodTypes;
    stateArray = [NSMutableArray array];
    
    for (int i = 0; i < dataSource.count; i++)
    {
        //所有的分区都是闭合
        [stateArray addObject:@"0"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"美食分类"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    
    NSString *addText = @"收藏";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:addText style:0 target:self action:@selector(doCollection)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initDataSource];
    [self initTable];
}
- (void)doCollection
{
    LikeFoodTableViewController *like = [[LikeFoodTableViewController alloc] init];
     UINavigationController *ui = [[UINavigationController alloc] initWithRootViewController:like];
    [ self presentViewController:ui animated: YES completion:nil];
}
-(void)initTable
{
    expandTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 108) style:UITableViewStylePlain];
    expandTable.dataSource = self;
    expandTable.delegate =  self;
    expandTable.tableFooterView = [[UIView alloc] init];
    [expandTable registerNib:[UINib nibWithNibName:@"ExpandCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:expandTable];
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
    [self.searchFoodBar resignFirstResponder];
    self.searchFoodBarBoard.alpha = 0;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchFoodText = searchText;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //replace
    NSString *path = @"http://apis.juhe.cn/cook/query.php";
    
    NSDictionary *params = @{@"menu": self.searchFoodText,@"key":@"5ea5902a623b185ee961c59bdb082f91"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        if (!error_code) {
            NSArray *foodList = [FoodList objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
            CollectionViewController *vc = [[CollectionViewController alloc]initWithNibName:@"CollectionViewController" bundle:nil];
            CGRect rect = [[self view] bounds];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
            [imageView setImage:[UIImage imageNamed:@"2013-09-15-18.34.08" ]];
            vc.collectionView.backgroundView = imageView;
            //返回的菜谱列表付给下一个菜谱
            vc.FoodDetailedList = [NSMutableArray arrayWithArray:foodList];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            [self.searchFoodBar resignFirstResponder];
            self.searchFoodBar.text = nil;
            self.searchFoodBarBoard.alpha = 0;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } else {
            NSString *title = NSLocalizedString(@"没有找到结果", nil);
            NSString *otherButtonTitle = NSLocalizedString(@"确认", nil);
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
            [alertController addAction:otherAction];
            [self presentViewController:alertController animated:YES completion:nil];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];
    //聚合相关
//    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:ZLJHOpenId];
//    NSString *path = @"http://apis.juhe.cn/cook/query.php";
//    NSString *api_id = @"46";
//    NSString *method = @"GET";
//    NSDictionary *param = @{@"menu": self.searchFoodText};
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                            int error_code = [[responseObject objectForKey:@"error_code"] intValue];
//                            if (!error_code) {
//                                NSArray *foodList = [FoodList objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
//                                CollectionViewController *vc = [[CollectionViewController alloc]initWithNibName:@"CollectionViewController" bundle:nil];
//                                CGRect rect = [[self view] bounds];
//                                UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
//                                [imageView setImage:[UIImage imageNamed:@"2013-09-15-18.34.08" ]];
//                                vc.collectionView.backgroundView = imageView;
//                                //返回的菜谱列表付给下一个菜谱
//                                vc.FoodDetailedList = [NSMutableArray arrayWithArray:foodList];
//                                self.hidesBottomBarWhenPushed = YES;
//                                [self.navigationController pushViewController:vc animated:YES];
//                                [self.searchFoodBar resignFirstResponder];
//                                self.searchFoodBar.text = nil;
//                                self.searchFoodBarBoard.alpha = 0;
//                                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                            } else {
//                                NSString *title = NSLocalizedString(@"没有找到结果", nil);
//                                NSString *otherButtonTitle = NSLocalizedString(@"确认", nil);
//                                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
//                                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                                }];
//                                [alertController addAction:otherAction];
//                                [self presentViewController:alertController animated:YES completion:nil];
//                                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                            }
//                        } Failure:^(NSError *error) {
//                            NSLog(@"error:   %@",error.description);
//                        }];
}

#pragma mark - UITableViewDataSource UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([stateArray[section] isEqualToString:@"1"]){
        //如果是展开状态
        FoodType *foodType = self.foodTypes[section];
        NSArray *foodSubTypes = [FoodSubType objectArrayWithKeyValuesArray:foodType.list];
//        NSArray *array = [dataSource objectAtIndex:section];
        return foodSubTypes.count;
    }else{
        //如果是闭合，返回0
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExpandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.listLabel.textAlignment = NSTextAlignmentLeft;
    
    FoodType *foodType = self.foodTypes[indexPath.section];
    NSArray *foodSubTypes = [FoodSubType objectArrayWithKeyValuesArray:foodType.list];
    FoodSubType *food = foodSubTypes[indexPath.row];
    cell.listLabel.text = food.name;
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [button setTag:section+1];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 60)];
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, button.frame.size.height-1, button.frame.size.width, 1)];
    [line setImage:[UIImage imageNamed:@"line_real"]];
    [button addSubview:line];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (kCell_Height-22)/2, 22, 22)];
    [imgView setImage:[UIImage imageNamed:@"ico_faq_d"]];
    [button addSubview:imgView];
    
    UIImageView *_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, (kCell_Height-6)/2, 10, 6)];
    
    if ([stateArray[section] isEqualToString:@"0"]) {
        _imgView.image = [UIImage imageNamed:@"ico_listdown"];
    }else if ([stateArray[section] isEqualToString:@"1"]) {
        _imgView.image = [UIImage imageNamed:@"ico_listup"];
    }
    [button addSubview:_imgView];
    
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(45, (kCell_Height-20)/2, 200, 20)];
    [tlabel setBackgroundColor:[UIColor clearColor]];
    [tlabel setFont:[UIFont systemFontOfSize:14]];
    
    FoodType *foodType = self.foodTypes[section];
    [tlabel setText:foodType.name];
    
    [button addSubview:tlabel];
    return button;
}
#pragma mark  -select cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    FoodType *foodType = self.foodTypes[indexPath.section];
    NSArray *foodSubTypes = [FoodSubType objectArrayWithKeyValuesArray:foodType.list];
    FoodSubType *foodSubType = foodSubTypes[indexPath.row];

    NSString *typeId = foodSubType.id;
    //replace
    NSString *path = @"http://apis.juhe.cn/cook/index";
    
    NSDictionary *params = @{@"cid": typeId,@"key":@"5ea5902a623b185ee961c59bdb082f91"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        if (!error_code) {
            NSArray *foodList = [FoodList objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
            CollectionViewController *vc = [[CollectionViewController alloc]initWithNibName:@"CollectionViewController" bundle:nil];
            //返回的菜谱列表付给下一个菜谱
            vc.FoodDetailedList = [NSMutableArray arrayWithArray:foodList];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        } else {
            NSString *title = NSLocalizedString(@"没有找到结果", nil);
            NSString *otherButtonTitle = NSLocalizedString(@"确认", nil);
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
            [alertController addAction:otherAction];
            [self presentViewController:alertController animated:YES completion:nil];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];

    //聚合相关
//    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:ZLJHOpenId];
//    NSString *path = @"http://apis.juhe.cn/cook/index";
//    NSString *api_id = @"46";
//    NSString *method = @"GET";
//    NSDictionary *param = @{@"cid": typeId};
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                            int error_code = [[responseObject objectForKey:@"error_code"] intValue];
//                            if (!error_code) {
//                                NSArray *foodList = [FoodList objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
//                                CollectionViewController *vc = [[CollectionViewController alloc]initWithNibName:@"CollectionViewController" bundle:nil];
//                                //返回的菜谱列表付给下一个菜谱
//                                vc.FoodDetailedList = [NSMutableArray arrayWithArray:foodList];
//                                self.hidesBottomBarWhenPushed = YES;
//                                [self.navigationController pushViewController:vc animated:YES];
//                                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                                
//                            } else {
//                                NSString *title = NSLocalizedString(@"没有找到结果", nil);
//                                NSString *otherButtonTitle = NSLocalizedString(@"确认", nil);
//                                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
//                                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                                }];
//                                [alertController addAction:otherAction];
//                                [self presentViewController:alertController animated:YES completion:nil];
//                                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                            }
//                            
//                        } Failure:^(NSError *error) {
//                            NSLog(@"error:   %@",error.description);
//                        }];

}

- (void)buttonPress:(UIButton *)sender//headButton点击
{
    //判断状态值
    if ([stateArray[sender.tag - 1] isEqualToString:@"1"]){
        //修改
        [stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"0"];
    }else{
        [stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"1"];
    }
    [expandTable reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-1] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCell_Height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kCell_Height;
}

@end

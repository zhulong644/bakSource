//
//  LikeFoodTableViewController.m
//  便利小助手
//
//  Created by 朱 龙 on 2016/06/22.
//  Copyright © 2016年 朱龙. All rights reserved.
//

#import "LikeFoodTableViewController.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "MTConst.h"
#import "MBProgressHUD.h"
#import "MJExtension.h"
#import "FoodList.h"
#import "CollectionDetailViewController.h"
#import "AFNetworking.h"

@interface LikeFoodTableViewController ()

@end

@implementation LikeFoodTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"我的收藏"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReload) name:@"food" object:nil];
    
    //设置左右按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(rightMenu)];
    [self setExtraCellLineHidden:self.tableView];
}
#pragma mark - 通知刷新
- (void)tableViewReload
{
    [self.tableView reloadData];
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:@"food" name:nil object:self];
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (void)rightMenu
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSData* data  = [[NSUserDefaults standardUserDefaults] objectForKey:@"collectionArray"];
    NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    return oldSavedArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const tableCell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableCell];
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSData* data  = [[NSUserDefaults standardUserDefaults] objectForKey:@"collectionArray"];
    NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSDictionary *dic = [oldSavedArray objectAtIndex:indexPath.row];
    
    NSString *textLabel = [dic objectForKey:@"foodtitle"];
    
    cell.detailTextLabel.text = textLabel;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:18];
//    cell.detailTextLabel.textColor = [UIColor lightGrayColor];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSData* data  = [[NSUserDefaults standardUserDefaults] objectForKey:@"collectionArray"];
    NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSDictionary *dic = [oldSavedArray objectAtIndex:indexPath.row];
    //replace
    NSString *path = @"http://apis.juhe.cn/cook/queryid";
    
    NSDictionary *params = @{@"id":[dic objectForKey:@"foodid"],@"key":@"5ea5902a623b185ee961c59bdb082f91"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *foodList = [FoodList objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
        FoodList *food = foodList[0];
        
        CollectionDetailViewController *vc = [[CollectionDetailViewController alloc]init];
        vc.foodList = food;
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];
    //聚合相关
//    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:ZLJHOpenId];
//    NSString *path = @"http://apis.juhe.cn/cook/queryid";
//    NSString *api_id = @"46";
//    NSString *method = @"GET";
//    NSDictionary *param = @{@"id":[dic objectForKey:@"foodid"]};
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                            NSArray *foodList = [FoodList objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
//                            FoodList *food = foodList[0];
//                    
//                            CollectionDetailViewController *vc = [[CollectionDetailViewController alloc]init];
//                            vc.foodList = food;
//                            
//                            self.hidesBottomBarWhenPushed = YES;
//                            [self.navigationController pushViewController:vc animated:YES];
//                            [MBProgressHUD hideHUDForView:self.view animated:YES];
////                            [self rightMenu];
//                            
//                        } Failure:^(NSError *error) {
//                            NSLog(@"error:   %@",error.description);
//                        }];

}
-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        NSData* data  = [[NSUserDefaults standardUserDefaults] objectForKey:@"collectionArray"];
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSMutableArray *arr = [oldSavedArray mutableCopy];
        
        [arr removeObjectAtIndex:indexPath.row];
        NSArray *newArray = [arr copy];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:newArray] forKey:@"collectionArray"];
        
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
@end

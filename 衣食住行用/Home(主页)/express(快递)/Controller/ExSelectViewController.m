//
//  ExSelectViewController.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/6.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "ExSelectViewController.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "MBProgressHUD.h"
#import "MJExtension.h"
#import "Express.h"
#import "ExpressInfo.h"
#import "ExComSelectView.h"
#import "MTConst.h"
#import "ExpressTableView.h"
#import "MTConst.h"
#import "AFNetworking.h"

@interface ExSelectViewController ()
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UITextField *expressText;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

/** 快递公司简称 */
@property (nonatomic, strong) NSString *expressComNo;
@end

@implementation ExSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.searchButton.enabled = NO;    [self.expressText becomeFirstResponder];
    self.expressComNo = @"sf";
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"快递查询"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    //设置按钮
    [self.expressText addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    // 监听日期改变
    [MTNotificationCenter addObserver:self selector:@selector(cityDidChange:) name:MTCityDidChangeNotification object:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.expressText resignFirstResponder];
}
- (void)textChange
{
    self.searchButton.enabled = self.expressText.text.length;
}
#pragma mark - 监听通知
- (void)cityDidChange:(NSNotification *)notification
{
    self.expressComNo = notification.userInfo[MTSelectExpressNo];
    NSString *express = notification.userInfo[MTSelectExpress];
    [self.selectedButton setTitle:express forState:UIControlStateNormal];
}
- (IBAction)selectClick:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *path = @"http://v.juhe.cn/exp/com";
    
    NSDictionary *params = @{@"key":@"c901af3d909dc53071fe676823ff06ba"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        if (error_code == 0) {
            NSArray *expressArr = [Express objectArrayWithKeyValuesArray:responseObject[@"result"]];
            ExComSelectView *com = [[ExComSelectView alloc] init];
            com.expressComs = expressArr;
            UINavigationController *ui = [[UINavigationController alloc] initWithRootViewController:com];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self presentViewController:ui animated: YES completion:nil];
        } else {
            NSString *title = NSLocalizedString(@"查询失败", nil);
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
//    NSString *path = @"http://v.juhe.cn/exp/com";
//    NSString *api_id = @"43";
//    NSString *method = @"GET";
//    NSDictionary *param = nil;
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                            int error_code = [[responseObject objectForKey:@"error_code"] intValue];
//                            if (error_code == 0) {
//                                NSArray *expressArr = [Express objectArrayWithKeyValuesArray:responseObject[@"result"]];
//                                ExComSelectView *com = [[ExComSelectView alloc] init];
//                                com.expressComs = expressArr;
//                                UINavigationController *ui = [[UINavigationController alloc] initWithRootViewController:com];
//                                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                                [self presentViewController:ui animated: YES completion:nil];
//                            } else {
//                                NSString *title = NSLocalizedString(@"查询失败", nil);
//                                NSString *otherButtonTitle = NSLocalizedString(@"确认", nil);
//                                
//                                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
//                                
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

- (IBAction)searchClick:(id)sender
{
   [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *expressNo = self.expressText.text;
    
    NSString *path = @"http://v.juhe.cn/exp/index";
    
    NSDictionary *params = @{@"com":self.expressComNo, @"no": expressNo,@"key":@"c901af3d909dc53071fe676823ff06ba"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        if (error_code == 0) {
            NSArray *expressInfoArr = [ExpressInfo objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
            ExpressTableView *exView = [[ExpressTableView alloc] init];
            exView.expressInfos = expressInfoArr;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:exView animated:YES];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } else {
            NSString *title = NSLocalizedString(@"查询失败", nil);
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
//    NSString *path = @"http://v.juhe.cn/exp/index";
//    NSString *api_id = @"43";
//    NSString *method = @"GET";
//    NSDictionary *param = @{@"com":self.expressComNo, @"no": expressNo};
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                            int error_code = [[responseObject objectForKey:@"error_code"] intValue];
//                            if (error_code == 0) {
//                                NSArray *expressInfoArr = [ExpressInfo objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
//                                ExpressTableView *exView = [[ExpressTableView alloc] init];
//                                exView.expressInfos = expressInfoArr;
//                                self.hidesBottomBarWhenPushed = YES;
//                                [self.navigationController pushViewController:exView animated:YES];
//                                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                            } else {
//                                NSString *title = NSLocalizedString(@"查询失败", nil);
//                                NSString *otherButtonTitle = NSLocalizedString(@"确认", nil);
//                                
//                                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
//                                
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

@end

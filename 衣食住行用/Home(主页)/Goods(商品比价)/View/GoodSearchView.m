//
//  GoodSearchView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/28.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "GoodSearchView.h"
#import "MJExtension.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "MBProgressHUD.h"
#import "GoodInfo.h"
#import "GoodFirstView.h"
#import "MTConst.h"
#import "AFNetworking.h"

@interface GoodSearchView ()
/** 搜索按钮 */
@property (weak, nonatomic) IBOutlet UITextField *good;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation GoodSearchView

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"商品查询"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    
    [self.good becomeFirstResponder];
    self.searchButton.enabled = NO;
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    //设置按钮
    [self.good addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)textChange
{
    self.searchButton.enabled = self.good.text.length;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
      [self.good resignFirstResponder];
}
#pragma mark - 点击方法
- (IBAction)searchClick:(id)sender
{
    [self.good resignFirstResponder];
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //replace
    NSString *path = @"http://japi.juhe.cn/manmanmai/simple.from";
    
    NSDictionary *params = @{@"keyword": self.good.text,@"key":@"c6d58531e854a3ab09612c332fb87c7e"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
//        NSLog(@"%d", error_code);
//        if (error_code == 200) {
            NSArray *goodInfoArr = [GoodInfo objectArrayWithKeyValuesArray:responseObject[@"result"]];
            GoodFirstView *goodMneu = [[GoodFirstView alloc] init];
            goodMneu.goodLists = goodInfoArr;
            
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:goodMneu animated:YES];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
//        } else {
//            NSString *title = NSLocalizedString(@"没有此商品", nil);
//            NSString *otherButtonTitle = NSLocalizedString(@"确认", nil);
//            
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            }];
//            [alertController addAction:otherAction];
//            [self presentViewController:alertController animated:YES completion:nil];
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];
    //聚合相关
//    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:ZLJHOpenId];
//    NSString *path = @"http://api2.juheapi.com/mmb/search/simple";
//    NSString *api_id = @"137";
//    NSString *method = @"GET";
//    NSDictionary *param = @{@"keyword": self.good.text};
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                          int error_code = [[responseObject objectForKey:@"error_code"] intValue];
//                            if (error_code == 200) {
//                                NSArray *goodInfoArr = [GoodInfo objectArrayWithKeyValuesArray:responseObject[@"result"]];
//                                GoodFirstView *goodMneu = [[GoodFirstView alloc] init];
//                                goodMneu.goodLists = goodInfoArr;
//                            
//                                self.hidesBottomBarWhenPushed = YES;
//                                [self.navigationController pushViewController:goodMneu animated:YES];
//                                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                            } else {
//                                NSString *title = NSLocalizedString(@"没有此商品", nil);
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
//                          
//                        } Failure:^(NSError *error) {
//                            NSLog(@"error:   %@",error.description);
//                        }];

}
@end

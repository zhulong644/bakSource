//
//  BusLineView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/24.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "BusLineView.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "BusLine.h"
#import "MJExtension.h"
#import "Stats.h"
#import "BusLineDetailedView.h"
#import "MBProgressHUD.h"
#import "MTConst.h"
#import "AFNetworking.h"
#define ScreenWidth self.view.bounds.size.width
#define ScreenHeight self.view.bounds.size.height

@interface BusLineView ()
/** 城市 */
@property (weak, nonatomic) IBOutlet UITextField *cityText;
/** 公交线 */
@property (weak, nonatomic) IBOutlet UITextField *busNumber;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation BusLineView

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"线路查询"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    
    self.searchButton.enabled = NO;
    [self.cityText becomeFirstResponder];
    //设置按钮
    [self.cityText addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    [self.busNumber addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.cityText resignFirstResponder];
    [self.busNumber resignFirstResponder];
}
- (void)textChange
{
    self.searchButton.enabled = (self.cityText.text.length && self.busNumber.text.length);
}

#pragma mark - 公交路线点击方法

- (IBAction)busLineSearch:(id)sender
{
    [self.cityText resignFirstResponder];
    [self.busNumber resignFirstResponder];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //replace
    NSString *path = @"http://op.juhe.cn/189/bus/busline";
    NSString *city = self.cityText.text;
    NSString *bus = self.busNumber.text;
    
    NSDictionary *params = @{@"city":city, @"bus":bus,@"key":@"46322600f76504cd6c169c9ef7f8ad0d"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        if (!error_code) {
            
            NSArray *busLine = [BusLine objectArrayWithKeyValuesArray:responseObject[@"result"]];
            
            BusLineDetailedView *busView = [[BusLineDetailedView alloc] init];
            busView.busLine = busLine;
            
            [self.navigationController pushViewController:busView animated:YES];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }else{
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
//    
//    NSString *api_id = @"135";
//    NSString *method = @"GET";
//    NSString *city = self.cityText.text;
//    NSString *bus = self.busNumber.text;
//    NSDictionary *param = @{@"city":city, @"bus":bus};
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                            
//                            int error_code = [[responseObject objectForKey:@"error_code"] intValue];
//                            if (!error_code) {
//                                
//                                NSArray *busLine = [BusLine objectArrayWithKeyValuesArray:responseObject[@"result"]];
//                                
//                                BusLineDetailedView *busView = [[BusLineDetailedView alloc] init];
//                                busView.busLine = busLine;
//                                                                
//                                [self.navigationController pushViewController:busView animated:YES];
//
//                                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                                
//                            }else{
//                                NSString *title = NSLocalizedString(@"没有找到结果", nil);
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

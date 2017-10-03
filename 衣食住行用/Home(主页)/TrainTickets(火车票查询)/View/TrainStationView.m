//
//  TrainStationView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/26.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "TrainStationView.h"
#import "TrainNumber.h"
#import "MJExtension.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "MBProgressHUD.h"
#import "TrainStationFirstView.h"
#import "MTConst.h"
#import "AFNetworking.h"

@interface TrainStationView () <UITextFieldDelegate>
/** 搜索按钮 */

@property (weak, nonatomic) IBOutlet UITextField *startStation;
@property (weak, nonatomic) IBOutlet UITextField *endStation;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation TrainStationView

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"车站查询目"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    //设置按钮
    self.searchButton.enabled = NO;
    [self.searchButton setTitle:@"查询" forState:UIControlStateNormal];
    [self.searchButton setTitle:@"查询" forState:UIControlStateHighlighted];
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [self.startStation becomeFirstResponder];
    
    [self.startStation addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.endStation addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];

}
- (void)textChange
{
    self.searchButton.enabled = (self.startStation.text.length && self.endStation.text.length);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.startStation resignFirstResponder];
    [self.endStation resignFirstResponder];
}
- (IBAction)searchClick:(id)sender {
    [self.startStation resignFirstResponder];
    [self.endStation resignFirstResponder];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //replace
    NSString *path = @"http://apis.juhe.cn/train/s2swithprice";
    
    NSDictionary *params = @{@"start": self.startStation.text, @"end": self.endStation.text,@"key":@"fc25efc6fbe8f0e4873b5244f4e25066"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        NSLog(@"%d", error_code);
        if (!error_code) {
            NSArray *trainNumberArr = [TrainNumber objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
            TrainStationFirstView *trainStationFirstView = [[TrainStationFirstView alloc] init];
            trainStationFirstView.TrainNumberArray = trainNumberArr;
            [self.navigationController pushViewController:trainStationFirstView animated:YES];
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
//    NSString *path = @"http://apis.juhe.cn/train/s2swithprice";
//    NSString *api_id = @"22";
//    NSString *method = @"GET";
//    NSDictionary *param = @{@"start": self.startStation.text, @"end": self.endStation.text};
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                            int error_code = [[responseObject objectForKey:@"error_code"] intValue];
//                            NSLog(@"%d", error_code);
//                            if (!error_code) {
//                                NSArray *trainNumberArr = [TrainNumber objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
//                                TrainStationFirstView *trainStationFirstView = [[TrainStationFirstView alloc] init];
//                                trainStationFirstView.TrainNumberArray = trainNumberArr;                                
//                                [self.navigationController pushViewController:trainStationFirstView animated:YES];
//                                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                                
//                            } else {
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

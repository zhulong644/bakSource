//
//  TrainNumberView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/26.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "TrainNumberView.h"
#import "MJExtension.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "MBProgressHUD.h"
#import "TrainInfo.h"
#import "StationList.h"
#import "TrainNumberFirstView.h"
#import "MTConst.h"
#import "AFNetworking.h"
@interface TrainNumberView ()

@property (weak, nonatomic) IBOutlet UITextField *trainNumber;
@property (weak, nonatomic) IBOutlet UIButton *numberSearch;

@end

@implementation TrainNumberView
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"车次查询"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    //设置按钮
    self.numberSearch.enabled = NO;
    [self.numberSearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.numberSearch setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.numberSearch setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [self.trainNumber becomeFirstResponder];
    
    [self.trainNumber addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.trainNumber resignFirstResponder];
}
- (void)textChange
{
    self.numberSearch.enabled = (self.trainNumber.text.length);
}
#pragma mark - 车次点击方法
- (IBAction)searchClick:(id)sender
{
    [self.trainNumber resignFirstResponder];
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //replace
    NSString *path = @"http://apis.juhe.cn/train/s";
    
    NSDictionary *params = @{@"name": self.trainNumber.text,@"key":@"fc25efc6fbe8f0e4873b5244f4e25066"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        NSLog(@"%d", error_code);
        if (!error_code) {
            TrainInfo *trainInfo = [TrainInfo objectWithKeyValues:responseObject[@"result"][@"train_info"]];
            NSArray *stationListArr = [StationList objectArrayWithKeyValuesArray:responseObject[@"result"][@"station_list"]];
            
            TrainNumberFirstView *trainNumberFirstView = [[TrainNumberFirstView alloc] init];
            trainNumberFirstView.trainInfo = trainInfo;
            trainNumberFirstView.stationList = stationListArr;
            
            [self.navigationController pushViewController:trainNumberFirstView animated:YES];
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
//    NSString *path = @"http://apis.juhe.cn/train/s";
//    NSString *api_id = @"22";
//    NSString *method = @"GET";
//    NSDictionary *param = @{@"name": self.trainNumber.text};
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
//                            NSLog(@"%d", error_code);
//                        if (!error_code) {
//                            TrainInfo *trainInfo = [TrainInfo objectWithKeyValues:responseObject[@"result"][@"train_info"]];
//                            NSArray *stationListArr = [StationList objectArrayWithKeyValuesArray:responseObject[@"result"][@"station_list"]];
//                            
//                            TrainNumberFirstView *trainNumberFirstView = [[TrainNumberFirstView alloc] init];
//                            trainNumberFirstView.trainInfo = trainInfo;
//                            trainNumberFirstView.stationList = stationListArr;
//
//                            [self.navigationController pushViewController:trainNumberFirstView animated:YES];
//                            [MBProgressHUD hideHUDForView:self.view animated:YES];
//
//                        }else{
//                            NSString *title = NSLocalizedString(@"没有找到结果", nil);
//                            NSString *otherButtonTitle = NSLocalizedString(@"确认", nil);
//                            
//                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
//                            
//                            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                            }];
//                            [alertController addAction:otherAction];
//                            [self presentViewController:alertController animated:YES completion:nil];
//                            [MBProgressHUD hideHUDForView:self.view animated:YES];
//
//                        }
//                       } Failure:^(NSError *error) {
//                            NSLog(@"error:   %@",error.description);
//                       }];
}

@end

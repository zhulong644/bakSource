//
//  BusStationView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/25.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "BusStationView.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "Station.h"
#import "MJExtension.h"
#import "BusStationDetailedView.h"
#import "MBProgressHUD.h"
#import "MTConst.h"
#import "AFNetworking.h"
@interface BusStationView ()
/** 所在城市 */
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
/** 所在城市输入 */
@property (weak, nonatomic) IBOutlet UITextField *cityText;
/** 公交站台 */
@property (weak, nonatomic) IBOutlet UILabel *busStationLabel;
/** 公交站台输入 */
@property (weak, nonatomic) IBOutlet UITextField *busStationText;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation BusStationView

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景图片
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"公交站查询"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    
    self.searchButton.enabled = NO;
    [self.cityText becomeFirstResponder];
    //设置按钮
    [self.cityText addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    [self.busStationText addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.cityText resignFirstResponder];
    [self.busStationText resignFirstResponder];
}
- (void)textChange
{
    self.searchButton.enabled = (self.cityText.text.length && self.busStationText.text.length);
}
#pragma mark - 公交路线点击方法
- (IBAction)busStation:(id)sender
{
    [self.cityText resignFirstResponder];
    [self.busStationText resignFirstResponder];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *path = @"http://op.juhe.cn/189/bus/station";
    
    NSDictionary *params = @{@"city": self.cityText.text, @"station": self.busStationText.text,@"key":@"46322600f76504cd6c169c9ef7f8ad0d"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
        if (!error_code) {
            NSArray *station = [Station objectArrayWithKeyValuesArray:responseObject[@"result"]];
            BusStationDetailedView *stationView = [[BusStationDetailedView alloc] init];
            stationView.busStation = station;
            [self.navigationController pushViewController:stationView animated:YES];
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
//    NSDictionary *param = @{@"city": self.cityText.text, @"station": self.busStationText.text};
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                            int error_code = [[responseObject objectForKey:@"error_code"] intValue];
//                            if (!error_code) {
//                                NSArray *station = [Station objectArrayWithKeyValuesArray:responseObject[@"result"]];
//                                BusStationDetailedView *stationView = [[BusStationDetailedView alloc] init];
//                                stationView.busStation = station;
//                                [self.navigationController pushViewController:stationView animated:YES];
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
//                            
//                        } Failure:^(NSError *error) {
//                            NSLog(@"error:   %@",error.description);
//                        }];

}

@end

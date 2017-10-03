//
//  TrainTicketView.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/10/26.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "TrainTicketView.h"
#import "MJExtension.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "MBProgressHUD.h"
#import "TrainTicketFirstView.h"
#import "TrainTicket.h"
#import "CustomCalendarViewController.h"
#import "MTConst.h"
#import "AFNetworking.h"
@interface TrainTicketView ()

@property (weak, nonatomic) IBOutlet UITextField *startCity;

@property (weak, nonatomic) IBOutlet UITextField *toCiry;

@property (weak, nonatomic) IBOutlet UIButton *dateButton;

@property (weak, nonatomic) IBOutlet UIButton *outDayButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation TrainTicketView

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"余票查询"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    
    self.searchButton.enabled = NO;
    //设置按钮
    [self.startCity addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];

    [self.toCiry addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    // 监听日期改变
    [MTNotificationCenter addObserver:self selector:@selector(cityDidChange:) name:MTCityDidChangeNotification object:nil];
    //初始化日期
    NSData *date = [NSDate date];//获取当前的时间
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    //指定输出的格式   这里格式必须是和上面定义字符串的格式相同，否则输出空
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *timeString= [formatter stringFromDate:date];
    
    [self.dateButton setTitle:timeString forState:UIControlStateNormal];
    [self.dateButton setTitle:timeString forState:UIControlStateHighlighted];
    
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
//    [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [self.startCity becomeFirstResponder];
    
    [self.toCiry addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.startCity addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.startCity resignFirstResponder];
    [self.toCiry resignFirstResponder];
}
- (void)textChange
{
    self.searchButton.enabled = (self.startCity.text.length && self.toCiry.text.length);
}
#pragma mark - 监听通知
- (void)cityDidChange:(NSNotification *)notification
{
    NSString *date = notification.userInfo[MTSelectDate];
    [self.outDayButton setTitle:date forState:UIControlStateNormal];
}
#pragma mark - 按钮点击方法
- (IBAction)dateClick:(id)sender
{
    CustomCalendarViewController *customCalendarViewController = [[CustomCalendarViewController alloc] init];
    UINavigationController *ui = [[UINavigationController alloc] initWithRootViewController:customCalendarViewController];
    [ self presentViewController:ui animated: YES completion:nil];
}

#pragma mark - 余票点击方法

- (IBAction)ticketClick:(id)sender
{
    [self.startCity resignFirstResponder];
    [self.toCiry resignFirstResponder];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *dateTitle = [self.outDayButton titleForState:UIControlStateNormal];
    //replace
    NSString *path = @"http://apis.juhe.cn/train/yp";
    
    NSDictionary *params = @{@"from": self.startCity.text, @"to": self.toCiry.text, @"date": dateTitle,@"key":@"fc25efc6fbe8f0e4873b5244f4e25066"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        int error_code = [[responseObject objectForKey:@"error_code"] intValue];
//        if (!error_code) {
        
            NSArray *trainTicketArray = [TrainTicket objectArrayWithKeyValuesArray:responseObject[@"result"]];
            
            TrainTicketFirstView *trainTicketFirstView = [[TrainTicketFirstView alloc] init];
            trainTicketFirstView.trainTicketArray = trainTicketArray;
            
            [self.navigationController pushViewController:trainTicketFirstView animated:YES];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
//        }else{
//            NSString *title = NSLocalizedString(@"没有找到结果", nil);
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
//    NSString *path = @"http://apis.juhe.cn/train/yp";
//    NSString *api_id = @"22";
//    NSString *method = @"GET";
//    NSDictionary *param = @{@"from": self.startCity.text, @"to": self.toCiry.text, @"date": dateTitle};
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                            int error_code = [[responseObject objectForKey:@"error_code"] intValue];
//                            if (!error_code) {
//                              
//                                NSArray *trainTicketArray = [TrainTicket objectArrayWithKeyValuesArray:responseObject[@"result"]];
//                                
//                                TrainTicketFirstView *trainTicketFirstView = [[TrainTicketFirstView alloc] init];
//                                trainTicketFirstView.trainTicketArray = trainTicketArray;
//                                
//                                [self.navigationController pushViewController:trainTicketFirstView animated:YES];
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
//                        } Failure:^(NSError *error) {
//                            NSLog(@"error:   %@",error.description);
//                        }];
    

}

@end

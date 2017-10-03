//
//  GuaranteeViewController.m
//  口袋工具箱
//
//  Created by 朱龙 on 15/11/6.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "GuaranteeViewController.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "MBProgressHUD.h"
#import "MJExtension.h"
#import "Guarantee.h"
#import "GuaranteeTableView.h"
#import "MTConst.h"

@interface GuaranteeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *guaranteeNoText;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation GuaranteeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchButton.enabled = NO;
    [self.guaranteeNoText becomeFirstResponder];
    self.navigationItem.title = @"设备查询";
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    //设置按钮
    [self.guaranteeNoText addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.guaranteeNoText resignFirstResponder];
}
- (void)textChange
{
    self.searchButton.enabled = self.guaranteeNoText.text.length;
}
- (IBAction)searchClick:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *guaranteeNoText = self.guaranteeNoText.text;
    
    //聚合相关
    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:ZLJHOpenId];
    NSString *path = @"http://apis.juhe.cn/appleinfo/index";
    NSString *api_id = @"37";
    NSString *method = @"GET";
    NSDictionary *param = @{@"sn":guaranteeNoText};
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:path
                          APIID:api_id
                     Parameters:param
                         Method:method
                        Success:^(id responseObject){
                            int error_code = [[responseObject objectForKey:@"error_code"] intValue];
                            if (error_code == 0) {
                                Guarantee *guarantee = [Guarantee objectWithKeyValues:responseObject[@"result"]];
                                GuaranteeTableView *guaranteeTableView = [[GuaranteeTableView alloc] init];
                                guaranteeTableView.guarantee = guarantee;
                                [self.navigationController pushViewController:guaranteeTableView animated:YES];
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
                        } Failure:^(NSError *error) {
                            NSLog(@"error:   %@",error.description);
                        }];

}

@end

//
//  JuheTool.m
//  衣食住行用
//
//  Created by 朱龙 on 15/10/20.
//  Copyright © 2015年 朱龙. All rights reserved.
//

#import "JuheTool.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "MTConst.h"
@interface JuheTool ()

@property (nonatomic, strong) id responseObject;

@end
@implementation JuheTool
+ (id)responseObjectWithPath:(NSString *)path api_id:(NSString *)api_id method:(NSString *)method param:(NSDictionary *)param
{
    //聚合相关
    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:ZLJHOpenId];
    
    //    ***************** LIFE ***************
    //    /*IP*/
    path = @"http://web.juhe.cn:8080/constellation/getAll";
    api_id = @"58";
    method = @"GET";
    param = @{@"consName":@"处女座", @"type":@"today"};
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    id responseObject;

        [juheapi executeWorkWithAPI:path
                              APIID:api_id
                         Parameters:param
                             Method:method
                            Success:^(id responseObject){
                                responseObject = responseObject;
                            } Failure:^(NSError *error) {
                                NSLog(@"error:   %@",error.description);
                            }];

    responseObject = responseObject;
    return responseObject;
}
@end

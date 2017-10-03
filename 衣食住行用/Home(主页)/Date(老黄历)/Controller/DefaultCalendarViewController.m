

#import "DefaultCalendarViewController.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "Huang.h"
#import "MJExtension.h"
#import "HuangLiTableView.h"
#import "MTConst.h"
#import "AFNetworking.h"

#define ScreenWidth self.view.bounds.size.width
#define ScreenHeight self.view.bounds.size.height

@interface DefaultCalendarViewController ()

@property (nonatomic, strong) CalendarView * sampleView;

@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIView *myView;
@property (strong, nonatomic) HuangLiTableView *dateTable;
@property (strong, nonatomic) UILabel *infoLabel;
@property (nonatomic, strong) Huang *huang;

@end


@implementation DefaultCalendarViewController

#pragma mark - Init methods

//设定mainScrollView
- (UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        CGRect frame = CGRectMake( 0, 0, ScreenWidth, ScreenHeight);
        self.mainScrollView = [[UIScrollView alloc] initWithFrame: frame];
        self.mainScrollView.backgroundColor = [UIColor clearColor];
    }
    return _mainScrollView;
}
//设定myView
- (UIView *)myView
{
    if (!_myView) {
        self.myView = [[UIView alloc] init];
        self.myView.backgroundColor = [UIColor clearColor];
    }
    return _myView;
}
//提示
- (UILabel *)infoLabel
{
    if (!_infoLabel) {
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 330, ScreenWidth - 20, 20)];
        [infoLabel setText:@"(日历处左右滑动即可切换月份)"];
        [infoLabel setFont:[UIFont systemFontOfSize:14]];
        infoLabel.textAlignment = NSTextAlignmentCenter;
        self.infoLabel = infoLabel;
        [self.myView addSubview: self.infoLabel];
    }
    return _infoLabel;
}
//黄历信息表
- (HuangLiTableView *)dateTable
{
    if (!_dateTable) {
        HuangLiTableView *dateTable = [[HuangLiTableView alloc] init];
        dateTable.view.frame = CGRectMake(0, 360, ScreenWidth, 800);
        [self.myView addSubview:dateTable.view];
        [self addChildViewController:dateTable];
        dateTable.view.backgroundColor = [UIColor clearColor];
        self.dateTable = dateTable;
    }
    return _dateTable;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置图片背景
//      UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2013-09-16-19.55.18"]];
//    [self.view addSubview:imageView];
     self.view.backgroundColor = [UIColor whiteColor];
    //设置标题
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"黄历详细"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:17];
    self.navigationItem.titleView = customLab;
    //添加日历控件
    _sampleView= [[CalendarView alloc]initWithFrame:CGRectMake(0, 0, 320, 280)];
    _sampleView.delegate    = self;
    _sampleView.calendarDate = [NSDate date];
    dispatch_async(dispatch_get_main_queue(), ^{        
        [self.myView addSubview:_sampleView];
        _sampleView.center = CGPointMake(self.view.center.x, _sampleView.center.y);
        //主要设定
        CGRect frame02 = CGRectMake( 0, 0, ScreenWidth, 700);
        self.myView.frame = frame02;
        [self.mainScrollView addSubview:self.myView];
        [self.view addSubview:self.mainScrollView];
    });
    //提示
    [self infoLabel];
    //初始化日期
    NSDate *date = [NSDate date];//获取当前的时间
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    //指定输出的格式   这里格式必须是和上面定义字符串的格式相同，否则输出空
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *timeString= [formatter stringFromDate:date];
    //replace
    NSString *path = @"http://v.juhe.cn/laohuangli/d";
    
    NSDictionary *params = @{@"date": timeString,@"key":@"0cff2ec19c9fdcde10e5b3e0683db4f0"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        Huang *huang = [Huang objectWithKeyValues:responseObject[@"result"]];
        self.dateTable.huang = huang;
        self.mainScrollView.contentSize = CGSizeMake(ScreenWidth, self.dateTable.view.frame.size.height + 300);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];
    //聚合相关
//    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:ZLJHOpenId];
//    NSString *path = @"http://v.juhe.cn/laohuangli/d";
//    NSString *api_id = @"65";
//    NSString *method = @"GET";
//    NSDictionary *param = @{@"date": timeString};
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                            Huang *huang = [Huang objectWithKeyValues:responseObject[@"result"]];
//                            self.dateTable.huang = huang;
//                            self.mainScrollView.contentSize = CGSizeMake(ScreenWidth, self.dateTable.view.frame.size.height + 300);
//                        } Failure:^(NSError *error) {
//                            NSLog(@"error:   %@",error.description);
//                        }];

}

#pragma mark - CalendarDelegate protocol conformance

-(void)dayChangedToDate:(NSDate *)selectedDate
{

    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    //指定输出的格式   这里格式必须是和上面定义字符串的格式相同，否则输出空
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *timeString= [formatter stringFromDate:selectedDate];
    NSString *path = @"http://v.juhe.cn/laohuangli/d";
    
    NSDictionary *params = @{@"date": timeString,@"key":@"0cff2ec19c9fdcde10e5b3e0683db4f0"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
    [manager GET:path parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        Huang *huang = [Huang objectWithKeyValues:responseObject[@"result"]];
        self.dateTable.huang = huang;
        [self.dateTable.tableView reloadData];
        self.mainScrollView.contentSize = CGSizeMake(ScreenWidth, self.dateTable.view.frame.size.height + 300);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];

    //聚合相关
//    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:ZLJHOpenId];
//    
//    //    ***************** LIFE ***************
//    NSString *path = @"http://v.juhe.cn/laohuangli/d";
//    NSString *api_id = @"65";
//    NSString *method = @"GET";
//    NSString *date = timeString;
//    NSDictionary *param = @{@"date": date};
//    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
//    [juheapi executeWorkWithAPI:path
//                          APIID:api_id
//                     Parameters:param
//                         Method:method
//                        Success:^(id responseObject){
//                            Huang *huang = [Huang objectWithKeyValues:responseObject[@"result"]];
//                            self.dateTable.huang = huang;
//                            [self.dateTable.tableView reloadData];
//                            self.mainScrollView.contentSize = CGSizeMake(ScreenWidth, self.dateTable.view.frame.size.height + 300);
//                        } Failure:^(NSError *error) {
//                            NSLog(@"error:   %@",error.description);
//                        }];
}
@end

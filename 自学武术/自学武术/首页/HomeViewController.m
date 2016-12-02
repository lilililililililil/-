//
//  HomeViewController.m
//  自学武术
//
//  Created by 徐思遥 on 16/12/1.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//


#define FUWUQI @"http://m.wushu520.com"
//轮播图地址
#define ScrollViewURL(num) [NSString stringWithFormat:@"http://m.wushu520.com/static/img/tietu/hdp%d.jpg",num]
//首页地址
#define Home @"http://m.wushu520.com/Home/IndexForAPP"



#import "HomeViewController.h"

@interface HomeViewController ()



@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self requestData];
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)requestData{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"image/jpeg", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    [manager GET:Home parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray * picArray = [NSMutableArray array];
        
        for (NSDictionary * dic in [responseObject firstObject][@"list"]) {
            
            [picArray addObject:[FUWUQI stringByAppendingPathComponent:dic[@"pic"]]];
            
        }
        
        SDCycleScrollView * scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 74, ScreenWidth, 130) imageURLStringsGroup:picArray];
        [self.view addSubview:scrollView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

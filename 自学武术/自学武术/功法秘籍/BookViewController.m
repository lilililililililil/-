//
//  BookViewController.m
//  自学武术
//
//  Created by 李旺 on 2016/12/2.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import "BookViewController.h"
#import "MyScrollView.h"
@interface BookViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableview;

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    MyScrollView*scroll=[[MyScrollView alloc]initWithFrame:CGRectMake(0, 60, ScreenWidth, 300) titleArray:@[@"少林",@"1111",@"1111",@"1111",@"1111",@"1111",@"1111",@"1111",@"1111",@"1111",@"1111",@"1111",@"1111",@"1111",@"1111"] imageArray:@[@"首页",@"首页",@"首页",@"首页",@"首页",@"首页",@"首页",@"首页",@"首页",@"首页",@"首页",@"首页",@"首页",@"首页",@"首页"]];
    scroll.tiltelabel.text=@"     武林门派";
    
    
    [self.view addSubview:scroll];
    _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 360, ScreenWidth, ScreenHeight-360)];
    [self.view addSubview:_tableview];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)GetData{
    AFHTTPSessionManager*manager=[[AFHTTPSessionManager alloc]init];
    [manager GET:@"" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [_tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
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

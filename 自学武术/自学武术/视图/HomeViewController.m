//
//  HomeViewController.m
//  自学武术
//
//  Created by 李旺 on 2016/12/1.
//  Copyright © 2016年 项目二. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.tintColor=[UIColor grayColor];
    UIBarButtonItem*account=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"account" ] style:UIBarButtonItemStyleDone target:self action:@selector(accountway)];
    UIBarButtonItem*search=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search" ] style:UIBarButtonItemStyleDone target:self action:@selector(searchway)];
    self.navigationItem.rightBarButtonItems=@[search,account];
    
    
    // Do any additional setup after loading the view.
}
-(void)searchway{
    
}
-(void)accountway{
    
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

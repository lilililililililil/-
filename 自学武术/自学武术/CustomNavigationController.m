//
//  CustomNavigationController.m
//  自学武术
//
//  Created by 徐思遥 on 16/12/1.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import "CustomNavigationController.h"
#import "CustomNavigationBar.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage * searchImage = [UIImage imageNamed:@"Search.png"];
    UIImage * accountImage = [UIImage imageNamed:@"Account.png"];
    searchImage = [searchImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    accountImage = [accountImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem * search = [[UIBarButtonItem alloc] initWithImage:searchImage style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    UIBarButtonItem * account = [[UIBarButtonItem alloc] initWithImage:accountImage style:UIBarButtonItemStylePlain target:self action:@selector(account)];
    
    
    if ([self.viewControllers firstObject]) {
        
        UIViewController * viewC = self.viewControllers[0];
        viewC.navigationItem.rightBarButtonItems = @[account,search];
        
    }
    
    
    [self setupNavigationBar];
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)setupNavigationBar{
    
    [self setValue:[[CustomNavigationBar alloc] init] forKeyPath:@"NavigationBar"];
    
}

- (void)search{
    
    
    
    
    
}

- (void)account{
    
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

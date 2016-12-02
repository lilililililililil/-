//
//  TabBarViewController.m
//  自学武术
//
//  Created by 徐思遥 on 16/12/1.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import "TabBarViewController.h"
#import "CustomNavigationController.h"

#import "HomeViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    
    [self setupChildVCs];
    
    [self setupItems];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)setupChildVCs{
    
    [self addChildVC:[[HomeViewController alloc] init] title:@"首页" image:@"首页"];
    
    
    
    
    
    
}

- (void)addChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image{
    
    CustomNavigationController * nav = [[CustomNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    [nav viewDidLoad];
    
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:image];
    
}

- (void)setupItems{
    
    UITabBarItem * item = [UITabBarItem appearance];
    
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateSelected];
    
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

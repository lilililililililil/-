//
//  MynavigationViewController.m
//  自学武术
//
//  Created by 李旺 on 2016/12/1.
//  Copyright © 2016年 项目二. All rights reserved.
//

#import "MynavigationViewController.h"

@interface MynavigationViewController ()

@end

@implementation MynavigationViewController
//-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
//    if(self==[super initWithRootViewController:rootViewController]){
//    UIImage*backimage=[UIImage imageNamed:@"logo"];
//    UIImageView*backimageview=[[UIImageView alloc]initWithImage:backimage];
//    backimageview.frame=CGRectMake(0, 0, backimageview.frame.size.width,self.navigationBar.frame.size.height);
//    backimageview.backgroundColor=[UIColor redColor];
//    [self.navigationBar addSubview:backimageview];
//    UIBarButtonItem*account=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"account" ] style:UIBarButtonItemStyleDone target:self action:@selector(accountway)];
//    UIBarButtonItem*search=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search" ] style:UIBarButtonItemStyleDone target:self action:@selector(searchway)];
//    self.navigationBar.items=@[search,account];
//    }
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage*backimage=[UIImage imageNamed:@"logo"];
    UIImageView*backimageview=[[UIImageView alloc]initWithImage:backimage];
    backimageview.frame=CGRectMake(0, 0, backimageview.frame.size.width,self.navigationBar.frame.size.height);
    backimageview.backgroundColor=[UIColor redColor];
    //[self.navigationBar addSubview:backimageview];
    UIButton*account=[UIButton buttonWithType:UIButtonTypeCustom];
    [account setBackgroundImage:[UIImage imageNamed:@"account"] forState:UIControlStateNormal];
    account.frame=CGRectMake(200, 0, self.navigationBar.frame.size.height, self.navigationBar.frame.size.height);
    [self.navigationBar addSubview:account];
    //self.navigationItem.rightBarButtonItem=search;
    
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

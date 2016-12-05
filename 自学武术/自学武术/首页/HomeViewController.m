//
//  HomeViewController.m
//  自学武术
//
//  Created by 徐思遥 on 16/12/1.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//


//服务器地址
#define FUWUQI @"http://m.wushu520.com"
//轮播图地址
#define ScrollViewURL(num) [NSString stringWithFormat:@"http://m.wushu520.com/static/img/tietu/hdp%d.jpg",num]
//首页地址
#define Home @"http://m.wushu520.com/Home/IndexForAPP"


#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "MJExtension.h"
#import "HomeHeaderView.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView * tableView;

//武林资讯
@property (nonatomic, strong)NSArray * infoArray;
//最新功法
@property (nonatomic, strong)NSArray * cheatArray;
//武术百科
@property (nonatomic, strong)NSArray * encyclopediaArray;
//论武堂
@property (nonatomic, strong)NSArray * commentArray;

@end

static NSString * const reuseIden = @"HomeCell";
static NSString * const HeaderId = @"header";
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self requestData];
    
    
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //[_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseIden];
    [_tableView registerClass:[HomeHeaderView class] forHeaderFooterViewReuseIdentifier:HeaderId];
    
    [self.view addSubview:_tableView];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)requestData{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"image/jpeg", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    WeakSelf;
    [manager GET:Home parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray * picArray = [NSMutableArray array];
        for (NSDictionary * dic in [responseObject firstObject][@"list"]) {
            [picArray addObject:[FUWUQI stringByAppendingPathComponent:dic[@"pic"]]];
        }
        
        SDCycleScrollView * scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 10, ScreenWidth, 130) imageURLStringsGroup:picArray];
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 150)];
        view.backgroundColor = [UIColor lightGrayColor];
        
        [view addSubview:scrollView];
        weakSelf.tableView.tableHeaderView = view;
        
        //四种信息数组
        weakSelf.infoArray = [HomeModel mj_objectArrayWithKeyValuesArray:responseObject[1][@"list"]];
        weakSelf.cheatArray = [HomeModel mj_objectArrayWithKeyValuesArray:responseObject[2][@"list"]];
        weakSelf.encyclopediaArray = [HomeModel mj_objectArrayWithKeyValuesArray:responseObject[3][@"list"]];
        weakSelf.commentArray = responseObject[4][@"list"];
        
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}


#pragma marks <UITableView dataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3) {
        
        NSString * str = self.commentArray[indexPath.row][@"topic_title"];
        return [HomeTableViewCell heightForString:str] + 44;
    }
    if (indexPath.row == 7) {
        return 40;
    }
    
    return 85;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return self.infoArray.count / 2 + 1;
    }else if (section == 1){
        
        return self.cheatArray.count / 2 + 1;
    }else if (section == 2) {
        
        return self.encyclopediaArray.count / 2 + 1;
    }else if (section == 3) {
        
        return self.commentArray.count / 2 + 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIden];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HomeTableViewCell class]) owner:nil options:nil] lastObject];
    }else{ // 防止重用
        while ([cell.contentView.subviews lastObject] != nil) {
        [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    
    if (indexPath.row == 7) {
        for (UIView * view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        
        UIImageView * down = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down"]];
        [cell.contentView addSubview:down];
        [down mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell.contentView);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
        }];
        
        return cell;
    }
    
    if (indexPath.section == 0) {
        
        cell.model = self.infoArray[indexPath.row];
    }else if (indexPath.section == 1) {
        
        cell.model = self.cheatArray[indexPath.row];
    }else if (indexPath.section == 2) {
        
        cell.model = self.encyclopediaArray[indexPath.row];
    }else if (indexPath.section == 3) {
        //移除不需要的子视图 并改变约束
        [cell.cellImageView removeFromSuperview];
        [cell.seeImage removeFromSuperview];
        [cell.seeCountLabel removeFromSuperview];
        cell.trailingSpace.constant = 30;

        NSDictionary * dic = self.commentArray[indexPath.row];
        cell.titleLabel.text = dic[@"topic_title"];
        cell.subTitle.text = dic[@"topic_add_user"];
        cell.commentCountLabel.text = [NSString stringWithFormat:@"%@",dic[@"topic_reply_count"]];
    }
    
    
    return cell;
}

#pragma marks delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    HomeHeaderView * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderId];
    
    if (section == 0) {
        header.text = @"武林资讯";
    }else if (section == 1) {
        header.text = @"最新功法";
    }else if (section == 2) {
        header.text = @"武术百科";
    }else if (section == 3) {
        header.text = @"论武堂";
    }
    
    
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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

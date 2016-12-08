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

#import "MoreInfoViewController.h"
#import "CycleImageViewController.h"
#import "DetailViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, strong)UITableView * tableView;

//武林资讯
@property (nonatomic, strong)NSMutableArray * showInfoArray;
@property (nonatomic, strong)NSArray * infoArray;
//最新功法
@property (nonatomic, strong)NSMutableArray * showCheatArray;
@property (nonatomic, strong)NSArray * cheatArray;
//武术百科
@property (nonatomic, strong)NSMutableArray * showEncyclopediaArray;
@property (nonatomic, strong)NSArray * encyclopediaArray;
//论武堂
@property (nonatomic, strong)NSMutableArray * showCommentArray;
@property (nonatomic, strong)NSArray * commentArray;

//包含四组数据的总数组
@property (nonatomic, strong)NSArray * showDataArray;
@property (nonatomic, strong)NSArray * dataArray;
//最外层字典
@property (nonatomic, strong)NSArray * outDicArray;

@end

static NSString * const reuseIden = @"HomeCell";
static NSString * const HeaderId = @"header";
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showInfoArray = [NSMutableArray array];
    self.showCheatArray = [NSMutableArray array];
    self.showEncyclopediaArray = [NSMutableArray array];
    self.showCommentArray = [NSMutableArray array];
    
    self.showDataArray = @[self.showInfoArray,self.showCheatArray,self.showEncyclopediaArray,self.showCommentArray];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self requestData];
    
    [self setupTableView];
    
    
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
        scrollView.delegate = self;
        
        [view addSubview:scrollView];
        weakSelf.tableView.tableHeaderView = view;
        
        //四种信息数组
        weakSelf.infoArray = [HomeModel mj_objectArrayWithKeyValuesArray:responseObject[1][@"list"]];
        for (int i = 0; i < weakSelf.infoArray.count/2; i ++) {
            [weakSelf.showInfoArray addObject:weakSelf.infoArray[i]];
        }
        weakSelf.cheatArray = [HomeModel mj_objectArrayWithKeyValuesArray:responseObject[2][@"list"]];
        for (int i = 0; i < weakSelf.cheatArray.count/2; i ++) {
            [weakSelf.showCheatArray addObject:weakSelf.cheatArray[i]];
        }
        weakSelf.encyclopediaArray = [HomeModel mj_objectArrayWithKeyValuesArray:responseObject[3][@"list"]];
        for (int i = 0; i < weakSelf.encyclopediaArray.count/2; i ++) {
            [weakSelf.showEncyclopediaArray addObject:weakSelf.encyclopediaArray[i]];
        }
        weakSelf.commentArray = responseObject[4][@"list"];
        for (int i = 0; i < weakSelf.commentArray.count/2; i ++) {
            [weakSelf.showCommentArray addObject:weakSelf.commentArray[i]];
        }
        
        weakSelf.dataArray = [@[weakSelf.infoArray,weakSelf.cheatArray,weakSelf.encyclopediaArray,weakSelf.commentArray] mutableCopy];
        weakSelf.outDicArray = responseObject;
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}


- (void)setupTableView{
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //[tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseIden];
    [tableView registerClass:[HomeHeaderView class] forHeaderFooterViewReuseIdentifier:HeaderId];
    
    [self.view addSubview:tableView];
}


#pragma marks <UITableView dataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3) {
        if (indexPath.row == self.showCommentArray.count)return 40;
        
        NSString * str = self.commentArray[indexPath.row][@"topic_title"];
        return [HomeTableViewCell heightForString:str] + 44;
    }
    
    if (indexPath.row == [self.showDataArray[indexPath.section] count])return 40;
    
    return 85;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.showDataArray[section] count] + 1;
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
    
    
    if (indexPath.row == [self.showDataArray[indexPath.section] count]) {
        for (UIView * view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        
        if (indexPath.row == 14) {
            UIButton * seeMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [seeMoreButton setTitle:@"查看更多" forState:UIControlStateNormal];
            seeMoreButton.titleLabel.font = [UIFont systemFontOfSize:16];
            [seeMoreButton setTitleColor:[UIColor colorWithRed:57 / 256.0 green:169 / 256.0 blue:231 / 256.0 alpha:1.0] forState:UIControlStateNormal];
            [seeMoreButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
            [seeMoreButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
            [seeMoreButton setTitleEdgeInsets:UIEdgeInsetsMake(0, cell.contentView.width/2 - 70, 0, cell.contentView.width/2 - 30)];
            [seeMoreButton setImageEdgeInsets:UIEdgeInsetsMake(0, cell.contentView.width/2 + 20, 0, cell.contentView.width/2 - 40)];
            seeMoreButton.tag = 1000 + indexPath.section;
            [seeMoreButton addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:seeMoreButton];
            [seeMoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(cell.contentView);
                make.size.equalTo(cell.contentView);
            }];
        }else{
            UIImageView * down = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down"]];
            [cell.contentView addSubview:down];
            [down mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(cell.contentView);
                make.width.equalTo(@50);
                make.height.equalTo(@30);
            }];
        }
        
        return cell;
    }
    
    
    if (indexPath.section == 0) {
        if (self.showInfoArray.count > 1) {
            cell.model = self.showInfoArray[indexPath.row];
        }
    }else if (indexPath.section == 1) {
        if (self.cheatArray.count > 1) {
        cell.model = self.cheatArray[indexPath.row];
        }
    }else if (indexPath.section == 2) {
        if (self.encyclopediaArray.count > 1) {
        cell.model = self.encyclopediaArray[indexPath.row];
        }
    }else if (indexPath.section == 3) {
        if (self.commentArray.count > 1) {
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
    }
    
    
    return cell;
}

#pragma marks delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    HomeHeaderView * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderId];
    
    header.text = self.outDicArray[section + 1][@"desc"];
    header.moreButton.tag = 2000 + section;
    [header.moreButton addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [self.showDataArray[indexPath.section] count]) {
        [self.showDataArray[indexPath.section] removeAllObjects];
        [self.showDataArray[indexPath.section] addObjectsFromArray:self.dataArray[indexPath.section]];
        [self.tableView reloadData];
    }
    
    
}


//更多信息
- (void)more:(UIButton *)sender{
    
    MoreInfoViewController * more = [[MoreInfoViewController alloc] init];
    NSInteger temTag = sender.tag;
    if (sender.tag < 2000) {
        temTag += 1000;
    }
    NSDictionary * dic = self.outDicArray[temTag - 2000 + 1];
    more.type = dic[@"type"];
    more.desc = dic[@"desc"];
    more.link = dic[@"link"];
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:more];
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:nav animated:YES completion:nil];
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    if (index == 3) {
        DetailViewController * detail = [[DetailViewController alloc] init];
        detail.link = self.outDicArray[0][@"list"][index][@"link"];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:detail];
        nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        
        [self presentViewController:nav animated:YES completion:nil];
    }else{
    
        CycleImageViewController * cycle = [[CycleImageViewController alloc] init];
        cycle.link = self.outDicArray[0][@"list"][index][@"link"];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:cycle];
        nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
        [self presentViewController:nav animated:YES completion:nil];
    }
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

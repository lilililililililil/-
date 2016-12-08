//
//  CycleImageViewController.m
//  自学武术
//
//  Created by 徐思遥 on 16/12/6.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import "CycleImageViewController.h"
#import "CIVCTableViewHeader.h"
#import "WriteTableViewCell.h"
#import <WebKit/WebKit.h>

@interface CycleImageViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property (nonatomic, weak)AFHTTPSessionManager * manager;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSDictionary * dataDic;
//目录数组
@property (nonatomic, strong)NSArray * catalogArray;
//表头视图
@property (nonatomic, strong)CIVCTableViewHeader * tableHeader;
//评论网页
@property (nonatomic, strong)WKWebView * webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;

@end

static NSString * const catalogCell = @"catalog";
static NSString * const writeComment = @"write";
static NSString * const comment = @"comment";
@implementation CycleImageViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"介绍&目录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    [self setupTable];
    
    [self requestData];
    //点击tableView键盘消失
    [self setUpForDismissKeyboard];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)setUpForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note){
        [self.tableView addGestureRecognizer:singleTapGR];
    }];
    [nc addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note){
        [self.tableView removeGestureRecognizer:singleTapGR];
    }];
}
- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.tableView里所有的subview的first responder都resign掉
    //[self.tableView endEditing:YES];
    NSUInteger index[] = {1,0};
    NSIndexPath * indexPath = [[NSIndexPath alloc] initWithIndexes:index length:2];
    WriteTableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    //[cell.textView resignFirstResponder];
    [cell.textView endEditing:YES];
}

- (void)requestData{
    
    NSArray * linkArr = [self.link componentsSeparatedByString:@"?"];
    if ([self.link hasPrefix:@"info-catalog"]) {
        NSString * url = [@"http://m.wushu520.com/Info/CatalogForAPP?" stringByAppendingString:linkArr[1]];
        
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        
        WeakSelf;
        [self.manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
            weakSelf.dataDic = responseObject;
            weakSelf.catalogArray = responseObject[@"catalog"];
            if (responseObject[@"info"][@"info_reply_count"]) {
                [weakSelf requestCommentDataWithID:linkArr[1]];
            }
            
            CIVCTableViewHeader * tableHeader = [CIVCTableViewHeader viewFromXib];
            NSDictionary * dic = responseObject[@"info"];
            [tableHeader.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.wushu520.com%@",dic[@"info_img_path"]]]];
            tableHeader.titleLabel.text = dic[@"info_title"];
            tableHeader.authorLabel.text = @"作者/来源 : 中华武术网";
            
//            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
//            NSDate * date = [formatter dateFromString:dic[@"info_last_edit_time"]];
            NSArray * time = [dic[@"info_last_edit_time"] componentsSeparatedByString:@"T"];
            NSArray * time1 = [time[1] componentsSeparatedByString:@"."];
            tableHeader.timeLabel.text = [NSString stringWithFormat:@"最后更新时间 : %@ %@",time[0],time1[0]];
            tableHeader.desLabel.text = dic[@"info_des"];
            _tableHeader = tableHeader;
            UIView * view = [[UIView alloc] init];
            view.height = tableHeader.height + 80;
            view.width = tableHeader.width;
            [view addSubview:tableHeader];
            
            UIButton * unfoldButton = [UIButton createButtonWithType:UIButtonTypeCustom frame:CGRectNull title:@"展开" selectedTitle:@"收起" font:[UIFont systemFontOfSize:16] image:@"展开" selectedImage:@"收起" target:self select:@selector(unfold:)];
            [unfoldButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [unfoldButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
            [unfoldButton setImageEdgeInsets:UIEdgeInsetsMake(0, 55, 0, 0)];
            [view addSubview:unfoldButton];
            [unfoldButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@80);
                make.height.equalTo(@30);
                make.right.equalTo(view.mas_right).offset(-20);
                make.top.equalTo(tableHeader.desLabel.mas_bottom).offset(10);
            }];
            weakSelf.tableView.tableHeaderView = view;
            
            [weakSelf.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
    
}
//请求评论数据
- (void)requestCommentDataWithID:(NSString *)ID{
    
    NSString * url = [NSString stringWithFormat:@"http://m.wushu520.com/Topic/GetCommentList?%@&page=1&reply_type=2",ID];
    
    WKWebView * webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    self.webView = webView;
    [webView loadRequest:request];
    
}

- (void)setupTable{
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:catalogCell];
    //[self .tableView registerNib:[UINib nibWithNibName:@"WriteTableViewCell" bundle:nil] forCellReuseIdentifier:writeComment];
    
    
}

#pragma mark - 监听键盘位置的变化,从而改变下册输入条的位置
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    self.bottomSpace.constant = ScreenHeight - [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
}


#pragma marks <UITableView DataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 100;
        }else{
            return self.webView.height;
        }
    }
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return self.catalogArray.count;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:catalogCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:catalogCell];
    }else{
        while ([cell.contentView.subviews lastObject] != nil){
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = self.catalogArray[indexPath.row][@"info_title"];
        cell.textLabel.textColor = [UIColor blueColor];
        
        return cell;
    }
    
    WriteTableViewCell * writeCell = [tableView dequeueReusableCellWithIdentifier:writeComment];
    if (writeCell == nil) {
        writeCell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WriteTableViewCell class]) owner:nil options:nil] lastObject];;
    }else{
        while ([writeCell.contentView.subviews lastObject] != nil) {
            [(UIView *)[writeCell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            writeCell.textView.delegate = self;
            [writeCell.publishButton addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchUpInside];
            return writeCell;
        }else{
            
            [cell addSubview:self.webView];
            return cell;
        }
        
    }
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        return @"目录";
    }
    return @"武友评论";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

//发表评论
- (void)publish{
    NSUInteger index[] = {1,0};
    NSIndexPath * indexPath = [[NSIndexPath alloc] initWithIndexes:index length:2];
    WriteTableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell.textView.text.length == 0 || [cell.textView.text isEqualToString:@"说说你的看法..."]) {
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        [cell.textView becomeFirstResponder];
        
        UIMenuController * menu = [UIMenuController sharedMenuController];
        menu.menuItems = @[[[UIMenuItem alloc] initWithTitle:@"内容不能为空" action:@selector(content)]];
        CGRect rect = CGRectMake(ScreenWidth/3, 20, ScreenWidth/3, ScreenHeight/8);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }else{
        
        NSString * str0 = [NSString urlEncodingWithString:cell.textView.text];
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[@"reply_type"] = @"2";
        dic[@"relate_id"] = self.dataDic[@"info"][@"info_id"];
        dic[@"parent_id"] = self.dataDic[@"info"][@"info_parent_id"];
        dic[@"content"] = str0;
        
        WeakSelf;
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html", nil];
        [self.manager POST:@"http://m.wushu520.com/Topic/AddTopicReply" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"成功");
            [weakSelf requestData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"%@",error);
            [weakSelf requestData];
        }];
        
    }
}
- (void)content{
}
//评论
- (IBAction)comment:(id)sender {
    NSUInteger index[] = {1,0};
    NSIndexPath * indexPath = [[NSIndexPath alloc] initWithIndexes:index length:2];
    
    WriteTableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    [cell.textView becomeFirstResponder];
    
}
//收藏
- (IBAction)collect:(id)sender {
}

#pragma marks <UITextViewDelegate>
- (void)textViewDidBeginEditing:(UITextView *)textView{
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
    
    NSUInteger index[] = {1,0};
    NSIndexPath * indexPath = [[NSIndexPath alloc] initWithIndexes:index length:2];
    //WriteTableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        textView.text = @"说说你的看法...";
        textView.textColor = [UIColor lightGrayColor];
    }
}

//点击屏幕任一点
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSUInteger index[] = {1,0};
    NSIndexPath * indexPath = [[NSIndexPath alloc] initWithIndexes:index length:2];
    
    WriteTableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell.textView resignFirstResponder];
    //[cell.textView endEditing:YES];
}


//展开&收起
- (void)unfold:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    if (sender.selected == YES) {
        self.tableHeader.desLabel.textColor = [UIColor blackColor];
        self.tableHeader.desLabel.numberOfLines = 0;
    }else{
        self.tableHeader.desLabel.textColor = [UIColor lightGrayColor];
        self.tableHeader.desLabel.numberOfLines = 6;
    }
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
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

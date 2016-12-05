//
//  MyScrollView.m
//  自学武术
//
//  Created by 李旺 on 2016/12/2.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import "MyScrollView.h"


@implementation MyScrollView
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray*)titlearray imageArray:(NSArray*)imagearray{
    if (self=[super init]) {
        self.backgroundColor=[UIColor grayColor];
        self.frame=frame;
        self.titleArray=titlearray;
        self.imageArray=imagearray;
        self.customscroll=[[UIScrollView alloc]init];
        int pagetotal=(int)_titleArray.count/15+(_titleArray.count%15==0?0:1);
        _customscroll.contentSize=CGSizeMake(414*pagetotal,270);
        _customscroll.delegate=self;
        _customscroll.frame=CGRectMake(0,60, frame.size.width, frame.size.height-60);
        _customscroll.height=frame.size.height-30;
        _customscroll.pagingEnabled=YES;
        _customscroll.showsVerticalScrollIndicator=NO;
        _customscroll.showsHorizontalScrollIndicator=NO;
        _customscroll.backgroundColor=[UIColor whiteColor];
        //titlebutton
        _titlebutton=[UIButton buttonWithType:UIButtonTypeCustom];
        _titlebutton.frame=CGRectMake(300, 0, 414, 59);
        _titlebutton.backgroundColor=[UIColor whiteColor];
        _titlebutton.userInteractionEnabled=NO;
        //默认隐藏
        [self addSubview:_titlebutton];
        //titlelabel
        _tiltelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 59)];
        _tiltelabel.backgroundColor=[UIColor whiteColor];
        
        [self addSubview:_tiltelabel];
        
        NSArray*title=[NSArray array];
        NSArray*image=[NSArray array];
        
        
        //buttons
        for (int page=1; page<=pagetotal; page++) {
            if (pagetotal==1) {
                title=_titleArray;
                image=_imageArray;
                
            }else{
                if (page<pagetotal&&page>=1) {
                    title=[_titleArray subarrayWithRange:NSMakeRange((page-1)*15, 15)];
                    image=[_imageArray subarrayWithRange:NSMakeRange((page-1)*15, page*15+15)];
                }else {
                    title=[_titleArray subarrayWithRange:NSMakeRange((page-1)*15, _titleArray.count%15==0?15:_titleArray.count%15)];
                    image=[_imageArray subarrayWithRange:NSMakeRange(page*15-15, _titleArray.count%15)];
                }
            }
            for (int a=0; a<title.count; a++) {
                CustomButton*button=[[CustomButton alloc]initWithFrame:CGRectMake((a%5)*(414/5.0)+(page-1)*414, (a/5)*(414/5)+10*(a/5+1), 414/5.0, 414/5.0)];
                [button setTitle:title[a] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:image[a]] forState:UIControlStateNormal];
                //button.backgroundColor=[UIColor redColor];
                
                [_customscroll addSubview:button];
            
            }
        }
        //pagecontrol
        _pagecontrol=[[UIPageControl alloc]init];
        _pagecontrol.frame=CGRectMake(0, _customscroll.height+_customscroll.y, ScreenWidth, 30);
        
        _pagecontrol.pageIndicatorTintColor=[UIColor grayColor];
        _pagecontrol.tintColor=[UIColor whiteColor];
        _pagecontrol.backgroundColor=[UIColor redColor];
        _pagecontrol.numberOfPages=pagetotal;
        [_pagecontrol addTarget:self action:@selector(pageing) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pagecontrol];
        
        
    }
    
    [self addSubview: _customscroll];
    return  self;
}
-(void)pageing{
    _customscroll.contentOffset=CGPointMake(_pagecontrol.currentPage*411, 0);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _pagecontrol.currentPage=_customscroll.contentOffset.x/414;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  CustomScrollView.m
//  自学武术
//
//  Created by 李旺 on 2016/12/1.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import "CustomScrollView.h"

@implementation CustomScrollView
//-(instancetype)initWithFrame:(CGRect)frame{
//    
//    return  self;
//}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    NSArray*title=[NSArray array];
    NSArray*image=[NSArray array];
    int pagetotal=(int)_titleArray.count/15+(_titleArray.count%15==0?0:1);
    self.contentSize=CGSizeMake(414*pagetotal,270);
    for (int page=1; page<=pagetotal; page++) {
        if (pagetotal==1) {
            title=_titleArray;
            image=_imageArray;
            
        }else if (page<pagetotal&&page>1) {
                title=[_titleArray subarrayWithRange:NSMakeRange(page*15, page*15+14)];
                image=[_imageArray subarrayWithRange:NSMakeRange(page*15, page*14)];
        }else {
                title=[_titleArray subarrayWithRange:NSMakeRange(page*15, _titleArray.count)];
                image=[_imageArray subarrayWithRange:NSMakeRange(page*15, _titleArray.count)];
        }
        
        for (int a=0; a<title.count; a++) {
            CustomButton*button=[[CustomButton alloc]initWithFrame:CGRectMake((a%5)*(414/6)+10*(a%5+1), (a/5)*70+10*(a/5+1), 70, 70)];
            button.tag=100+a;
            
            [button setTitle:title[a] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:image[a]] forState:UIControlStateNormal];
            
            button.layer.cornerRadius=35;
            button.layer.masksToBounds=YES;
            
            [self addSubview:button];
            
            
        }
    }


    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

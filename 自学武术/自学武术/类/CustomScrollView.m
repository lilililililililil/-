//
//  CustomScrollView.m
//  自学武术
//
//  Created by 李旺 on 2016/12/1.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import "CustomScrollView.h"

@implementation CustomScrollView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self==[super initWithFrame:frame]){
        self.contentSize=CGSizeMake(414*3, 100);
        for (int a=0; a<_titleArray.count; a++) {
            
            
            
        }
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

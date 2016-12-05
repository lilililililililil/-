//
//  CustomButton.m
//  自学武术
//
//  Created by 李旺 on 2016/12/1.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame=CGRectMake(0, 0, self.width*0.6, self.width*0.6);
    self.imageView.centerX=self.width/2;
    self.imageView.layer.cornerRadius=self.imageView.width/2.0;
    self.imageView.layer.masksToBounds=YES;
    
    self.titleLabel.width = self.frame.size.width;
    self.titleLabel.y = self.height-self.imageView.height;
    self.titleLabel.x = 0;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

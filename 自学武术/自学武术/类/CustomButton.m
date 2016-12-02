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
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.imageView.image=[UIImage imageNamed:@"logo"];
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.y = 0;
    self.imageView.width = 50;
    self.imageView.height = 50;
    self.imageView.centerX = self.frame.size.width * 0.5;
    self.titleLabel.width = self.frame.size.width;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.x = 0;
    self.titleLabel.height = self.frame.size.height - self.titleLabel.y;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

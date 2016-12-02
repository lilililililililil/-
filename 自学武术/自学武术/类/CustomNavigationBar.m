//
//  CustomNavigationBar.m
//  自学武术
//
//  Created by 徐思遥 on 16/12/2.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import "CustomNavigationBar.h"

@interface CustomNavigationBar ()
//logo
@property (nonatomic, strong)UIImageView * logoImageView;

@end

@implementation CustomNavigationBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.barTintColor = [UIColor whiteColor];
        
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        [_logoImageView sizeToFit];
        
        [self addSubview:_logoImageView];
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    _logoImageView.frame = CGRectMake(20, 5, width/3, height - 10);
    
}


@end

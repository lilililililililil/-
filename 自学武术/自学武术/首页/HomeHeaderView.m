//
//  HomeHeaderView.m
//  自学武术
//
//  Created by 徐思遥 on 16/12/2.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import "HomeHeaderView.h"

@interface HomeHeaderView ()
//显示文字的label
@property (nonatomic, weak)UILabel * label;

@end

@implementation HomeHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel * label = [[UILabel alloc] init];
        self.label = label;
        self.label.font = [UIFont systemFontOfSize:20];
        self.label.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.label];
        
        WeakSelf;
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.centerY.equalTo(weakSelf);
            //make.width.equalTo(@200);
        }];
        
        
        self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.moreButton setTitle:@"更多" forState:UIControlStateNormal];
        [self.moreButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        self.moreButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.moreButton setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
        [self.moreButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 15)];
        [self.moreButton setImageEdgeInsets:UIEdgeInsetsMake(0, 48, 0, 0)];
        [self.contentView addSubview:self.moreButton];
        
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-15);
            make.centerY.equalTo(weakSelf);
            make.width.equalTo(@65);
        }];
        
    }
    
    return self;
}

- (void)setText:(NSString *)text{
    
    _text = text;
    
    self.label.text = text;
}


@end

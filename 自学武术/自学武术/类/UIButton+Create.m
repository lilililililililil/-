//
//  UIButton+Create.m
//  自学武术
//
//  Created by 徐思遥 on 16/12/6.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import "UIButton+Create.h"

@implementation UIButton (Create)

+ (instancetype)createButtonWithType:(UIButtonType)type frame:(CGRect)rect title:(NSString *)title selectedTitle:(NSString *)selectedTitle font:(UIFont *)font image:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target select:(SEL)select{
    
    UIButton * button = [UIButton buttonWithType:type];
    button.frame = rect;
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:selectedTitle forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    button.titleLabel.font = font;
    
    [button addTarget:target action:select forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

@end

//
//  UIButton+Create.h
//  自学武术
//
//  Created by 徐思遥 on 16/12/6.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Create)

+ (instancetype)createButtonWithType:(UIButtonType)type frame:(CGRect)rect title:(NSString *)title selectedTitle:(NSString *)selectedTitle font:(UIFont *)font image:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target select:(SEL)select;

@end

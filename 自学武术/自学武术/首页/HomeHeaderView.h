//
//  HomeHeaderView.h
//  自学武术
//
//  Created by 徐思遥 on 16/12/2.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeHeaderView : UITableViewHeaderFooterView
//显示标题的文字
@property (nonatomic, copy)NSString * text;

@property (nonatomic, strong)UIButton * moreButton;

@end

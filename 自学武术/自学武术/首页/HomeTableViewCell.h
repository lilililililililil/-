//
//  HomeTableViewCell.h
//  自学武术
//
//  Created by 徐思遥 on 16/12/2.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface HomeTableViewCell : UITableViewCell

//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//图片
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
//评论次数
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
//查看次数
@property (weak, nonatomic) IBOutlet UILabel *seeCountLabel;

//左下角小标题
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
//查看图片
@property (weak, nonatomic) IBOutlet UIImageView *seeImage;


@property (nonatomic, strong)HomeModel * model;


//标题距右边的距离约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingSpace;
//计算字符串的高度
+ (CGFloat)heightForString:(NSString *)str;

@end

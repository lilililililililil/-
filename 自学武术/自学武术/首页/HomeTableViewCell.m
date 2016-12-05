//
//  HomeTableViewCell.m
//  自学武术
//
//  Created by 徐思遥 on 16/12/2.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//


//图片服务器地址
#define PICFUWUQI @"http://www.wushu520.com"

#import "HomeTableViewCell.h"

@interface HomeTableViewCell ()


@end


@implementation HomeTableViewCell

- (void)setModel:(HomeModel *)model{
    
    if (!_model) {
        
        _model = model;
        
        _titleLabel.text = model.info_title;
        
        //拼接图片地址
        NSArray * imageArr = [model.info_img_path componentsSeparatedByString:@","];
        [_cellImageView sd_setImageWithURL:[NSURL URLWithString:[PICFUWUQI stringByAppendingPathComponent:[imageArr firstObject]]] placeholderImage:[UIImage imageNamed:@"place.jpg"]];
        
        _commentCountLabel.text = model.info_reply_count;
        _seeCountLabel.text = model.info_read_count;
    }
}

+ (CGFloat)heightForString:(NSString *)str{
    
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(ScreenWidth - 50, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    return rect.size.height;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    //self.layer.borderWidth = 0.5;
    //self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

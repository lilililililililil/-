//
//  WriteTableViewCell.m
//  自学武术
//
//  Created by 徐思遥 on 16/12/7.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import "WriteTableViewCell.h"

@implementation WriteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.view.layer.borderWidth = 1;
    self.view.layer.borderColor = [[UIColor blackColor] CGColor];
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [[UIColor blackColor] CGColor];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

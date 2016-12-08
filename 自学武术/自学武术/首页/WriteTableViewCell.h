//
//  WriteTableViewCell.h
//  自学武术
//
//  Created by 徐思遥 on 16/12/7.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriteTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *publishButton;


@end

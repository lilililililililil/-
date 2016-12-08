//
//  DetailHeaderView.h
//  自学武术
//
//  Created by 徐思遥 on 16/12/7.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (weak, nonatomic) IBOutlet UIWebView *webView;



@end

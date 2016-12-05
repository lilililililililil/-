//
//  MyScrollView.h
//  自学武术
//
//  Created by 李旺 on 2016/12/2.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyScrollView : UIView <UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView*customscroll;
@property(nonatomic,strong)NSArray*titleArray;
@property(nonatomic,strong)NSArray*imageArray;
@property(nonatomic,strong)UILabel*tiltelabel;
@property(nonatomic,strong)UIPageControl*pagecontrol;
@property(nonatomic,strong)UIButton*titlebutton;
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray*)titlearray imageArray:(NSArray*)imagearray;
@property(nonatomic,assign)int buttonwidth;
@property(nonatomic,assign)int buttonheight;
@end

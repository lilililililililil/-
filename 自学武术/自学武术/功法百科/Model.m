//
//  Model.m
//  自学武术
//
//  Created by 李旺 on 2016/12/5.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import "Model.h"

@implementation Model
//http://m.wushu520.com/Info/GetLatestGongfa
/*http://m.wushu520.com/Info/ListForAPP?ptype=1&page=1
//分类
type: 武术门派101  武术器械102  外国功夫103

//子类(在每一个分类下有不同的子类)
tag:中文的UrlEncode编码

//类型
source: 书籍图文book  视频教程video 电子书下载pdf

//详细内容
id不同(字典中的字段info_id:5517 int)(info_reply_count 评论条数 int  如没有可以不请求评论数据)
( info_last_edit_time 显示的时间 string)( info_title  标题 string)
//标题(字典)
http://m.wushu520.com/Info/ReadForAPP?id=31925
//视频
http://m.wushu520.com/Info/ReadPageForAPP/31925
//评论
http://m.wushu520.com/Topic/GetCommentList?id=5514&page=1&reply_type=2

*/
@end

//
//  NSString+URLEncoding.m
//  自学武术
//
//  Created by 徐思遥 on 16/12/7.
//  Copyright © 2016年 自学武术项目组. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

+ (NSString *)urlEncodingWithString:(NSString *)string{
    
    NSCharacterSet * set = [NSCharacterSet URLQueryAllowedCharacterSet];
    
    return [string stringByAddingPercentEncodingWithAllowedCharacters:set];
}

@end

//
//  DetailModel.m
//  testhd
//
//  Created by admin on 2017/11/16.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    // 模型属性: JSON key, MJExtension 会自动将 JSON 的 key 替换为你模型中需要的属性
    return @{
             @"ID":@"id",
             @"descrip":@"description",
             };
}


@end

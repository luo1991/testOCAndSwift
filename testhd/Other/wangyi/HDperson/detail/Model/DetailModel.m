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
             @"listOperator":@"operator",
             };
}
+ (NSDictionary *)objectClassInArray{
    return @{
             @"DetaillistModel" : @"list",
             };
}



- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    
    // property 属性名称，oldValue 返回数据
   
    if ([NSString isEmpty:oldValue]) {// 以字符串类型为例
        return  @"无";
    }
     else if (property.type.typeClass == [NSDate class]) {
        
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt dateFromString:oldValue];
    }
    
    return oldValue;
}




@end

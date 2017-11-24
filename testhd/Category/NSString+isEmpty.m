//
//  NSString+isEmpty.m
//  testhd
//
//  Created by admin on 2017/11/22.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "NSString+isEmpty.h"

@implementation NSString (isEmpty)

+(BOOL)isEmpty:(NSString*)text{
    if ([text isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([text isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (text == nil){
        return YES;
    }
    return NO;
}

@end

//
//  HttpToolRequest.h
//  testhd
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(id responseObject);
typedef void (^FailBlock)(NSError *error);
typedef void (^errorWithDataBlock)(id responseObject, NSError *error);

@interface HttpToolRequest : NSObject

+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)success   fail:(FailBlock)fail;

+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params  success:(SuccessBlock)success   fail:(FailBlock)fail;
@end

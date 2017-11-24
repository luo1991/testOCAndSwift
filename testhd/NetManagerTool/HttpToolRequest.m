//
//  HttpToolRequest.m
//  testhd
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "HttpToolRequest.h"
#import "AFNetworking.h"
#import<CommonCrypto/CommonDigest.h>

@implementation HttpToolRequest
+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)success   fail:(FailBlock)fail{
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (!responseObject) {
            fail(nil);
        }else{
            responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
             success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
    
//    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
//
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//
//    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (!responseObject) {
//            fail(nil);
//        }else{
//            responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//
//            success(responseObject);
//        }
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        fail(error);
//    }];
    
}



+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params  success:(SuccessBlock)success   fail:(FailBlock)fail{
    NSString *udid= @"A58D5634-196A-42B5-B242-FA05EDB7BC67";
    NSString *account= @"13210159498";
    NSString *password= @"123";
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO//如果是需要验证自建证书，需要设置为YES
//    securityPolicy.allowInvalidCertificates = YES;
//    //validatesDomainName 是否需要验证域名，默认为YES；
//    securityPolicy.validatesDomainName = YES;
//    manager.securityPolicy  = securityPolicy;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    if ([url hasPrefix:@"https://m.avic-intl.cn/out/interface"]) {
//        manager.requestSerializer.timeoutInterval = 30;
//    }
    
    
    NSString *tempStr = [NSString stringWithFormat:@"%@%@%@%@%@",udid,@"ios",account,password,@"a8dcd7727a6cdf362a2a5da3252843a610018dc1"];
    
    
    
    NSData *data = [tempStr dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    [manager.requestSerializer setValue:output forHTTPHeaderField: @"signature"];
    
    [manager.requestSerializer setValue:udid forHTTPHeaderField: @"imei"];
    
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField: @"os"];
    
    //账号密码 本地存储位置改为 点击 loginBtn
    [manager.requestSerializer setValue:@"13210159498" forHTTPHeaderField: @"workCode"];
    [manager.requestSerializer setValue:@"123" forHTTPHeaderField: @"password"];
    NSString *postUrl = [PublicURL stringByAppendingString:url];
    [manager POST:postUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (!responseObject) {
            fail(nil);
        }else{
            responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
    

    
}
@end

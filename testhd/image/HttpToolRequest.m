//
//  HttpToolRequest.m
//  testhd
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

#import "HttpToolRequest.h"
#import "AFNetworking.h"

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
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO//如果是需要验证自建证书，需要设置为YES
//    securityPolicy.allowInvalidCertificates = YES;
//    //validatesDomainName 是否需要验证域名，默认为YES；
//    securityPolicy.validatesDomainName = YES;
//    manager.securityPolicy  = securityPolicy;
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    if ([url hasPrefix:@"https://m.avic-intl.cn/out/interface"]) {
//        manager.requestSerializer.timeoutInterval = 30;
//    }
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
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
    
//    [manager POST:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:params success: ^(AFHTTPRequestOperation *operation, id responseObject){
//        if (!responseObject) {
//            fail(nil);
//        }else{
//            if (DEBUG) {
//
//            }
//
//            if ([url isEqualToString:@"https://oahd.avic-intl.cn:9090/common/version"]) {
//                NSString *result= [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                //过滤回车
//                NSString *vcresult = [result stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//                vcresult = [vcresult stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
//                NSData *jsonData = [vcresult dataUsingEncoding:NSUTF8StringEncoding];
//
//                //            NSDictionary *content = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
//                responseObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
//
//
//            } else {
//
//
//
//
//                if ([url isEqualToString:@"https://192.168.0.60:9000/common/downFile"]){
//                    responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//
//                } else {
//
//                    NSString * string = [[NSString alloc ] initWithData: responseObject encoding:NSUTF8StringEncoding];
//                    responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                }
//            }
//            success(responseObject);
//        }
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"error%@",error);
//
//        fail(error);
//    }];
//
    
}
@end

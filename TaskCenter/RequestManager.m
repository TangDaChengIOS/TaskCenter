//
//  RequestManager.m
//  TaskCenter
//
//  Created by 汤达成 on 18/2/2.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import "RequestManager.h"
#import "AFNetworking.h"

@implementation RequestManager

+ (void)commonRequestWithPath:(NSString *)path params:(NSDictionary *)params method:(NSString *)method success:(RequestSuccessBlock)success failure:(RequestFailureBlock)failure{

    NSString *url = path;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSSet *set = [[NSSet alloc] initWithObjects:@"text/plain",@"text/html", @"application/json", nil];
    manager.responseSerializer.acceptableContentTypes = set;
    manager.requestSerializer.timeoutInterval = 20;

    
    NSMutableDictionary *allParams = [params mutableCopy];
    if ([method isEqualToString:@"GET"]) {
        
        [manager GET:url parameters:allParams progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success == nil) return;
            if ([responseObject[@"retCode"] integerValue] == 0)
            {
                if ([responseObject objectForKey:@"data"]) {
                    success(responseObject[@"data"],YES);
                }else{
                    success(responseObject[@"page"],YES);
                }
            }
            else{
                if ([task.originalRequest.URL.path hasSuffix:@"login"])
                {
                    success(responseObject[@"retMsg"],NO);
                    return;
                }
                
                success(responseObject[@"retMsg"],NO);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
        }];
        
    }else {//6.POST请求
        
        [manager POST:url parameters:allParams progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (success == nil) return;
            if ([responseObject[@"returnCode"] integerValue] == 0)
            {
                if ([responseObject objectForKey:@"bean"]) {
                    success(responseObject[@"bean"],YES);
                }else{
//                    success(responseObject[@"page"],YES);
                }
            }
            else{
                success(responseObject[@"returnMessage"],NO);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
        }];
    }
}

+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(RequestSuccessBlock)success failure:(RequestFailureBlock)failure
{
    [self commonRequestWithPath:path params:params method:@"POST" success:success failure:failure];
}

+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(RequestSuccessBlock)success failure:(RequestFailureBlock)failure
{
    [self commonRequestWithPath:path params:params method:@"GET" success:success failure:failure];
}

@end

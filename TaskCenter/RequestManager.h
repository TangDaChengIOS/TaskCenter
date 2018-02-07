//
//  RequestManager.h
//  TaskCenter
//
//  Created by 汤达成 on 18/2/2.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestSuccessBlock)(id JSON,BOOL isSuccess);
typedef void (^RequestFailureBlock)(NSError *error);

@interface RequestManager : NSObject

+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(RequestSuccessBlock)success failure:(RequestFailureBlock)failure;


+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(RequestSuccessBlock)success failure:(RequestFailureBlock)failure;

@end

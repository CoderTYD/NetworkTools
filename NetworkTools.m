//
//  NetworkTools.m
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/23.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//
#import "NetworkTools.h"
#import <AFNetworking.h>

@implementation NetworkTools

+ (instancetype)shareNetworkTools
{
    static NetworkTools *networkTools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkTools = [[NetworkTools alloc] init];
    });
    return networkTools;
}

- (void)requestWithMethod:(RequestMethod)requestMethod andUrlString:(NSString *)urlString andParameters:(id) parameters andFinished:(void(^)(id response, NSError *error))responseBlock
{
    // 定义成功的block
    void (^success)(NSURLSessionDataTask *dataTask, id responseObject) = ^(NSURLSessionDataTask *dataTask,id responseObject)
    {
        responseBlock(responseObject, nil);
    };
    // 定义失败的block
    void (^failure)(NSURLSessionDataTask *dataTask,NSError *error) = ^(NSURLSessionDataTask *dataTask,NSError *error)
    {
        responseBlock(nil, error);
    };
    if (requestMethod == get) {
        [[AFHTTPSessionManager manager] GET:urlString parameters:parameters success:success failure:failure];
    } else {
        [[AFHTTPSessionManager manager] POST:urlString parameters:parameters success:success failure:failure];
    }
}

- (void)requestWithData:(NSData *)data andName:(NSString *)name andUrlString:(NSString *)urlString andParameters:(id) parameters andFinished:(void(^)(id response, NSError *error))responseBlock
{
    void (^success)(NSURLSessionDataTask *dataTask, id responseObject) = ^(NSURLSessionDataTask *dataTask,id responseObject)
    {
        responseBlock(responseObject, nil);
    };
    void (^failure)(NSURLSessionDataTask *dataTask,NSError *error) = ^(NSURLSessionDataTask *dataTask,NSError *error)
    {
        responseBlock(nil, error);
    };
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:@"aa" mimeType:@"application/octet-stream"];
    } success:success failure:failure];
}

@end
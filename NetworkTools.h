//
//  NetworkTools.h
//  Foodie
//
//  Created by 唐半仙丶 on 16/7/23.
//  Copyright © 2016年 CoderTYD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestMethod)
{
    post,
    get
};

@interface NetworkTools : NSObject

+ (instancetype)shareNetworkTools;

/**
 * requestMethod:请求方式
 * urlString:请求地址
 * parameters:请求参数
 * responseBlock:请求成功或失败的回调
 */

- (void)requestWithMethod:(RequestMethod)requestMethod andUrlString:(NSString *)urlString andParameters:(id) parameters andFinished:(void(^)(id response, NSError *error))responseBlock;

/**
 * data:上传资料
 * name:上传资料的名字
 * urlString:请求地址
 * parameters:请求参数
 * responseBlock:请求成功或失败的回调
 */

- (void)requestWithData:(NSData *)data andName:(NSString *)name andUrlString:(NSString *)urlString andParameters:(id) parameters andFinished:(void(^)(id response, NSError *error))responseBlock;

@end
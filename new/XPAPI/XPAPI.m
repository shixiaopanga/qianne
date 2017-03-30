//
//  XPAPI.m
//  new
//
//  Created by lzd on 2017/3/21.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "XPAPI.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "YYCache.h"
#import "PANGOPENAPI.h"
@implementation XPAPI

static NSString * const HTTP_DATA_CACHE = @"PANGJLUZHCACHE";
static AFHTTPSessionManager *_manager;
static YYCache *_dataCache;


+ (void)initialize {
    _manager = [AFHTTPSessionManager manager];
    // 设置请求的超时时间
    _manager.requestSerializer.timeoutInterval = 30.f;
    // 设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    // 打开状态栏的等待菊花
    _dataCache = [YYCache cacheWithName:HTTP_DATA_CACHE];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

/*
 
 *********************************************************************************
 *                                                                                *
 * ONES API访问回调方法                                                             *
 * 回调为一个    ONESApiCompletion    block                                         *
 *                                                                                *
 *********************************************************************************
 
 */
+ (void)onesBaseGET:(NSString *)urlString parameters:(id)parameters needCache:(BOOL)needCache succeed:(ONESApiCompletion)succeed fail:(void (^)(NSError * error))fail {
    NSString *url = [NSString stringWithFormat:@"%@%@",ONES_SERVER_URL,urlString];
    id cacheData = [self cacheForURL:url parameters:parameters];
    if (cacheData && succeed) {
        NSError *erroe;
        ONESBaseModel * model = [[ONESBaseModel alloc]initWithDictionary:cacheData error:&erroe];
        succeed(YES,model);
    }
    [_manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (needCache) {
            [self saveCache:responseObject URL:url parameters:parameters];
        }
        if (succeed) {
            NSError *erroe;
            ONESBaseModel * model = [[ONESBaseModel alloc]initWithDictionary:responseObject error:&erroe];
            succeed(NO,model);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}
+ (void)onesBasePOST:(NSString *)urlString parameters:(id)parameters needCache:(BOOL)needCache succeed:(ONESApiCompletion)succeed fail:(void(^)(NSError *error))fail {
    NSString *url = [NSString stringWithFormat:@"%@%@",ONES_SERVER_URL,urlString];
    id cacheData = [self cacheForURL:url parameters:parameters];
    if (cacheData && succeed) {
        NSError *erroe;
        ONESBaseModel * model = [[ONESBaseModel alloc]initWithDictionary:cacheData error:&erroe];
        succeed(YES,model);
    }
    [_manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (needCache) {
            [self saveCache:responseObject URL:url parameters:parameters];
        }
        if (succeed) {
            NSError *erroe;
            ONESBaseModel * model = [[ONESBaseModel alloc]initWithDictionary:responseObject error:&erroe];
            succeed(NO,model);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
    
}


/*
*********************************************************************************
*                                                                                *
* 极速数据 API访问回调方法                                                           *
* 回调为一个    XPApiCompletionHandler    block                                    *
*                                                                                *
*********************************************************************************

*/

+ (void)get:(NSString *)urlString parameters:(id)parameters needCache:(BOOL)needCache succeed:(XPApiCompletionHandler)succeed fail:(void (^)(NSError *error))fail {
    NSString *url = [NSString stringWithFormat:@"%@%@",JSSJ_SERVER_URL,urlString];
    id cacheData = [self cacheForURL:url parameters:parameters];
    if (cacheData && succeed) {
        NSError *erroe;
        XPResponseModel * model = [[XPResponseModel alloc]initWithDictionary:cacheData error:&erroe];
        succeed(YES,model);
    }
    [_manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (needCache) {
           [self saveCache:responseObject URL:url parameters:parameters];
        }
        if (succeed) {
            NSError *erroe;
            XPResponseModel * model = [[XPResponseModel alloc]initWithDictionary:responseObject error:&erroe];
            succeed(NO,model);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (fail) {
            fail(error);
        }
    }];
}

+ (void)post:(NSString *)urlString parameters:(id)parameters needCache:(BOOL)needCache succeed:(XPApiCompletionHandler)succeed fail:(void(^)(NSError *error))fail {
    NSString *url = [NSString stringWithFormat:@"%@%@",JSSJ_SERVER_URL,urlString];
    id cacheData = [self cacheForURL:url parameters:parameters];
    if (cacheData && succeed) {
        NSError *erroe;
        XPResponseModel * model = [[XPResponseModel alloc]initWithData:cacheData error:&erroe];
        succeed(YES,model);
    }
    [_manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (needCache) {
            [self saveCache:responseObject URL:url parameters:parameters];
        }
        if (succeed) {
            NSError *erroe;
            XPResponseModel * model = [[XPResponseModel alloc]initWithData:responseObject error:&erroe];
            succeed(NO,model);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { 
        if (fail) {
            fail(error);
        }
    }];
}



/*
 *********************************************************************************
 *                                                                                *
 * 缓存相关操作                                                                      *
 *                                                                                *
 *********************************************************************************
 
 */


+ (void)saveCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}

+ (id)cacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}

+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    if(!parameters){return URL;};
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@",URL,paraString];

    return cacheKey;
}
+ (void)clearCaches {
    [_dataCache.diskCache removeAllObjects];
}
+ (float)getCacheFileSize {
    return [_dataCache.diskCache totalCost];
}



/*
 *********************************************************************************
 *                                                                                *
 * ONES 具体接口的实现                                                               *
 *                                                                                *
 *********************************************************************************
 
 */
// ONES 获取文章列表
+ (void)getOnesEssayListAtIndex:(NSString *)index needCache:(BOOL)needCache succeed:(ONESApiCompletion)succeed fail:(void (^)(NSError *error))fail {
    [self onesBaseGET:[NSString stringWithFormat:ONES_READING,index] parameters:nil needCache:needCache succeed:succeed fail:fail];
}
// ONES 获取文章详情
+ (void)getOnesEssayContentFromEssayID:(NSString *)essay needCache:(BOOL)needCache succeed:(ONESApiCompletion)succeed fail:(void (^)(NSError *))fail {
    [self onesBaseGET:[NSString stringWithFormat:ONES_READING_CONTENT,essay] parameters:nil needCache:needCache succeed:succeed fail:fail];
}
/*
 *********************************************************************************
 *                                                                                *
 * 极速数据 具体接口的实现                                                             *
 *                                                                                *
 *********************************************************************************
 
 */
+ (void)getWeChatEssayWithParameters:(id)parameters needCache:(BOOL)needCache succeed:(XPApiCompletionHandler)succeed fail:(void (^)(NSError *))fail {
    [self get:JSSJ_WECHATESSAY parameters:parameters needCache:needCache succeed:succeed fail:fail];
}
@end

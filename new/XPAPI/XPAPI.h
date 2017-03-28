//
//  XPAPI.h
//  new
//
//  Created by lzd on 2017/3/21.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPResponseModel.h"

typedef void(^XPApiCompletionHandler)(BOOL, XPResponseModel* );
@interface XPAPI : NSObject

/*GET请求 <若开启缓存，先读取本地缓存数据，再进行网络请求> */
+ (void)get:(NSString *)urlString parameters:(id)parameters needCache:(BOOL)needCache succeed:(XPApiCompletionHandler)succeed fail:(void(^)(NSError *error))fail;

/* POST请求 <若开启缓存，先读取本地缓存数据，再进行网络请求，>*/
+ (void)post:(NSString *)urlString parameters:(id)parameters needCache:(BOOL)needCache succeed:(XPApiCompletionHandler)succeed fail:(void(^)(NSError *error))fail;


/*清理缓存*/
+ (void)clearCaches;


/*获取网络缓存文件大小*/
+ (float)getCacheFileSize;

+ (void)getWeChatEssayWithParameters:(id)parameters needCache:(BOOL)needCache succeed:(XPApiCompletionHandler)succeed fail:(void(^)(NSError *error))fail;
@end

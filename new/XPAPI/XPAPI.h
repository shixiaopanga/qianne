//
//  XPAPI.h
//  new
//
//  Created by lzd on 2017/3/21.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPResponseModel.h"
#import "ONESBaseModel.h"

typedef void(^XPApiCompletionHandler)(BOOL fromCache, XPResponseModel* jsModel);
//ONES 默认回调数据
typedef void(^ONESApiCompletion)(BOOL fromCache, ONESBaseModel* onesModel);
@interface XPAPI : NSObject
/*清理缓存*/
+ (void)clearCaches;

/*获取网络缓存文件大小*/
+ (float)getCacheFileSize;
/*
 *********************************************************************************
 *                                                                                *
 * ONES 具体接口的声名                                                               *
 *                                                                                *
 *********************************************************************************
 */

// ONES 获取文章列表
+ (void)getOnesEssayListAtIndex:(NSString *)index needCache:(BOOL)needCache succeed:(ONESApiCompletion)succeed fail:(void (^)(NSError * error))fail;
// ONES 获取文章详情
+ (void)getOnesEssayContentFromEssayID:(NSString *)essay needCache:(BOOL)needCache succeed:(ONESApiCompletion)succeed fail:(void (^)(NSError * error))fail;

/*
 *********************************************************************************
 *                                                                                *
 * 极速数据 具体接口的声名                                                             *
 *                                                                                *
 *********************************************************************************
 */
//极速数据获取微信精选文章
+ (void)getWeChatEssayWithParameters:(id)parameters needCache:(BOOL)needCache succeed:(XPApiCompletionHandler)succeed fail:(void(^)(NSError *error))fail;

/*
 *********************************************************************************
 *                                                                                *
 * 网易新闻 具体接口的声名                                                             *
 *                                                                                *
 *********************************************************************************
 */

@end

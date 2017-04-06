//
//  PANGOPENAPI.h
//  new
//
//  Created by lzd on 2017/3/30.
//  Copyright © 2017年 lzd. All rights reserved.
//

#ifndef PANGOPENAPI_h
#define PANGOPENAPI_h
/*
 
 *********************************************************************************
 *                                                                                *
 * ONES 客户端服务器接口                                                             *
 * 访问时候不需要参数，通过地址判断当前数据                                               *
 *                                                                                *
 *********************************************************************************
 
 */

#define ONES_SERVER_URL                     @"http://v3.wufazhuce.com:8000/api/"
// ONES 阅读地址，控制最后阅读的id可获取不同分页，每页10条数据，“0”默认为去最新10条数据
#define ONES_READING                        @"channel/reading/more/%@"
// ONES 文章详情页
#define ONES_READING_CONTENT                @"essay/%@?platform=ios&version=v4.1"

/*
 
 *********************************************************************************
 *                                                                                *
 * ONES 客户端服务器接口                                                             *
 * 访问时候不需要参数，通过地址判断当前数据                                               *
 *                                                                                *
 *********************************************************************************
 
 */

#define JSSJ_SERVER_URL                     @"http://api.jisuapi.com/"
#define JSSJ_WECHATESSAY                    @"weixinarticle/get"

/*
 
 *********************************************************************************
 *                                                                                *
 * 网易 客户端服务器接口                                                             *
 * 访问时候不需要参数，通过地址判断当前数据                                               *
 *                                                                                *
 *********************************************************************************
 
 */
#define WY_SERVER_URL                     @"http://c.m.163.com/"
#define WY_VIDEO_HOME                     @"nc/video/home/%@-10.html"

#endif /* PANGOPENAPI_h */

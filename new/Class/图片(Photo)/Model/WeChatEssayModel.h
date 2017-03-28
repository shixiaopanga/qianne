//
//  WeChatEssayModel.h
//  new
//
//  Created by lzd on 2017/3/28.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WeChatEssayModel : JSONModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *weixinname;
@property (nonatomic, copy) NSString *weixinaccount;
@property (nonatomic, copy) NSString *weixinsummary;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *readnum;
@property (nonatomic, copy) NSString *likenum;
@end

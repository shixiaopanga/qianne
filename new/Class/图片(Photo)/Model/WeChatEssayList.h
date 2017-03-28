//
//  WeChatEssayList.h
//  new
//
//  Created by lzd on 2017/3/28.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WeChatEssayModel;
@interface WeChatEssayList : JSONModel
@property (nonatomic, copy) NSString *channel; //频道名称
@property (nonatomic, copy) NSString *channelid; //频道ID
@property (nonatomic, copy) NSString *total; //
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *start;
@property (nonatomic, copy) NSArray <WeChatEssayModel> *list;
@end

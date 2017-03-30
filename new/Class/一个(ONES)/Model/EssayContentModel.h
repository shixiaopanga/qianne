//
//  EssayContentModel.h
//  new
//
//  Created by lzd on 2017/3/30.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "wechatShareModel.h"

@interface EssayContentModel : JSONModel
@property (nonatomic, copy) NSString *contentID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *editor;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *copyright;
@property (nonatomic, copy) NSString *likeCount;
@property (nonatomic, assign) wechatShareModel *share;
//@property (nonatomic, copy) NSString <Optional>*author;
@end

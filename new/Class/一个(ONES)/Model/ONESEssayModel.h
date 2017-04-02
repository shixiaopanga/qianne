//
//  ONESEssayModel.h
//  new
//
//  Created by lzd on 2017/3/30.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "wechatShareModel.h"
@interface ONESEssayModel : JSONModel
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *essayID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *likeCount;
@property (nonatomic, copy) NSString *postDate;
@property (nonatomic, copy) NSString *lastDate;
@property (nonatomic, assign) wechatShareModel *share;
@property (nonatomic, copy) NSString *author;
@end

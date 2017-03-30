//
//  wechatShareModel.h
//  new
//
//  Created by lzd on 2017/3/30.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface wechatShareModel : JSONModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *imgUrl;
@end

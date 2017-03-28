//
//  XPResponseModel.h
//  new
//
//  Created by lzd on 2017/3/21.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface XPResponseModel : JSONModel
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSMutableDictionary *result;

@end

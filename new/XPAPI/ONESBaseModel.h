//
//  ONESBaseModel.h
//  new
//
//  Created by lzd on 2017/3/30.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ONESBaseModel : JSONModel
@property (nonatomic, copy) NSString *res;
@property (nonatomic, copy) NSMutableDictionary *data;
@end

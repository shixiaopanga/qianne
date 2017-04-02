//
//  ONESEssayModel.m
//  new
//
//  Created by lzd on 2017/3/30.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "ONESEssayModel.h"

@implementation ONESEssayModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                  @"index": @"id",
                                  @"essayID": @"item_id",
                                  @"subTitle": @"forward",
                                  @"image": @"img_url",
                                  @"likeCount": @"like_count",
                                  @"postDate": @"post_date",
                                  @"lastDate": @"last_update_date",
                                  @"share": @"share_list.wx",
                                  @"author": @"author.user_name"
                                                                  }];
}
@end

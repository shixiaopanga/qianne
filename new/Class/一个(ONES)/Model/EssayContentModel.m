//
//  EssayContentModel.m
//  new
//
//  Created by lzd on 2017/3/30.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "EssayContentModel.h"

@implementation EssayContentModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"contentID": @"content_id",
                                                                  @"title": @"hp_title",
                                                                  @"editor": @"hp_author_introduce",
                                                                  @"content": @"hp_content",
                                                                  @"likeCount": @"praisenum",
                                                                  @"share": @"share_list.wx",
//                                                                  @"author": @"author.user_name"
                                                                  }];
}

@end

//
//  WKWebView+ImageSave.h
//  new
//
//  Created by lzd on 2017/4/7.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (ImageSave)
@property (nonatomic, copy) NSArray *imgUrlArray;
-(NSArray *)getImageUrlByJS:(WKWebView *)wkWebView;
-(void)showBigImage:(NSURLRequest *)request;
@end

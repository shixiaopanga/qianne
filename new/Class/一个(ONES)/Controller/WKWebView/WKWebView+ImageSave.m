//
//  WKWebView+ImageSave.m
//  new
//
//  Created by lzd on 2017/4/7.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "WKWebView+ImageSave.h"
#import <objc/message.h>

static const char *imgUrlArrayKey = "WKWebViewSaveImage";
@implementation WKWebView (ImageSave)

- (void)setImgUrlArray:(NSArray *)imgUrlArray {
    objc_setAssociatedObject(self, imgUrlArrayKey, imgUrlArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)imgUrlArray {
    return objc_getAssociatedObject(self, imgUrlArrayKey);
}

-(NSArray *)getImageUrlByJS:(WKWebView *)wkWebView {
    
    //查看大图代码
    //js方法遍历图片添加点击事件返回图片个数
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    var imgUrlStr='';\
    for(var i=0;i<objs.length;i++){\
    if(i==0){\
    if(objs[i].alt==''){\
    imgUrlStr=objs[i].src;\
    }\
    }else{\
    if(objs[i].alt==''){\
    imgUrlStr+='#'+objs[i].src;\
    }\
    }\
    objs[i].style.width = '100%%';\
    objs[i].style.height = 'auto';\
    objs[i].onclick=function(){\
    if(this.alt==''){\
    document.location=\"myweb:imageClick:\"+this.src;\
    }\
    };\
    };\
    return imgUrlStr;\
    };";
    
    
    //用js获取全部图片
    [wkWebView evaluateJavaScript:jsGetImages completionHandler:^(id Result, NSError * error) {
        NSLog(@"js___Result==%@",Result);
        NSLog(@"js___Error -> %@", error);
    }];
    
    NSString *js2=@"getImages()";
    __block NSArray *array=[NSArray array];
    [wkWebView evaluateJavaScript:js2 completionHandler:^(id Result, NSError * error) {
        NSLog(@"js2__Result==%@",Result);
        NSLog(@"js2__Error -> %@", error);
        
        NSString *resurlt=[NSString stringWithFormat:@"%@",Result];
        
        if([resurlt hasPrefix:@"#"])
        {
            resurlt=[resurlt substringFromIndex:1];
        }
        NSLog(@"result===%@",resurlt);
        array=[resurlt componentsSeparatedByString:@"#"];
        NSLog(@"array====%@",array);
        [wkWebView setImgUrlArray:array];
    }];
    
    return array;
}
-(void)showBigImage:(NSURLRequest *)request {
//    //将url转换为string
//    NSString *requestString = [[request URL] absoluteString];
//    
//    //hasPrefix 判断创建的字符串内容是否以pic:字符开始
//    if ([requestString hasPrefix:@"myweb:imageClick:"])
//    {
//        NSString *imageUrl = [requestString substringFromIndex:@"myweb:imageClick:".length];
//        NSLog(@"image url------%@", imageUrl);
//        
//        NSArray *imgUrlArr=[self getImgUrlArray];
//        NSInteger index=0;
//        for (NSInteger i=0; i<[imgUrlArr count]; i++) {
//            if([imageUrl isEqualToString:imgUrlArr[i]])
//            {
//                index=i;
//                break;
//            }
//        }
//        
//        [WFImageUtilshowImgWithImageURLArray:[NSMutableArrayarrayWithArray:imgUrlArr] index:index myDelegate:nil];
//        
//        return NO;
//    }
//    returnYES;
    // 在这里面处理点击图片事件 等以后有时间优化 
    NSLog(@"showImage");
}
@end

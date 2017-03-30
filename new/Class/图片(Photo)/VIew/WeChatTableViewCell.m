//
//  WeChatTableViewCell.m
//  new
//
//  Created by lzd on 2017/3/28.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "WeChatTableViewCell.h"
#import "ONESEssayModel.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"

@interface WeChatTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *writerIcon;
@property (weak, nonatomic) IBOutlet UILabel *writerName;
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;
@property (weak, nonatomic) IBOutlet UILabel *contentTitle;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *essayTime;
@property (weak, nonatomic) IBOutlet UIButton *likeCount;
@property (weak, nonatomic) IBOutlet UIButton *readCount;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentImageHeight;


@end

@implementation WeChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updataForEssayModel:(ONESEssayModel *)model reloadCompleted:(void(^)())completed{
    _writerName.text = [NSString stringWithFormat:@"ONES · %@",model.author];
//    UIImage *img = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:model.pic];
//    if (img) {
//        _contentImage.image = img;
//        [self updateConstraintsIfNeeded];
//    }else {
//        _contentImage.image = [UIImage imageNamed:@"placeholder_pic"];
//        [self resizingDownLoadImage:model.pic reloadCompleted:completed];
//    }
    [_contentImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"placeholder_pic"]];
    _contentTitle.text = model.title;
    _content.text = model.subTitle;
    _essayTime.text = [self compareCurrentTime:model.postDate];//model.postDate;
    [_likeCount setTitle:model.likeCount forState:UIControlStateNormal];
//    [_readCount setTitle:model.readnum forState:UIControlStateNormal];
}

- (void)resizingDownLoadImage:(NSString *)imageURL reloadCompleted:(void(^)())completed{
    __weak __typeof(self)weakSelf = self;
    [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:imageURL] options:(SDWebImageDownloaderUseNSURLCache) progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (image) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                CGFloat scale = strongSelf.contentImage.frame.size.width / image.size.width;
                CGSize newSize = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(scale, scale));
                
                UIGraphicsBeginImageContextWithOptions(newSize, NO,1.00);
                [image drawInRect:CGRectMake(0, 0, 375 , 290)];
                UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                [[SDImageCache sharedImageCache] storeImage:scaledImage forKey:imageURL toDisk:YES];
                dispatch_async(dispatch_get_main_queue(), ^{
                    strongSelf.contentImage.image = scaledImage;
                    [strongSelf updateConstraintsIfNeeded];
                });
            });
            
        }
    }];
}

- (NSString *) compareCurrentTime:(NSString *)str
{
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}
@end

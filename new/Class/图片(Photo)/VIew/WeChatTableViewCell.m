//
//  WeChatTableViewCell.m
//  new
//
//  Created by lzd on 2017/3/28.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "WeChatTableViewCell.h"
#import "WeChatEssayModel.h"
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

- (void)updataForEssayModel:(WeChatEssayModel *)model reloadCompleted:(void(^)())completed{
    _writerName.text = [NSString stringWithFormat:@"%@·%@",model.weixinname,model.weixinaccount];
    UIImage *img = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:model.pic];
    if (img) {
        _contentImage.image = img;
//        CGFloat newScale = img.size.height / img.size.width;
//        _contentImageHeight.constant = newScale * _contentImage.bounds.size.width;
        
    }else {
        __weak __typeof(self)wself = self;
        [_contentImage sd_setImageWithURL:[NSURL URLWithString:model.time] placeholderImage:[UIImage imageNamed:@"icon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^ {
                    //            wself.contentImage.image = image;
                    //            CGFloat newScale = image.size.height / image.size.width;
                    //            wself.contentImageHeight.constant = newScale * _contentImage.bounds.size.width;
                    completed();
                });
            }
            
        }];
    }
    
    _contentTitle.text = model.title;
    _content.text = model.content;
    _essayTime.text = model.time;
    [_likeCount setTitle:model.likenum forState:UIControlStateNormal];
    [_readCount setTitle:model.readnum forState:UIControlStateNormal];
}

@end

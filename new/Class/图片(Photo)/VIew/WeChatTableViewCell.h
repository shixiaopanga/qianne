//
//  WeChatTableViewCell.h
//  new
//
//  Created by lzd on 2017/3/28.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeChatTableViewCell;
@protocol WeChatTableViewCellDelegate <NSObject>

@optional
- (void)wechatTableViewCell:(nullable WeChatTableViewCell *)cell didClickPlayBtnAtIndexPath:(nullable NSIndexPath *)indexPath ;
@end

@interface WeChatTableViewCell : UITableViewCell
@property (nullable, nonatomic, weak) id<WeChatTableViewCellDelegate> delegate;

- (void)updataForEssayModel:(nullable id)model reloadCompleted:(nullable void(^)())completed;
- (void)updataForVideoModel:(nullable id)model atIndexPath:(nullable NSIndexPath *)indexPath;
@end

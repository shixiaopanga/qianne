//
//  WeChatTableViewCell.h
//  new
//
//  Created by lzd on 2017/3/28.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeChatTableViewCell : UITableViewCell
- (void)updataForEssayModel:(id)model reloadCompleted:(void(^)())completed;
@end

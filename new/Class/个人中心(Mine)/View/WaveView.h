//
//  WaveView.h
//  new
//
//  Created by lzd on 2017/3/25.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WaveViewDelegate <NSObject>

- (void)editButtonDidClick;

@end
@interface WaveView : UIView
@property (nonatomic, strong) UIImageView *icon;   //头像
@property (nonatomic, strong) UILabel *name;       //昵称
@property (nonatomic, strong) UILabel *state;      //签名
@property (nonatomic, strong) UIButton *editBtn;      //编辑

@property (nonatomic, weak)id<WaveViewDelegate>delegate;

- (void)setWithIcon:(NSString *)icon name:(NSString *)name state:(NSString *)state;

- (instancetype)initWithFrame:(CGRect)frame waveColor:(UIColor *)color;
@end

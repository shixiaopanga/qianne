//
//  WaveView.m
//  new
//
//  Created by lzd on 2017/3/25.
//  Copyright © 2017年 lzd. All rights reserved.
//

#import "WaveView.h"
#import "SDWebImageManager.h"

@interface WaveView ()

@property (nonatomic,strong)CADisplayLink *waveDisplayLink;

@property (nonatomic,strong)CAShapeLayer *waveLayer1;
@property (nonatomic,strong)CAShapeLayer *waveLayer2;

@property (nonatomic,strong)UIColor *wavesColor;

@end

@implementation WaveView {
    CGFloat offsetX; //位移
}

- (instancetype)initWithFrame:(CGRect)frame waveColor:(UIColor *)color {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.opaque = YES;
        self.layer.masksToBounds = YES;
        
        [self addWaveWithColor:color];
        [self setUpView];
    }

    return self;
}
- (void)setWithIcon:(NSString *)icon name:(NSString *)name state:(NSString *)state {
    _name.text = name;
    _state.text = state;
}

- (void)addWaveWithColor:(UIColor *)color{
    //初始化layer
    if (self.waveLayer1 == nil) {
        
        //初始化
        self.waveLayer1 = [CAShapeLayer layer];
        self.waveLayer1.opaque = YES;
        //设置闭环的颜色
        self.waveLayer1.fillColor = color.CGColor;
       
        [self.layer addSublayer:self.waveLayer1];
    }
    if (self.waveLayer2 == nil) {
        //初始化
        self.waveLayer2 = [CAShapeLayer layer];
        self.waveLayer2.opaque = YES;
        //设置闭环的颜色
        self.waveLayer2.fillColor = color.CGColor;
        
        [self.layer addSublayer:self.waveLayer2];
    }
    
    //启动定时器
    self.waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setLayerPath)];
    
    [self.waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)setLayerPath{
    offsetX += 0.02;
    //创建一个路径
    CGMutablePathRef path1 = CGPathCreateMutable();
    CGMutablePathRef path2 = CGPathCreateMutable();
    //起始位置
    CGFloat starY = self.frame.size.height - 5;
    CGFloat width = self.frame.size.width;
    
    CGFloat y1 = starY;
    CGFloat y2 = starY;
    //将点移动到 x=0,y=currentK的位置
    CGPathMoveToPoint(path1, nil, 0, y1);
    CGPathMoveToPoint(path2, nil, 0, y2);
    
    for (NSInteger i =0.0f; i<=width; i++) {
        //正弦函数波浪公式
        y1 = 5 * sin(0.01 * i+ offsetX)+starY;
        //余弦函数波浪公式
        y2 = 5 * cos(0.01 * i+ offsetX)+starY;
        //将点连成线
        CGPathAddLineToPoint(path1, nil, i, y1);
        CGPathAddLineToPoint(path2, nil, i, y2);
    }
    
    CGPathAddLineToPoint(path1, nil, width, 0);
    CGPathAddLineToPoint(path1, nil, 0, 0);
    CGPathAddLineToPoint(path2, nil, width, 0);
    CGPathAddLineToPoint(path2, nil, 0, 0);

    CGPathCloseSubpath(path1);
    CGPathCloseSubpath(path2);
    self.waveLayer1.path = path1;
    self.waveLayer2.path = path2;
    
    //使用layer 而没用CurrentContext
    CGPathRelease(path1);
    CGPathRelease(path2);
}


- (void)setUpView {
    _icon = [[UIImageView alloc]init];
    _icon.image = [UIImage imageNamed:@"icon"];
    [self addSubview:_icon];
    
    _name = [[UILabel alloc]init];
    _name.opaque = YES;
    _name.textAlignment = NSTextAlignmentCenter;
    _name.textColor = [UIColor whiteColor];
    _name.text = @"小胖";
    [self addSubview:_name];
    
    _state = [[UILabel alloc]init];
    _state.opaque = YES;
    _state.textAlignment = NSTextAlignmentCenter;
    _state.textColor = RGBA(255, 255, 255, 0.8);
    _state.text = @"21岁，我是自在如风的少年";
    [self addSubview:_state];
    
    _editBtn = [[UIButton alloc]init];
    _editBtn.opaque = YES;
    [_editBtn setImage:[UIImage imageNamed:@"navi_edit"] forState:UIControlStateNormal];
    [_editBtn setTitleEdgeInsets:UIEdgeInsetsMake(5, 5, 0, 0)];
    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    _editBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [_editBtn addTarget:self action:@selector(editButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_editBtn];
}

- (void)editButtonClick {
    if ([_delegate respondsToSelector:@selector(editButtonDidClick)]) {
        [_delegate editButtonDidClick];
    }
    
}

- (void)layoutSubviews {
    _icon.frame = CGRectMake(UI_SCREEN_WIDTH/2 - 32, 60, 64, 64);
    _name.frame = CGRectMake(0, 130, UI_SCREEN_WIDTH, 20);
    _state.frame = CGRectMake(0, 150, UI_SCREEN_WIDTH, 20);
    _editBtn.frame = CGRectMake(UI_SCREEN_WIDTH - 80, 25, 70, 25);
}

-(void)dealloc
{
    [self.waveDisplayLink invalidate];
}

@end

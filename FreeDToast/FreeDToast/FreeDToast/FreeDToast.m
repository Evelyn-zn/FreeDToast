//
//  FreeDToast.m
//  FreeDToast
//
//  Created by sino on 2017/3/15.
//  Copyright © 2017年 Evelyn. All rights reserved.
//

#import "FreeDToast.h"
@implementation FreeDToast
+ (FreeDToast *)shareFreeDToast {
    static FreeDToast *freedtoast = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        freedtoast = [[FreeDToast alloc] init];
    });
    return freedtoast;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
        
        _freeDLabel = [[ToastLabel alloc] init];
        _freeDLabel.backgroundColor = [UIColor clearColor];
        _freeDLabel.textColor = [UIColor whiteColor];
        _freeDLabel.font = ToastFont;
        _freeDLabel.layer.masksToBounds = YES;
        _freeDLabel.layer.cornerRadius = 8;
        _freeDLabel.textInsets = UIEdgeInsetsMake(0.f, 10.f, 0.f, 10.f);
        _freeDLabel.numberOfLines = 0;
        _freeDLabel.textAlignment = NSTextAlignmentCenter;
        _freeDLabel.lineBreakMode = NSLineBreakByCharWrapping | NSLineBreakByWordWrapping;
        
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.backgroundColor = [UIColor clearColor];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.textColor = [UIColor whiteColor];
        _tipsLabel.font = ToastFont;
        
        _backView = [[UIView alloc] init];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 15;
        
        _tipsImageView = [[UIImageView alloc] init];
        _tipsImageView.backgroundColor = [UIColor clearColor];
        _tipsImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return self;
}

- (void)showToastWithMessage:(NSString *)message WithFrame:(CGRect)frame WithViewAlpha:(CGFloat)alpha WithDelayTimes:(double)delay {
    [self FDHUDStop];
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    self.freeDLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:alpha];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine;
    CGRect freeRect = [message boundingRectWithSize:CGSizeMake(ToastWidth-20, 1000) options:options attributes:@{NSFontAttributeName:ToastFont} context:nil];
    if (CGRectEqualToRect(frame, CGRectZero)) {
        self.freeDLabel.frame = CGRectMake(ToastX, (ViewFrame.size.height-freeRect.size.height-70), ToastWidth, freeRect.size.height+15);
    }else {
        self.freeDLabel.frame = frame;
    }
    
    self.freeDLabel.text = message;
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    [keyWindow addSubview:self.freeDLabel];
    
    double delayInseconds = delay;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInseconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.freeDLabel removeFromSuperview];
    });
}

#pragma mark - 带图片的请求  图片旋转
- (void)showFDHUDWithMessage:(NSString *)message
     WithbackgroundViewFrame:(CGRect)frameBG
           WithBackViewFrame:(CGRect)frame
               WithImageName:(NSString *)imageName
               WithViewAlpha:(CGFloat)alpha {
    if (CGRectEqualToRect(frameBG, CGRectZero)) {
        self.backgroundView.frame = CGRectMake(0, 0, ViewFrame.size.width, ViewFrame.size.height);
    }else {
        self.backgroundView.frame = frameBG;
    }
    
    self.backgroundView.backgroundColor = [UIColor redColor];
    
    self.backView.backgroundColor = [UIColor colorWithRed:2/255.0 green:24/255.0 blue:47/255.0 alpha:alpha];
    [self.backgroundView addSubview:self.backView];
    if (CGRectEqualToRect(frame, CGRectZero)) {
        self.backView.frame = CGRectMake(FDHUDX, (CGRectGetHeight(self.backgroundView.frame)-FDHUDHeight-64)/2, FDHUDWidth, FDHUDHeight);
    }else {
        self.backView.frame = frame;
    }
    _tipsLabel.text = message;
    self.tipsImageView.image = [UIImage imageNamed:imageName];
    
    // frame
    self.tipsImageView.frame = CGRectMake((CGRectGetWidth(self.backView.frame)-40)/2, 15, 40, 40);
    _tipsLabel.frame = CGRectMake(0, CGRectGetMaxY(self.tipsImageView.frame)+10, CGRectGetWidth(self.backView.frame), 35);
    [self.backView addSubview:_tipsLabel];
    [self.backView addSubview:self.tipsImageView];
    
    //    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    //    [keyWindow addSubview:self.backView];
    
    CABasicAnimation* rotationAnimation;
    //绕哪个轴，那么就改成什么：这里是绕z轴 ---> transform.rotation.z
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //旋转角度
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI];
    //每次旋转的时间（单位秒）
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.removedOnCompletion = NO;
    //重复旋转的次数，如果你想要无数次，那么设置成MAXFLOAT
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.tipsImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}

#pragma mark - 带图片的提示 错误 / 成功
- (void)showFDImageTipsWithMessage:(NSString *)message WithBackViewFrame:(CGRect)frame WithImageName:(NSString *)imageName  WithViewAlpha:(CGFloat)alpha WithDelayTimes:(double)delay {
    
    self.freeDLabel.text = @"";
    [self FDHUDStop];
    
    self.backView.backgroundColor = [UIColor colorWithRed:2/255.0 green:24/255.0 blue:47/255.0 alpha:alpha];
    if (CGRectEqualToRect(frame, CGRectZero)) {
        self.backView.frame = CGRectMake(FDHUDX, ([UIScreen mainScreen].bounds.size.height-FDHUDWidth-80), FDHUDWidth, FDHUDWidth);
    }else {
        self.backView.frame = frame;
    }
    self.tipsLabel.text = message;
    self.tipsImageView.image = [UIImage imageNamed:imageName];
    
    [self.backView addSubview:self.freeDLabel];
    [self.backView addSubview:self.tipsImageView];
    
    // frame
    self.tipsImageView.frame = CGRectMake((CGRectGetWidth(self.backView.frame)-40)/2, (CGRectGetHeight(self.backView.frame)-40)/3, 40, 40);
    self.tipsLabel.frame = CGRectMake(0, CGRectGetMaxY(self.tipsImageView.frame)+10, CGRectGetWidth(self.backView.frame), 35);
    [self.backView addSubview:_tipsLabel];
    [self.backView addSubview:self.tipsImageView];
    
    
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    [keyWindow addSubview:self.backView];
    
    double delayInseconds = delay;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInseconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tipsLabel removeFromSuperview];
        [self.tipsImageView removeFromSuperview];
        [self.backView removeFromSuperview];
    });
}


- (void)FDHUDStop {
    [self.tipsImageView.layer removeAllAnimations];
    [self.freeDLabel removeFromSuperview];
    [self.tipsLabel removeFromSuperview];
    [self.tipsImageView removeFromSuperview];
    [self.backView removeFromSuperview];
}


#pragma mark - 计算高度
- (CGRect)getLabelHeightWithString:(NSString *)string WithLabelSize:(CGSize)size{
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine;
    CGRect freeRect = [string boundingRectWithSize:size options:options attributes:@{NSFontAttributeName:ToastFont} context:nil];
    return freeRect;
}

@end

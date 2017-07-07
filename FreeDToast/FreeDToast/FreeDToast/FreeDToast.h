//
//  FreeDToast.h
//  FreeDToast
//
//  Created by sino on 2017/3/15.
//  Copyright © 2017年 Evelyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ToastLabel.h"
#define ToastWidth   150
#define ToastX  ([UIScreen mainScreen].bounds.size.width-ToastWidth)/2
#define ToastFont [UIFont systemFontOfSize:16]
#define ViewFrame [UIScreen mainScreen].bounds

#define FDHUDWidth   160
#define FDHUDHeight  100
#define FDHUDX  ([UIScreen mainScreen].bounds.size.width-FDHUDWidth)/2
@interface FreeDToast : NSObject

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) ToastLabel *freeDLabel;
@property (nonatomic, strong) UIImageView *tipsImageView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UILabel *tipsLabel;

+ (FreeDToast *)shareFreeDToast;

// 提示文本（无图片）
- (void)showToastWithMessage:(NSString *)message WithFrame:(CGRect)frame WithViewAlpha:(CGFloat)alpha WithDelayTimes:(double)delay;

// 带图片的请求  图片旋转
- (void)showFDHUDWithMessage:(NSString *)message
     WithbackgroundViewFrame:(CGRect)frameBG
           WithBackViewFrame:(CGRect)frame
               WithImageName:(NSString *)imageName
               WithViewAlpha:(CGFloat)alpha;

// 带图片的提示 错误 / 成功
- (void)showFDImageTipsWithMessage:(NSString *)message
                 WithBackViewFrame:(CGRect)frame
                     WithImageName:(NSString *)imageName
                     WithViewAlpha:(CGFloat)alpha
                    WithDelayTimes:(double)delay;

// 停止旋转
- (void)FDHUDStop;
@end

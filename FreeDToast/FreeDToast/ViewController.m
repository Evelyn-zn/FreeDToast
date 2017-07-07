//
//  ViewController.m
//  FreeDToast
//
//  Created by sino on 2017/3/15.
//  Copyright © 2017年 Evelyn. All rights reserved.
//

#import "ViewController.h"
#import "FreeDToast.h"
#define ViewFrame [UIScreen mainScreen].bounds
@interface ViewController ()<UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    for (int i = 0; i < 5; i++) {
        UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
        [bu setFrame:CGRectMake(80, i*70+80, ViewFrame.size.width-160, 50)];
        bu.backgroundColor = [UIColor lightGrayColor];
        bu.tag = 101 + i;
        [bu setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
        [bu addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view  addSubview:bu];
    }
}



- (void)buttonAction:(UIButton *)sender {
    NSInteger value = sender.tag - 101;
    switch (value) {
        case 0:
        {
            // toast只展示文本
            [[FreeDToast shareFreeDToast] showToastWithMessage:@"网络不给力" WithFrame:CGRectZero WithViewAlpha:0.8 WithDelayTimes:2.0];
            
        }
            break;
        case 1:
        {
            // 请求成功
            [[FreeDToast shareFreeDToast] showFDImageTipsWithMessage:@"请求成功" WithBackViewFrame:CGRectZero WithImageName:@"success.png" WithViewAlpha:0.8 WithDelayTimes:2.0];
            
        }
            break;
        case 2:
        {
            // 请求失败
            [[FreeDToast shareFreeDToast] showFDImageTipsWithMessage:@"请求失败" WithBackViewFrame:CGRectZero WithImageName:@"false.png" WithViewAlpha:0.8 WithDelayTimes:2.0];
        }
            break;
        case 3:
        {
            // 请求中...
            [[FreeDToast shareFreeDToast] showFDHUDWithMessage:@"请稍后" WithbackgroundViewFrame:CGRectZero WithBackViewFrame:CGRectZero WithImageName:@"hud.png" WithViewAlpha:0.8];
            [self.view addSubview:[FreeDToast shareFreeDToast].backView];
            
        }
            break;
        case 4:
        {
            [[FreeDToast shareFreeDToast] FDHUDStop];
            
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

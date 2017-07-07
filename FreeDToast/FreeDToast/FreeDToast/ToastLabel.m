//
//  ToastLabel.m
//  i_DMdoule
//
//  Created by sino on 2017/3/15.
//  Copyright © 2017年 zhangan. All rights reserved.
//

#import "ToastLabel.h"

@implementation ToastLabel

- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}

@end

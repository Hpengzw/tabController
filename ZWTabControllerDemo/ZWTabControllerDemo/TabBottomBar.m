//
//  TabBottomBar.m
//  ZWTabControllerDemo
//
//  Created by huang ytand on 2018/3/23.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import "TabBottomBar.h"

@interface TabBottomBar  ()
/// lable
@property (nonatomic, strong)   UILabel  *backLable;

/// button
@property (nonatomic, strong)   UIButton  *jumpBtn;

@end

@implementation TabBottomBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self backLable];
        [self jumpBtn];
    }
    return self;
}

- (UILabel *)backLable {
    if (!_backLable) {
        _backLable = [[UILabel alloc]init];
        _backLable.text = @"返回上一级";
        _backLable.textAlignment = NSTextAlignmentCenter;
        _backLable.textColor = [UIColor blueColor];
        _backLable.font = [UIFont systemFontOfSize:16.f];
        _backLable.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
        [_backLable addGestureRecognizer:pan];
        [self addSubview:_backLable];
    }
    return _backLable;
}

- (UIButton *)jumpBtn {
    if (!_jumpBtn) {
        _jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_jumpBtn setTitle:@"跳转" forState:UIControlStateNormal];
        [_jumpBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_jumpBtn addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_jumpBtn];
    }
    return _jumpBtn;
}

- (void)back:(UITapGestureRecognizer *)pan {
    if ([self.delegate respondsToSelector:@selector(back)]) {
        [self.delegate back];
    }
}

- (void)jump:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(jump)]) {
        [self.delegate jump];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _backLable.frame = self.bounds;
    _backLable.wl_width = self.bounds.size.width *.5f;
    
    _jumpBtn.frame = self.bounds;
    _jumpBtn.wl_width = self.bounds.size.width *.5f;
    _jumpBtn.wl_x = _jumpBtn.wl_width;
    
}
@end

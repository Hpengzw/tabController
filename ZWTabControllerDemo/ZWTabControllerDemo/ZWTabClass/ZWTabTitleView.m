//
//  ZWTabTitleView.m
//  ZWTabControllerDemo
//
//  Created by 黄鹏 on 2018/3/10.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import "ZWTabTitleView.h"

@interface  ZWTabTitleView  ()
//缓存标题按钮
@property (nonatomic, strong)   NSMutableArray  *btns;
//可移动的横线
@property (nonatomic, weak)     UIView          *moveLine;
//底部横线
@property (nonatomic, weak)     UIView          *line;
//记录选中按钮
@property (nonatomic, weak)     UIButton        *selectBtn;
///标题是否相等，默认为Yes
@property (nonatomic, assign)   BOOL    isEqualTitle;
//缓存按钮标题的宽度
@property (nonatomic, strong)   NSMutableArray  *btnsWidth;
//如果标题相等，则定义一个变量存储标题宽度
@property (nonatomic, assign)   CGFloat equalTitleWidth;

@end

@implementation ZWTabTitleView

///初始化
- (instancetype)initWithTitleArray:(NSArray<NSString *> *)titles
                      isEqualTitle:(BOOL)equal {
    self = [super init];
    if (self) {
        self.isEqualTitle = equal;
        [self setUpChildViewWithTitles:titles];
    }
    return self;
    
}
- (NSMutableArray *)btns {
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)btnsWidth {
    if (!_btnsWidth) {
        _btnsWidth = [NSMutableArray array];
    }
    return _btnsWidth;
}

- (void)setUpChildViewWithTitles:(NSArray *)titles {
    if (!titles) return;
    for (int i = 0; i<titles.count; i++) {
        NSString    *title = titles[i];
        UIButton    *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        btn.tag = i;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:)
      forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.btns addObject:btn];
        if (self.isEqualTitle) {
            if (0 == i) {
                self.equalTitleWidth = [self caculateWithView:btn];
            }
        }else {
            [self.btnsWidth addObject:@([self caculateWithView:btn])];//缓存按钮标题宽度
        }
    }
    //底部横线
    UIView  *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    _line = line;
    //可移动横线
    UIView  *moveLine = [[UIView alloc]init];
    moveLine.backgroundColor = [UIColor blueColor];
    [self addSubview:moveLine];
    _moveLine = moveLine;
}


- (void)btnClick:(UIButton *)sender {

    self.selectBtn.selected = NO;
    sender.selected = YES;
    self.selectBtn = sender;

    self.moveLine.wl_width = [self getButtonWidthAtIndex:sender.tag];
    [UIView animateWithDuration:0.001 animations:^{
        self.moveLine.wl_centerX = sender.wl_centerX;
    }];

    //调用代理
    if ([self.delegate respondsToSelector:@selector(titleView:didClickButtonAtIndex:)]) {
        [self.delegate titleView:self didClickButtonAtIndex:sender.tag];
    }
}

- (void)bottomLineScollIndex:(NSInteger)index {
    UIButton *btn = self.btns[index];
    self.moveLine.wl_width = [self getButtonWidthAtIndex:index];
    [UIView animateWithDuration:0.001 animations:^{
        self.moveLine.wl_centerX = btn.wl_centerX;

        self.selectBtn.selected = NO;
        btn.selected = YES;
        self.selectBtn = btn;
    }];
}


#pragma mark - setter

- (void)setSelectColor:(UIColor *)selectColor {
    _selectColor = selectColor;
    if (!_selectColor) return;
    self.moveLine.backgroundColor = _selectColor;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            [btn setTitleColor:_selectColor forState:UIControlStateSelected];
        }
    }
}

- (CGFloat)getButtonWidthAtIndex:(NSInteger)index {
    return self.isEqualTitle ? self.equalTitleWidth : [self.btnsWidth[index] floatValue];
}
//
//计算按钮文字的宽度
- (CGFloat)caculateWithView:(UIButton *)view {
    CGFloat tempW = 0.0;
    tempW = [self stringSizeWithStringFont:view.titleLabel.font
                               lenthString:view.titleLabel.text].width;
    return tempW;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect rect = self.moveLine.frame;
    if (!CGRectEqualToRect(rect, CGRectZero)) {
        return;
    }
    CGFloat btnW = WIDTH /self.btns.count;
    CGFloat btnH = self.wl_height;
    for (int i = 0; i < self.btns.count; i++) {
        UIButton *btn = self.btns[i];
        btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);

        btn.tag = i;
        if (i == _selectedIndex) {
            [self btnClick:btn];
        }
    }

    CGFloat moveLineW = [self getButtonWidthAtIndex:_selectedIndex];
    self.moveLine.wl_y = self.wl_height - 2;
    self.moveLine.wl_height = 2;
    self.moveLine.wl_width = moveLineW;
    self.moveLine.wl_centerX = self.selectBtn.wl_centerX;
    
    self.line.frame = CGRectMake(0, self.wl_height - 0.5, WIDTH, 0.5);

}

- (CGSize)stringSizeWithStringFont:(UIFont *)font lenthString:(NSString *)lenthString;
{
    CGSize textSize = CGSizeMake(WIDTH - 64, MAXFLOAT);
    NSDictionary *textAtrr = @{NSFontAttributeName:font};
    CGSize size = [lenthString boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:textAtrr context:nil].size;
    
    return size;
}

@end

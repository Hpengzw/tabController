//
//  ZWTabTitleView.h
//  ZWTabControllerDemo
//
//  Created by 黄鹏 on 2018/3/10.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZWTabTitleView;

@protocol ZWTabTitleViewDelegate <NSObject>

/**
 点击按钮，通过index 来确定按钮位置，从而做相应的事情

 @param titleView tabTitleView
 @param index 按钮位置
 */
- (void)titleView:(ZWTabTitleView   *)titleView didClickButtonAtIndex:(NSInteger)index;

@end

@interface ZWTabTitleView : UIView

@property (nonatomic, weak)     id <ZWTabTitleViewDelegate>  delegate;

/// 标题选中颜色
@property (nonatomic, strong)   UIColor  *selectColor;
///根据跳转时传入的索引，跳转到对于的界面
@property (nonatomic, assign) NSInteger selectedIndex;

/**
 初始化当前view
 
 @param titles 标题数组，用来设置按钮的标题
 @param equal 标题长度是否相等
 @return 实例
 */
- (instancetype)initWithTitleArray:(NSArray< NSString *> *)titles
                      isEqualTitle:(BOOL)equal;

///用来控制横线的滚动（通过index来确定横线位置）
- (void)bottomLineScollIndex:(NSInteger)index;

@end

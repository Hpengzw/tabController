//
//  ZWTabViewController.h
//  ZWTabControllerDemo
//
//  Created by 黄鹏 on 2018/3/10.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZWTabViewControllerDelegate,ZWTabViewControllerDataSource;

@interface ZWTabViewController : UIViewController

//数据源
@property (nonatomic, weak)     id < ZWTabViewControllerDataSource > dataSource;

//代理
@property (nonatomic, weak)     id < ZWTabViewControllerDelegate >  delegate;

//如果数据源方法获取不到值，则可通过下面属性赋值（推荐使用BaseControllerDataSource）
@property (nonatomic, strong)   NSArray *titles;
@property (nonatomic, strong)   NSArray *classes;

//子控制器标题长度是否不相等，默认为相等，该值为No
@property (nonatomic, assign)   BOOL    isUnequalTitle;
//默认选中
@property (nonatomic, assign)   NSInteger  defaultSelectIndex;

/// 记录标题选中颜色
@property (nonatomic, strong)   UIColor  *selectColor;

//父控制器标题
@property (nonatomic, strong)   NSString    *baseControllerTitle;

/// UICollectionView 水平方向的偏移量
@property (nonatomic, assign, readonly)   NSInteger  contentOffset;

/// 点击标题，或者滑动UICollectionView 会调用此方法
- (void)update ;

@end

@protocol ZWTabViewControllerDataSource <NSObject>

@required
//子控制器标题
- (NSArray *)titlesForChildViewControllers;
//子控制器类名
- (NSArray *)classNamesForchildViewController;

@end

@protocol ZWTabViewControllerDelegate <NSObject>

//自定义父控制器导航栏右侧item
- (UIView *)viewForBaseControllerRightBarButtonItem;

//自定义父控制器导航栏左侧item
- (UIView *)viewForBaseControllerLeftBarButtonItem;

//自定义父控制器底部bar
- (UIView *)viewForBaseControllerBottomBar;

//自定义底部view布局
- (void)customLayoutForBaseControllerBottomBar:(UIView *)bottmBar;

@end

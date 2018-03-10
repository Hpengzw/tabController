//
//  ZWTabViewController.m
//  ZWTabControllerDemo
//
//  Created by 黄鹏 on 2018/3/10.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import "ZWTabViewController.h"
#import "ZWTabTitleView.h"

@interface ZWTabViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ZWTabTitleViewDelegate>

@property (nonatomic, strong)   UICollectionView    *baseColletionView;
@property (nonatomic, strong)   ZWTabTitleView   *baseTitleView;

@property (nonatomic, strong)   NSArray *titlesArray;

@property (nonatomic, weak) UIView  *leftNavgationItem;
@property (nonatomic, weak) UIView  *rightNavgationItem;
@property (nonatomic, weak) UIView  *bottomBar;

@end

#define TITLEH (44.f)
@implementation ZWTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewSetting];
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewSetting {
    self.title = _baseControllerTitle;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupSubViews {
    [self setupChildController];
    [self baseTitleView];
    [self baseColletionView];
}

- (NSArray *)titlesArray {
    if (!_titlesArray) {
        _titlesArray = [self.dataSource titlesForChildViewControllers];
        _titlesArray = _titlesArray ? _titlesArray : self.titles;
    }
    return _titlesArray;
}

//delegate
- (void)setDelegate:(id<ZWTabViewControllerDelegate>)delegate {
    _delegate = delegate;
    if ([_delegate respondsToSelector:@selector(viewForBaseControllerLeftBarButtonItem)]) {
        _leftNavgationItem = [_delegate viewForBaseControllerLeftBarButtonItem];
    }
    if ([_delegate respondsToSelector:@selector(viewForBaseControllerRightBarButtonItem)]) {
        _rightNavgationItem = [_delegate viewForBaseControllerRightBarButtonItem];
    }
    
    if ([_delegate respondsToSelector:@selector(viewForBaseControllerBottomBar)]) {
        _bottomBar = [_delegate viewForBaseControllerBottomBar];
    }
    [self setupCustomViews];
}

- (ZWTabTitleView *)baseTitleView {
    if (!_baseTitleView) {
        _baseTitleView = [[ZWTabTitleView alloc]initWithTitleArray:self.titlesArray isEqualTitle:!self.isUnequalTitle];
        _baseTitleView.delegate = self;
        _baseTitleView.selectedIndex = _defaultSelectIndex;
        _baseTitleView.selectColor = self.selectColor ? self.selectColor : nil;
        [self.view addSubview:_baseTitleView];
        _baseTitleView.wl_x = 0;
        _baseTitleView.wl_y = 64;
        _baseTitleView.wl_width = self.view.frame.size.width;
        _baseTitleView.wl_height = TITLEH;
    }
    return _baseTitleView;
}

- (UICollectionView *)baseColletionView {
    if (!_baseColletionView) {
        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
        fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _baseColletionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                collectionViewLayout:fl];
        _baseColletionView.dataSource = self;
        _baseColletionView.delegate = self;
        _baseColletionView.pagingEnabled = YES;
        _baseColletionView.bounces = NO;
        _baseColletionView.showsHorizontalScrollIndicator = NO;
        _baseColletionView.backgroundColor = [UIColor lightGrayColor];
        [_baseColletionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [self.view addSubview:_baseColletionView];
        _baseColletionView.wl_x = 0;
        _baseColletionView.wl_y = TITLEH+64;
        _baseColletionView.wl_width = self.view.frame.size.width;
        _baseColletionView.wl_height = self.view.frame.size.height -TITLEH-64;
    }
    return _baseColletionView;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titlesArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *controller = self.childViewControllers[indexPath.row];
    controller.view.frame = CGRectMake(0,0, WIDTH, HEIGHT - TITLEH-64);
    [cell.contentView addSubview:controller.view];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(WIDTH, HEIGHT-TITLEH-64);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return .0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return .0f;
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = (NSInteger)scrollView.contentOffset.x/WIDTH;
    [self.baseTitleView bottomLineScollIndex: page];
    [self update];//子类重写该方法，可监听标滑动事件
}

#pragma mark - ZSFindTitleViewDelegate
- (void)titleView:(ZWTabTitleView *)titleView didClickButtonAtIndex:(NSInteger)index {
    [UIView animateWithDuration:0.0001 animations:^{
        _baseColletionView.contentOffset = CGPointMake(WIDTH *index, 0);
        [self update];//子类重写该方法，可监听标题按钮点击事件
    }];
}

#pragma mark - 初始化子类控制器

- (void)setupChildController {
    NSArray *childControllers = [self.dataSource classNamesForchildViewController];
    childControllers  = childControllers ? childControllers : self.classes;
    UIViewController *controller;
    for (int i = 0; i<childControllers.count; i++) {
        controller = [[NSClassFromString(childControllers[i]) alloc]init];
        [self addChildViewController:controller];
    }
}

#pragma mark - 自定义view

- (void)setupCustomViews {
    
    if (_leftNavgationItem) {
        self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc]initWithCustomView:_leftNavgationItem];
    }
    
    if (_rightNavgationItem) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_rightNavgationItem];
    }
    if (_bottomBar) {
        [self.view addSubview:_bottomBar];
        if ([self.delegate respondsToSelector:@selector(customLayoutForBaseControllerBottomBar:)]) {
            [self.delegate customLayoutForBaseControllerBottomBar:_bottomBar];
        }else {
            _bottomBar.wl_x = 0;
            _bottomBar.wl_width = WIDTH;
            _bottomBar.wl_height = TABBARH;
            _bottomBar.wl_centerX = self.view.center.x;
        }
    }
}

- (NSInteger)offsetX {
    return (NSInteger)self.baseColletionView.contentOffset.x/WIDTH;
}

- (void)update{};


@end

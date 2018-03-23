//
//  TabChildViewController.m
//  ZWTabControllerDemo
//
//  Created by 黄鹏 on 2018/3/10.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import "TabChildViewController.h"
#import "TabBottomBar.h"
#import "PushViewController.h"

@interface TabChildViewController ()<TabBottomBarDelegate>

@property (nonatomic, strong)   UIButton    *publishAcitonButton;
@property (nonatomic, strong)   TabBottomBar  *bottomBar;
/// description
@property (nonatomic, assign)   NSInteger  offset;

@end

@implementation TabChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BaseControllerDelegate

- (UIView *)viewForBaseControllerLeftBarButtonItem {
    return self.publishAcitonButton;
}


- (UIButton *)publishAcitonButton {
    if (!_publishAcitonButton) {
        _publishAcitonButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _publishAcitonButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_publishAcitonButton setTitle:[NSString stringWithFormat:@"退出"] forState:UIControlStateNormal];
        [_publishAcitonButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_publishAcitonButton sizeToFit];
        [_publishAcitonButton addTarget:self action:@selector(publishAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishAcitonButton;
}

- (void)publishAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (UIView *)viewForBaseControllerBottomBar {
    return self.bottomBar;
}

- (TabBottomBar *)bottomBar {
    if (!_bottomBar) {
        _bottomBar = [[TabBottomBar alloc]init];
        _bottomBar.backgroundColor = [UIColor orangeColor];
        _bottomBar.delegate = self;
    }
    return _bottomBar;
}

#pragma  mark - TabBottomBarDelegate

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)jump {
    PushViewController *controller = [[PushViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

///更新
- (void)update {
    if (self.contentOffset != self.offset) {
        self.bottomBar.backgroundColor = ZSRandomColor();
        self.offset = self.contentOffset;
    }
}

@end

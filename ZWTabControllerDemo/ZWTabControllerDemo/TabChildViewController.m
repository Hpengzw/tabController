//
//  TabChildViewController.m
//  ZWTabControllerDemo
//
//  Created by 黄鹏 on 2018/3/10.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import "TabChildViewController.h"

@interface TabChildViewController ()

@property (nonatomic, strong)   UIButton    *publishAcitonButton;

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


@end

//
//  PushViewController.m
//  ZWTabControllerDemo
//
//  Created by huang ytand on 2018/3/23.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

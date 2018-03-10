//
//  ViewController.m
//  ZWTabControllerDemo
//
//  Created by 黄鹏 on 2018/3/10.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import "ViewController.h"
#import "TabChildViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)jumpToTabContrller:(UIButton *)sender {
    TabChildViewController *vc = [[TabChildViewController alloc]init];
    vc.baseControllerTitle = @"父子控制器";
    vc.titles = @[@"界面1",@"界面2",@"界面3"];
    vc.classes = @[@"ThemeViewController",@"ThemeViewController",@"ThemeViewController"];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

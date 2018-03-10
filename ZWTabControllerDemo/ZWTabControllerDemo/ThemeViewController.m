//
//  ThemeViewController.m
//  ZWTabControllerDemo
//
//  Created by 黄鹏 on 2018/3/10.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import "ThemeViewController.h"

@interface ThemeViewController ()

@end

@implementation ThemeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZSRandomColor();
    NSLog(@"2");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

UIColor *RGB(CGFloat r, CGFloat g, CGFloat b){
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f];
}


UIColor *ZSRandomColor(){
    return RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));
}

@end

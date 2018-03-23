//
//  GlobalUitilitis.m
//  ZWTabControllerDemo
//
//  Created by huang ytand on 2018/3/23.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import "GlobalUitilitis.h"

UIColor *RGB(CGFloat r, CGFloat g, CGFloat b){
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f];
}


UIColor *ZSRandomColor(){
    return RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));
}


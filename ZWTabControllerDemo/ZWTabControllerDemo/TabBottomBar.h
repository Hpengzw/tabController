//
//  TabBottomBar.h
//  ZWTabControllerDemo
//
//  Created by huang ytand on 2018/3/23.
//  Copyright © 2018年 ytandhr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TabBottomBarDelegate <NSObject>

- (void)back;

- (void)jump;

@end

@interface TabBottomBar : UIView

@property (nonatomic, weak)     id <TabBottomBarDelegate>  delegate;

@end

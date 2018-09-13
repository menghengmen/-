//
//  MainTabBarController.m
//  Yueshijia
//
//  Created by CosyVan on 2016/11/20.
//  Copyright © 2016年 Jeffery. All rights reserved.
//

#import "MainTabBarController.h"

#import "newDiscountViewController.h"
#import "MyTabBar.h"
#import "NavigationViewController.h"
#import "MHActivityViewController.h"
#import "MHPeopleInfoViewController.h"
//
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    newDiscountViewController *storeVC = [[newDiscountViewController alloc] init];
    storeVC.title = @"游玩";
    [self addChildVC:storeVC imageName:@"tab_03" selectedImageName:@"tab_03_pre"];
    
   
    MHActivityViewController *vc = [MHActivityViewController new];
    vc.title = @"活动";
    [self addChildVC:vc imageName:@"tab_05" selectedImageName:@"tab_05_pre"];

    
    
    MHPeopleInfoViewController *homeVC = [[MHPeopleInfoViewController alloc] init];
    homeVC.title = @"个人中心";
    [self addChildVC:homeVC imageName:@"tab_01" selectedImageName:@"tab_01-pre"];
    
  
    
    
    
    
 
    
   
    
    MyTabBar *myTabBar = [[MyTabBar alloc] init];
    [self setValue:myTabBar forKey:@"tabBar"];
}

- (void)addChildVC:(UIViewController *)childVc imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    
    //设置文字样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = RGB(168, 168, 168);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = RGB(1,131,220);
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 添加为tabbar控制器的子控制器
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}



@end

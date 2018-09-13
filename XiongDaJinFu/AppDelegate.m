//
//  AppDelegate.m
//  MaDongFrame
//
//  Created by 码动 on 16/10/8.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideViewController.h"
#import "MainTabBarController.h"
#import "AvoidCrash.h"
#import "IQKeyboardManager.h"

#import "LoginViewController.h"
@interface AppDelegate ()
<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //[self initMainController];
    //[XDCommonTool goToMain];
    
    
    //这句代码会让AvoidCrash生效，若没有如下代码，则AvoidCrash就不起作用
    
    [AvoidCrash becomeEffective];
   //self.window.rootViewController = [[LoginViewController alloc] init];
    self.window.rootViewController = [[LoginViewController alloc] init];
    //键盘设置（无需设置，直接编译即可）
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = false;
    manager.preventShowingBottomBlankSpace = true;
    
 
    [self.window makeKeyAndVisible];
    
    return YES;
}




#pragma mark- 根据设备获取 自定义fontSize
- (CGFloat)fontSize{
    if (CGSizeEqualToSize(self.window.frame.size, CGSizeMake(320, 480))) {
        _fontSize = 15.0;
    }else if (CGSizeEqualToSize(self.window.frame.size, CGSizeMake(320, 568))){
        _fontSize = 16.0;
    }else if (CGSizeEqualToSize(self.window.frame.size, CGSizeMake(375, 667))){
        _fontSize = 17.0;
    }else if (CGSizeEqualToSize(self.window.frame.size, CGSizeMake(414, 736))){
        _fontSize = 20.0;
    }
    
    return _fontSize;
}

@end

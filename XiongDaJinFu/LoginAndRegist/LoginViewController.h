//
//  LoginViewController.h
//  MaDongFrame
//
//  Created by 码动 on 16/10/8.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserLoginViewControllerDelegate <NSObject>

- (void)didCompletedUserLoginViewController:(UIViewController *)picker withResult:(id)data withError:(NSError *)error;
- (void)didCanceledUserLoginViewController:(UIViewController *)picker;

@end


@interface LoginViewController : UIViewController

@property (nonatomic) id <UserLoginViewControllerDelegate> delegate;

@end

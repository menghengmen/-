//
//  registerViewController.m
//  XiongDaJinFu
//
//  Created by gary on 2016/12/6.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import "registerViewController.h"
#import "UIViewController+HUD.h"

@interface registerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITextField *account;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassword;


@end
@implementation registerViewController


- (void)viewDidLoad{
    self.title = @"注册";
}
- (IBAction)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerClick:(UIButton *)sender {
    if ([self.account.text isEqualToString:@""]) {
        [self showHint:@"账号不能为空"];
        return;
    }
    if ([self.password.text isEqualToString:@""]) {
        [self showHint:@"密码不能为空"];
        return;
    }
    if (![self.password.text isEqualToString:self.confirmPassword.text]) {
        [self showHint:@"两次密码输入不一致"];
        return;
    }
    NSDate  *today = [NSDate date];
    NSDateFormatter  *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-mm-dd";
    
    
    NSString  * str = [NSString stringWithFormat:@"%@?uiAccount=%@&uiPwd=%@&uiBirthday=%@",URL_REGISTER,self.account.text,self.password.text,[formatter stringFromDate:today]];

    [[NetworkClient sharedClient] POST:str dict:nil succeed:^(id data) {
        NSLog(@"%@",data);
        NSArray *arr = (NSArray*)data;
        if ([[arr.firstObject objectForKey:@"loginStatus"] integerValue]==0) {
            [self showHint:@"注册成功"];
            [self dismissViewControllerAnimated:YES completion:nil];

        } else{
            [self showHint:@"注册失败"];

        }

    } failure:^(NSError *error) {
        [self showHint:@"注册失败"];

    }];
}


@end

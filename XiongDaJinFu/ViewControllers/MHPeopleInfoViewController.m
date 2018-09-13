//
//  MHPeopleInfoViewController.m
//  XiongDaJinFu
//
//  Created by 哈哈 on 2017/7/11.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "MHPeopleInfoViewController.h"
#import "MHPasswordChangeViewController.h"
#import "MHChangePeopleInfoTableViewController.h"
#import "JSWave.h"
#import "LoginViewController.h"
@interface MHPeopleInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *table;
@property (nonatomic, strong) JSWave *headerView;
@property (nonatomic, strong) UILabel *iconLabel;

@end

@implementation MHPeopleInfoViewController

- (UILabel *)iconLabel{
    
    if (!_iconLabel) {
        _iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 60)];
        _iconLabel.textColor = [UIColor whiteColor];
        _iconLabel.textAlignment = NSTextAlignmentCenter;
        NSString  * iconStr = [[XDCommonTool readDicFromUserDefaultWithKey:USER_INFO].firstObject objectForKey:@"uiNickname"];
        _iconLabel.text = [NSString stringWithFormat:@"欢迎使用  | %@",iconStr];
   
    }
    return _iconLabel;
}

- (JSWave *)headerView{
    
    if (!_headerView) {
        _headerView = [[JSWave alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 180)];
        _headerView.backgroundColor = [UIColor colorWithHexString:@"#0183dc"];
        [_headerView addSubview:self.iconLabel];
        __weak typeof(self)weakSelf = self;
        _headerView.waveBlock = ^(CGFloat currentY){
            CGRect iconFrame = [weakSelf.iconLabel frame];
            iconFrame.origin.y = CGRectGetHeight(weakSelf.headerView.frame)-CGRectGetHeight(weakSelf.iconLabel.frame)+currentY-weakSelf.headerView.waveHeight;
            weakSelf.iconLabel.frame  =iconFrame;
        };
        [_headerView startWaveAnimation];
    }
    return _headerView;
}


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.table];
    
    self.view.backgroundColor =[UIColor colorWithHexString:@"#fafafa"];
    self.automaticallyAdjustsScrollViewInsets =NO;
    [self setUpNewNai:nil Title:@"个人中心"];



    UIButton  * btn = [[UIButton alloc] init];
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithHexString:@"#1c91fd"];
    btn.layer.cornerRadius = 10;
    btn.clipsToBounds = YES;
    
    [btn addTarget:self action:@selector(logOut1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
   
   [btn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.bottom.equalTo(btn.superview.mas_bottom).offset(-80);
       make.width.equalTo(@300);
       make.height.equalTo(@40);
       make.centerX.equalTo(btn.superview);
   }];

}
-(void)logOut1{
  [UIApplication sharedApplication].keyWindow.rootViewController = [[LoginViewController alloc] init];
    
}
-(UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height+200) style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.rowHeight = 100*SCREENHEIGHT/1334;
        _table.tableFooterView = [[UIView alloc] init];
        _table.sectionHeaderHeight = 180;
    
    }
    return _table;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   return self.headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100*SCREENHEIGHT/1334;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView * containerView = [UIView new];
        [cell addSubview:containerView];
        containerView.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(cell);
            make.height.equalTo(@50);
            make.centerY.equalTo(cell);
        }];
        
        UIImageView *picImage = [UIImageView new];
        [cell addSubview:picImage];
        [picImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(containerView).offset(15);
            make.width.equalTo(@22);
            make.height.equalTo(@22);
            make.centerY.equalTo(containerView);
        }];
        
        UILabel * cellLabel = [UIFactory newlabelWithTextColor:[UIColor colorWithHexString:@"595959"] withTitle:nil fontSize:15];
        cellLabel.textAlignment = NSTextAlignmentLeft;
        [cell addSubview:cellLabel];
        [cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(picImage.mas_right).offset(16);
            make.centerY.equalTo(containerView);
            make.width.equalTo(@200);
            make.height.equalTo(@17);
        }];
        switch (indexPath.row) {
                
            case 0:
                picImage.image = [UIImage imageNamed:@"grzx_icon1"];
                cellLabel.text = @"个人资料";
                break;
                
            case 1:
                picImage.image = [UIImage imageNamed:@"grzx_icon2"];
                cellLabel.text = @"登录密码";
                break;
           
                
                    default:
                break;
        }
        
        
        
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[MHChangePeopleInfoTableViewController new] animated:YES];
            

            break;
        case 1:
            [self.navigationController pushViewController:[MHPasswordChangeViewController new] animated:YES];
            
            
            break;
        
       
        
        default:
            break;
    }
    
    
    
  }



@end

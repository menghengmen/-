//
//  MHChangePeopleInfoTableViewController.m
//  XiongDaJinFu
//
//  Created by 哈哈 on 2017/7/12.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "MHChangePeopleInfoTableViewController.h"
#import "XLInfoTextCell.h"
#import "DatePickerView.h"
#import "UIViewController+HUD.h"
@interface MHChangePeopleInfoTableViewController ()<XLInfoTextCellDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *table;
@property (strong,nonatomic) DatePickerView *datePickerView;

@end

@implementation MHChangePeopleInfoTableViewController

-(UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height+200) style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.rowHeight = 100*SCREENHEIGHT/1334;
        _table.tableFooterView = [[UIView alloc] init];
        _table.sectionHeaderHeight = 225;
        
    }
    return _table;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpNewNai:nil Title:@"修改用户信息"];
    [self setUpUI];
}
-(void)setUpUI{
    
    [self.view addSubview:self.table];
    UIButton *btn = [UIButton new];
    btn.backgroundColor =[UIColor colorWithHexString:@"#0183dc"];
    [btn setTitle:@"更新" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeInfos) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.height.equalTo(@(40));
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray  * userArr = [XDCommonTool readDicFromUserDefaultWithKey:USER_INFO];

    
    XLInfoTextCell *cell = [XLInfoTextCell  infoText:tableView];
    cell.text.textAlignment = NSTextAlignmentLeft;
    cell.name.textAlignment = NSTextAlignmentCenter;
    cell.delegate = self;
    switch (indexPath.row) {
        case 0:{
            cell.name.text = @"昵称";
            
            cell.text.placeholder = [userArr.firstObject objectForKey:@"uiNickname"];
            cell.text.tag = 101;
            break;
        }
        
        case 1:
            cell.name.text = @"出生日期";
            cell.text.placeholder = [userArr.firstObject objectForKey:@"uiBirthday"];
            cell.text.userInteractionEnabled = NO;
            [cell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBirthday)]];
            cell.text.tag = 100;
            break;
            

            
        default:
            break;
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   


}

-(void)changeBirthday{
    _datePickerView = [[DatePickerView alloc] initWithCustomeHeight:200];
    __weak typeof (self) weakSelf = self;
    _datePickerView.confirmBlock = ^(NSString *choseDate, NSString *restDate) {
        
        UITextField  * text =    [weakSelf.view viewWithTag:100];
        text.text = choseDate;
    };
    
    _datePickerView.cannelBlock = ^(){
        
        [weakSelf.view endEditing:YES];
        
    };
    [self.view addSubview:_datePickerView];


}


- (void)personInfoChange:(NSString *)change andCell:(XLInfoTextCell *)cell{

}
- (void)personInfoBeginEdit:(UITextField *)textField andCell:(XLInfoTextCell *)cell{


}
-(void)changeInfos{

    //昵称
    UITextField  * text =    [self.view viewWithTag:101];
    UITextField  * birthdayText =    [self.view viewWithTag:100];
    if ([text.text isEqualToString:@""]) {
        [self showHint:@"昵称没有更改"];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSDictionary  * dict = @{@"id":[[XDCommonTool readDicFromUserDefaultWithKey:USER_INFO].firstObject objectForKey:@"id"],@"uiNickname":text.text,@"uiBirthday":birthdayText.text,@"loginToken":[[XDCommonTool readDicFromUserDefaultWithKey:USER_INFO].firstObject objectForKey:@"loginToken"]};
    [[NetworkClient sharedClient] GET:URL_UPDATE_INFO dict:dict succeed:^(id data) {
        NSLog(@"%@",data);
        NSArray  * dataArr = (NSArray*)data;
        NSDictionary*dict = dataArr.firstObject;
        if ([[dict objectForKey:@"loginStatus"] integerValue]==0) {
            [self showHint:@"信息更改成功"];

        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        NSLog(@"%@",error);
    }];
    




}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  playDetailViewController.m
//  XiongDaJinFu
//
//  Created by 哈哈 on 2018/9/11.
//  Copyright © 2018年 digirun. All rights reserved.
//

#import "playDetailViewController.h"
#import "DetailCell.h"
@interface playDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)  UITableView  * tableView;

@end

@implementation playDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}
- (void)setUpUI{
   
    if (_currentType == DETAIL_TYPE_PLAY) {
        [self setUpNewNai:nil Title:@"景区详情"];

    } else{
        [self setUpNewNai:nil Title:@"活动详情"];

    }
    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    UITableView  * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView = tableView;
    [self.view addSubview:tableView];
  
    
}
#pragma mark UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString  * idStr = @"DetailCell";
    DetailCell * cell = [tableView dequeueReusableCellWithIdentifier:idStr ];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.introduceLabel.text = self.introduce;
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

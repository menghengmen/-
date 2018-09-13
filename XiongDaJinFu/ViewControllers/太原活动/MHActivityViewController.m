//
//  MHActivityViewController.m
//  XiongDaJinFu
//
//  Created by 哈哈 on 2017/7/8.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "MHActivityViewController.h"
#import "playDetailViewController.h"
#import "MHAcvicityTableViewCell.h"


#define kTag90 90

@interface MHActivityViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIView *greenView;
@property (nonatomic, strong) NSMutableArray *btnArrayM;
@property (nonatomic,strong)  NSMutableArray  * dataArray;

@end

@implementation MHActivityViewController
{
    UITableView *_tableView;
    int  type;
    
   
}

- (NSMutableArray*)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray  alloc] init];
    }
    
    return _dataArray;
}



- (NSMutableArray *)btnArrayM
{
    if (!_btnArrayM) {
        _btnArrayM = [NSMutableArray array];
    }
    return _btnArrayM;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataWithType:0];
    type = kTag90;
    
    [self setUpNewNai:nil Title:@"太原市活动预览"];
    
    [self setUpUI];
}

-(void)setUpUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+45, SCREENWIDTH,SCREENHEIGHT) style:UITableViewStylePlain];
    
    _tableView.contentInset=UIEdgeInsetsMake(0, 0, 150, 0);
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
    _tableView.tableHeaderView.backgroundColor = [UIColor colorWithHexString:@"#ebebeb"];
    _tableView.tableFooterView = [UIView new];
    _tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_tableView];
    
    
    NSArray *arr = @[@"全部", @"进行中"];
    
    CGFloat bigW = globalRect.size.width / arr.count;
    for (int i = 0; i < arr.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(bigW * i, 64, bigW, 45)];
        btn.tag = (i + 1) *kTag90;
        [btn setTitleColor: [UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [btn setTitleColor: [UIColor colorWithHexString:@"#0c94f5"] forState:UIControlStateSelected];        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(bigBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArrayM addObject:btn];
        [self.view addSubview:btn];
        if (i == 0) {
            btn.selected = YES;
        }
    }
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64+45, bigW, 2)];
    view.backgroundColor = [UIColor colorWithHexString:@"#0c94f5"];
    [self.view addSubview:view];
    self.greenView = view;
    
    
}





# pragma ACTION
-(void)bigBtnClick:(UIButton*)sender{
    
    
    switch (sender.tag) {
        
        case kTag90:
        case kTag90*2:
            [self getDataWithType:(int)(sender.tag-kTag90)/kTag90];
            break;
            
            
        default:
            break;
    }
    
    
    
    type =(int)sender.tag;
    
    sender.selected = YES;
    for (UIButton *button in self.btnArrayM) {
        if (button != sender) {
            button.selected = NO;
        }
    }
    
    CGRect rect = self.greenView.frame;
    rect.origin.x = sender.frame.origin.x;
    [UIView animateWithDuration:0.5 animations:^{
        self.greenView.frame = rect;
        
    }];
    
    
    [_tableView reloadData];
    
    
}


#pragma mark -tableView
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    return self.dataArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (type) {
        case kTag90:
        case kTag90*2:
        case kTag90*3:
            return 396/2;
            break;
        
       
       default:
            break;
    
    
    }
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (type) {
        case kTag90:
        case kTag90*2:
        case kTag90*3:
        {
            static  NSString  * idStr = @"MHAcvicityTableViewCell";
            MHAcvicityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idStr ];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MHAcvicityTableViewCell" owner:self options:nil] lastObject];
                
            }
            cell.MODEL = self.dataArray[indexPath.row];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        
            
            
        default:
            break;
    }
    
    
    
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
    
    
    MHAcvicityModel  * model = self.dataArray[indexPath.row];
    
    playDetailViewController *vc = [playDetailViewController new];
    vc.currentType = DETAIL_TYPE_ACVICITY;
    vc.introduce = model.detail;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)getDataWithType:(int)typeInt {
    
    
    [self.dataArray removeAllObjects];
    NSString *path;
    if (typeInt == 1) {
        path = [[NSBundle mainBundle] pathForResource:@"AllAcvicityData" ofType:@"plist"];
    } else {
        path = [[NSBundle mainBundle] pathForResource:@"acvicityData" ofType:@"plist"];

    }

    NSArray *dataArr = [NSArray arrayWithContentsOfFile:path];
    [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MHAcvicityModel *mdoel = [MHAcvicityModel mj_objectWithKeyValues:obj];
        [self.dataArray addObject:mdoel];
    }];
    [self.tableView reloadData];
}

@end

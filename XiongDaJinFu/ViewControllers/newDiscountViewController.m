//
//  discountViewController.m
//  XiongDaJinFu
//
//  Created by gary on 2016/12/5.
//  Copyright © 2016年 digirun. All rights reserved.
//

#import "newDiscountViewController.h"
#import "EmotionalTableViewCell.h"
#import "MHMusicList.h"
#import "playDetailViewController.h"
@interface newDiscountViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)  NSMutableArray  * dataArray;


@property (nonatomic,strong)  UITableView  * musicListTableView;

@end
@implementation newDiscountViewController
- (NSMutableArray*)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray  alloc] init];
     }
    
    return _dataArray;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
   
}

- (void)viewDidLoad{
    [self setUpNewNai:nil Title:@"太原景区概览"];
    UITableView  * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.sectionHeaderHeight = 300;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    self.musicListTableView = tableView;
    
    UIImageView  * view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
    view.contentMode = UIViewContentModeScaleAspectFill;
    view.image = [UIImage imageNamed:@"play_banner"];
    tableView.tableHeaderView = view;
    [self.view addSubview:tableView];
    [self getLocalData];
 
}
#pragma mark UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 270*SCREENHEIGHT/1334;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString  * idStr = @"EmotionalTableViewCell";
    EmotionalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idStr ];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EmotionalTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.musciModel =self.dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    playDetailViewController *vc = [playDetailViewController new];
    MHMusicList *model = self.dataArray[indexPath.row];
    vc.introduce = model.introduce;
    vc.currentType = DETAIL_TYPE_PLAY;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)getLocalData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"playData" ofType:@"plist"];
    NSArray *dataArr = [NSArray arrayWithContentsOfFile:path];
    [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         MHMusicList  * model = [MHMusicList mj_objectWithKeyValues:(NSDictionary*)obj];
        [self.dataArray addObject:model];
    }];
    [self.musicListTableView reloadData];
}


@end

//
//  playDetailViewController.h
//  XiongDaJinFu
//
//  Created by 哈哈 on 2018/9/11.
//  Copyright © 2018年 digirun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DetailType){
    DETAIL_TYPE_PLAY = 0,  //景区
    DETAIL_TYPE_ACVICITY,  //活动
};

@interface playDetailViewController : BaseViewController
@property   (nonatomic,copy)   NSString*introduce;
@property (nonatomic, assign)  DetailType currentType;

@end

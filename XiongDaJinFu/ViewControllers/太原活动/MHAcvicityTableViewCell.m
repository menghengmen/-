//
//  MHAcvicityTableViewCell.m
//  XiongDaJinFu
//
//  Created by 哈哈 on 2017/7/16.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "MHAcvicityTableViewCell.h"

@implementation MHAcvicityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithHexString:@"#eff4f5"];

    self.acvicityBackView.backgroundColor = [UIColor colorWithHexString:@"#fefefe"];


    self.numberLabel.textColor = [UIColor colorWithHexString:@"#6a97b1"];

   self.numberLabel.layer.borderColor =[UIColor colorWithHexString:@"#6a97b1"].CGColor;

    self.numberLabel.layer.borderWidth = 2;
}

-(void)setMODEL:(MHAcvicityModel *)MODEL{

    self.acvicityImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",MODEL.actiLogoUrl]];
    
    self.nameLabel.text = MODEL.actiName;

    self.numberLabel.text = [NSString stringWithFormat:@"%@人参与",MODEL.actiNum];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

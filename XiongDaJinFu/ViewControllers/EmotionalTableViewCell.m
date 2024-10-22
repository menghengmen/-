//
//  EmotionalTableViewCell.m
//  XiongDaJinFu
//
//  Created by 哈哈 on 2017/7/8.
//  Copyright © 2017年 digirun. All rights reserved.
//

#import "EmotionalTableViewCell.h"

@implementation EmotionalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView.backgroundColor = [[UIColor colorWithHexString:@"#000000"] colorWithAlphaComponent:0.5f];
}
-(void)setMusciModel:(MHMusicList *)musciModel{
 
    self.mainImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpeg",musciModel.dptLogoURL]];
    [self.mainImageView addSubview:self.backgroundView];


    
    self.dptNameLabel.text = musciModel.dptName;
    self.dptDescLabel.text = musciModel.dptDesc;
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

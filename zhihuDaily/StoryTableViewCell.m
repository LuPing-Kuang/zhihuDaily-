//
//  StoryTableViewCell.m
//  zhihuDaily
//
//  Created by 邝路平 on 16/6/11.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import "StoryTableViewCell.h"


@implementation StoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [self superview];//布局父类控件
    
    //调整子控件的frame
    CGRect customersViewFrame=CGRectMake(self.frame.size.width-80, 10, 70, 50);
    self.imageView.frame=customersViewFrame;
    CGRect customersLabelFrame=CGRectMake(10, 10, self.frame.size.width-100, 50);
    self.textLabel.frame=customersLabelFrame;
}

@end

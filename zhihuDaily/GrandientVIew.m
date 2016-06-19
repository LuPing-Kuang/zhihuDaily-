//
//  GrandientVIew.m
//  zhihuDaily
//
//  Created by 邝路平 on 16/6/15.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import "GrandientVIew.h"

@implementation GrandientVIew

-(instancetype)init{
    if (self=[super init]) {
        return [self initWithFrame:CGRectZero];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.translatesAutoresizingMaskIntoConstraints=NO;
        self.backgroundColor=[UIColor clearColor];
        [self.layer addSublayer:self.gradientLayer];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        self.translatesAutoresizingMaskIntoConstraints=NO;
        self.backgroundColor=[UIColor clearColor];
        [self.layer addSublayer:self.gradientLayer];
    }
    return self;
}

#pragma  mark 
-(CAGradientLayer*)gradientLayer{
    if (_gradientLayer==nil) {
        _gradientLayer=[CAGradientLayer layer];
        _gradientLayer.frame=self.frame;
        _gradientLayer.borderWidth=0;
        _gradientLayer.colors=[NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor],(id)[UIColor colorWithWhite:0 alpha:0.85], nil];
        _gradientLayer.locations=@[[NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:1.0]];
    }
    return _gradientLayer;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.gradientLayer.frame=self.bounds;
}


@end

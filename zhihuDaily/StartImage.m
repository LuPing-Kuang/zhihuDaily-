//
//  StartImage.m
//  zhihuDaily
//
//  Created by 邝路平 on 16/6/11.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import "StartImage.h"

@implementation StartImage

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self=[super init]) {
        self.img=dic[@"img"];
        self.text=dic[@"text"];
    }
    return self;
}

+(instancetype)startImageWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end

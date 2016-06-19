//
//  Story.m
//  zhihuDaily
//
//  Created by 邝路平 on 16/6/13.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import "Story.h"

@implementation Story
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.id=[dic[@"id"] integerValue];
        self.type=[dic[@"type"] integerValue];
        self.css=[dic[@"css"] firstObject];
        self.body=dic[@"body"];
        self.title=dic[@"title"];
        self.image=dic[@"image"];
        self.imageSource=dic[@"imageSource"];
    }
    return self;
}

+(instancetype)storyWithDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDictionary:dic];
}

@end

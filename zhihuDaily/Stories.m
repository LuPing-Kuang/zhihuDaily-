//
//  Stories.m
//  zhihuDaily
//
//  Created by 邝路平 on 16/6/13.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import "Stories.h"

@implementation Stories

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self=[super init]) {
        self.title=dic[@"titile"];
        self.ga_prefix=dic[@"ga_prefix"];
        self.images=dic[@"images"];
        self.image=dic[@"image"];
        self.type=[dic[@"type"] integerValue];
        self.identifier=[dic[@"identifier"] integerValue];
        self.multipic=[dic[@"multipic"] integerValue];
    }
    
    return self;
}

+(instancetype)storiesWithDictionary:(NSDictionary *)dic{
    return [[self alloc] initWithDictionary:dic];
}

+(NSArray<Stories*>*)stories:(NSArray *)array{
    NSMutableArray *mTarray=[NSMutableArray array];
    for(id obj in array){
        [mTarray addObject:[self storiesWithDictionary:obj]];
    }
    return mTarray;
}


@end

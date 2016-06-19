//
//  GCD.m
//  zhihuDaily
//
//  Created by 邝路平 on 16/6/12.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import "GCD.h"

@implementation GCD
#pragma mark- 执行同步异步操作
-(void)async:(dispatch_block_t)block{
    dispatch_async(self.queue, block);
}

-(void)asyncWithGroup:(dispatch_group_t)group block:(dispatch_block_t)block{
    dispatch_group_async(group, self.queue, block);
}

-(void)asyncGroupNotify:(dispatch_group_t)group block:(dispatch_block_t)block{
    dispatch_group_notify(group, self.queue, block);
}

-(void)sync:(dispatch_block_t)block{
    dispatch_sync(self.queue, block);
}

//不需要判断super init ，因为是直接调用方法生成instancetype
//创建单例
+(instancetype)mainQueue{
    static GCD *gcd=nil;
    static dispatch_once_t onetoken;
    dispatch_once(&onetoken, ^{
        gcd=[[GCD alloc]init];
        gcd.queue=dispatch_get_main_queue();
    });
    return gcd;
}

+(instancetype)globalQueueWithLevel:(GCDPriorityQueueLevel)level{
    static GCD *gcd=nil;
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        gcd=[[GCD alloc]init];
        gcd.queue=dispatch_get_global_queue(level, 0);
    });
    return gcd;
}

@end

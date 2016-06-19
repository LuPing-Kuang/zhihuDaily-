//
//  CacheData.h
//  zhihuDaily
//
//  Created by 邝路平 on 16/6/15.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString* const kDataPath;

@interface CacheData : NSObject
@property (nonatomic,strong) NSString *dataPath;
@property (nonatomic,strong) NSString *doucumentPath;
@property (nonatomic,strong) NSMutableDictionary *dataDic;
-(void)saveData;

@end

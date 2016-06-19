//
//  CacheData.m
//  zhihuDaily
//
//  Created by 邝路平 on 16/6/15.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import "CacheData.h"

NSString* const kDataPath = @"data.plist";

@interface CacheData()

@end

@implementation CacheData

-(NSString*)doucumentPath{
    if (_doucumentPath==nil) {
        _doucumentPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/"];
      
    }
    return _doucumentPath;
}

-(NSString*)dataPath{
    if (_dataPath==nil) {
        _dataPath=[self.doucumentPath stringByAppendingString:kDataPath];
    }
    return _dataPath;
}

-(NSMutableDictionary*)dataDic{
    if (_dataDic==nil) {
        _dataDic=[NSMutableDictionary dictionary];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.dataPath]) {
        _dataDic=[NSMutableDictionary dictionaryWithContentsOfFile:self.dataPath];
    }else{
        [[NSFileManager defaultManager] createFileAtPath:self.dataPath contents:nil attributes:nil];
    }
    return _dataDic;
}

-(void)saveData{
    BOOL saveData=[self.dataDic writeToFile:self.dataPath atomically:YES];
    if (saveData) {
        NSLog(@"数据保存成功");
    }
}

@end

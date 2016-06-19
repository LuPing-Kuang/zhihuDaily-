//
//  DataSource.m
//  zhihuDaily
//
//  Created by 邝路平 on 16/6/15.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import "DataSource.h"
#import "CacheData.h"
#import "URLRequest.h"
#import "Stories.h"

/*缓存图片*/
static NSString* const DATAKEY_CACHEDIMAGES = @"CachedImages";
static NSString* const DATAKEY_CACHEDIMAGES_URL = @"url";
static NSString* const DATAKEY_CACHEDIMAGES_FILENAME = @"fileName";

/*起始图片*/
static NSString* const DATAKEY_STARTIMAGE = @"StartImage";
static NSString* const DATAKEY_STARTIMAGE_AUTHOR = @"StartImageAuthor";
static NSString* const DATAKEY_STARTIMAGE_URL = @"StartImageUrl";

/*首页数据*/
static NSString* const DATAKEY_STORIES = @"StoryData";
static NSString* const DATAKEY_STORIES_SIGNATURE = @"signature";
static NSString* const DATAKEY_STORIES_DATE = @"date";
static NSString* const DATAKEY_STORIES_STORIES = @"stories";
static NSString* const DATAKEY_STORIES_TOPSTORIES = @"top_stories";

@interface DataSource()
@property (nonatomic,strong) CacheData *cacheData;
@property (nonatomic,strong) URLRequest *urlRequest;



@end

@implementation DataSource
//延迟实例化
-(CacheData*)cacheData{
    if (_cacheData==nil) {
        _cacheData=[[CacheData alloc]init];
    }
    return _cacheData;
}

-(URLRequest*)urlRequest{
    if (_urlRequest==nil) {
        _urlRequest=[[URLRequest alloc]init];
    }
    return _urlRequest;
}

-(NSMutableArray*)stories{
    if (_stories==nil) {
        _stories=[NSMutableArray array];
    }
    return _stories;
}

- (void)newsLatest:(void (^)(BOOL needsToReload))completion{
   [self.urlRequest getNewsLatestDataformUrl:API_Url_NewsLatest completion:^(NSDictionary *result, NSString *md5) {
       NSMutableDictionary *result1=[NSMutableDictionary dictionaryWithDictionary:result];
       NSString *date=[result1 valueForKey:DATAKEY_STORIES_DATE];
       BOOL needsToReload;
       if (self.cacheData.dataDic[date]==nil) {
           [result1 setValue:md5 forKey:DATAKEY_STORIES_SIGNATURE];
           [self.cacheData.dataDic setValue:result1 forKey:date];
           needsToReload=YES;
       }else{
           if ([self.cacheData.dataDic[date][DATAKEY_STORIES_SIGNATURE] isEqualToString:md5]) {
               needsToReload=NO;
           }else{
               [self.cacheData.dataDic  removeObjectForKey:date];
               [result1 setValue:md5 forKey:DATAKEY_STORIES_SIGNATURE];
               [self.cacheData.dataDic setValue:result1 forKey:date];
               needsToReload=YES;
           }
       }
       self.stories=(NSMutableArray*)[Stories stories:result1[DATAKEY_STORIES_STORIES]];
       if (completion!=nil) {
           completion(needsToReload);
       }
   }];
    
}
- (void)newsBefore:(NSString*)date completion:(void (^)(void))completion{
    NSString *url=[NSString stringWithFormat:@"%@%@",API_Url_NewsBefore,date];
    [self.urlRequest getNewsBeforeDataformUrl:url completion:^(NSDictionary *result, NSString *md5) {
        NSMutableDictionary *result1=[NSMutableDictionary dictionaryWithDictionary:result];
        NSString *date=[result1 valueForKey:DATAKEY_STORIES_DATE];
        BOOL needsToReload;
        if (self.cacheData.dataDic[date]==nil) {
            [result1 setValue:md5 forKey:DATAKEY_STORIES_SIGNATURE];
            [self.cacheData.dataDic setValue:result1 forKey:date];
            needsToReload=YES;
        }else{
            if ([self.cacheData.dataDic[date][DATAKEY_STORIES_SIGNATURE] isEqualToString:md5]) {
                needsToReload=NO;
            }else{
                [self.cacheData.dataDic  removeObjectForKey:date];
                [result1 setValue:md5 forKey:DATAKEY_STORIES_SIGNATURE];
                [self.cacheData.dataDic setValue:result1 forKey:date];
                needsToReload=YES;
            }
        }
        self.stories=(NSMutableArray*)[Stories stories:result1[DATAKEY_STORIES_STORIES]];
        if (completion!=nil) {
            completion();
        }
    }];
}






@end

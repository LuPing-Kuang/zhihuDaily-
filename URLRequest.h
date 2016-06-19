//
//  URLRequest.h
//  zhihuDaily
//
//  Created by 邝路平 on 16/6/12.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import <Foundation/Foundation.h>

#define API_Url @"http://news-at.zhihu.com/api/4/news/"
#define API_Url_NewsLatest @"http://news-at.zhihu.com/api/4/news/latest"
#define API_Url_NewsBefore @"http://news.at.zhihu.com/api/4/news/before/"
#define API_Url_StartImage @"http://news-at.zhihu.com/api/4/start-image/"

@interface URLRequest : NSObject
@property (nonatomic,strong)NSDictionary *dic;


-(void)getNewsLatestDataformUrl:(NSString *)strUrl completion:(void (^)(NSDictionary * result,NSString*md5))completion;

-(void)getNewsBeforeDataformUrl:(NSString *)strUrl completion:(void (^)(NSMutableDictionary * result,NSString*md5))completion;

-(void)getStartImageFromUrl:(NSString*)strUrl;

@end

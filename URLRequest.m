//
//  URLRequest.m
//  zhihuDaily
//
//  Created by 邝路平 on 16/6/12.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import "URLRequest.h"
#import "GCD.h"
#import "SDImageCache.h"
#import "MD5Module.h"

@implementation URLRequest
//延迟实例化
-(NSDictionary*)dic{
    if (_dic) {
        _dic=[[NSDictionary alloc]init];
    }
    return _dic;
}

-(void)getNewsLatestDataformUrl:(NSString *)strUrl  completion:(void (^)(NSDictionary * result,NSString*md5))completion{
    strUrl=[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:strUrl];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0f];
    NSURLSessionConfiguration *defaultConfiguration=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:defaultConfiguration];
    NSURLSessionDataTask *dataDask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        GCD *globelQueue=[GCD globalQueueWithLevel:DEFAULT];
        GCD *mainQueue=[GCD mainQueue];
        [globelQueue async:^{
            NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse*)response;
            if (!error && data!=nil && httpResponse.statusCode==200) {
                NSError *error;
                NSString *result=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                id json=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                if ([json isKindOfClass:[NSDictionary class]]) {
                    NSMutableDictionary *dic=(NSMutableDictionary*)json;
//                    NSLog(@"%@",result);
                    NSString *md5=[MD5Module MD5ByAStr:result];
                    if (completion!=nil) {
                        completion(dic,md5);
                    }
                }
            }else{
                //回到主线程，刷新界面，或者对界面进行提示
                [mainQueue async:^{
                    NSLog(@"------网络繁忙，请稍后再试");
                }];
            }
        }];
    }];
    [dataDask resume];
}


-(void)getNewsBeforeDataformUrl:(NSString *)strUrl completion:(void (^)(NSMutableDictionary * result,NSString*md5))completion{
    NSURL *url=[NSURL URLWithString:strUrl];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0f];
    NSURLSessionConfiguration *defaultConfiguration=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:defaultConfiguration];
    NSURLSessionDataTask *dataDask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        GCD *globelQueue=[GCD globalQueueWithLevel:DEFAULT];
        GCD *mainQueue=[GCD mainQueue];
        [globelQueue async:^{
            NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse*)response;
            if (!error && data!=nil && httpResponse.statusCode==200) {
                NSError *error;
                NSString *result=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                id json=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                if ([json isKindOfClass:[NSDictionary class]]) {
                    NSMutableDictionary *dic=(NSMutableDictionary*)json;
                    NSLog(@"%@",dic);
                    NSString *md5=[MD5Module MD5ByAStr:result];
                    if (completion!=nil) {
                        completion(dic,md5);
                    }
                }
            }else{
                //回到主线程，刷新界面，或者对界面进行提示
                [mainQueue async:^{
                    NSLog(@"------网络繁忙，请稍后再试");
                }];
            }
        }];
    }];
    [dataDask resume];}

-(void)getStartImageFromUrl:(NSString *)strUrl{
    strUrl=[strUrl stringByAppendingString:@"1080*1776"];
    strUrl=[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:strUrl];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0f];
    NSURLSessionConfiguration *defaultConfiguration=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:defaultConfiguration];
    NSURLSessionDataTask *dataDask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        GCD *globelQueue=[GCD globalQueueWithLevel:DEFAULT];
        GCD *mainQueue=[GCD mainQueue];
        [globelQueue async:^{
            NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse*)response;
            if (!error && data!=nil && httpResponse.statusCode==200) {
                NSError *error;
                id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                if ([json isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dic=(NSDictionary*)json;
                    NSLog(@"%@",dic);
                }
            }else{
                //回到主线程，刷新界面，或者对界面进行提示
                [mainQueue async:^{
                    NSLog(@"------网络繁忙，请稍后再试");
                }];
            }
        }];
    }];
    [dataDask resume];

}



@end

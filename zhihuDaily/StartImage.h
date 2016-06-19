//
//  StartImage.h
//  zhihuDaily
//
//  Created by 邝路平 on 16/6/11.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StartImage : NSObject
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *text;

-(instancetype)initWithDic:(NSDictionary*)dic;
+(instancetype)startImageWithDic:(NSDictionary*)dic;
@end

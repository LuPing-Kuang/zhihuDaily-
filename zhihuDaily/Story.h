//
//  Story.h
//  zhihuDaily
//
//  Created by 邝路平 on 16/6/13.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Story : NSObject
@property (nonatomic,assign) NSInteger id;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) NSString *css;
@property (nonatomic,strong) NSString *body;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *imageSource;

-(instancetype)initWithDictionary:(NSDictionary*)dic;
+(instancetype)storyWithDictionary:(NSDictionary*)dic;

@end

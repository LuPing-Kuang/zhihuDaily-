//
//  Stories.h
//  zhihuDaily
//
//  Created by 邝路平 on 16/6/13.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stories : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *ga_prefix;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,assign) NSInteger identifier;
@property (nonatomic,assign) BOOL multipic;
@property (nonatomic,strong) NSArray *images;

-(instancetype)initWithDictionary:(NSDictionary*)dic;
+(instancetype)storiesWithDictionary:(NSDictionary*)dic;
+(NSArray<Stories*>*)stories:(NSArray*)array;
@end

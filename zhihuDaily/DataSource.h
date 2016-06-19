//
//  DataSource.h
//  zhihuDaily
//
//  Created by 邝路平 on 16/6/15.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject
@property (nonatomic,strong) NSMutableArray *stories;
- (void)newsLatest:(void (^)(BOOL needsToReload))completion;
- (void)newsBefore:(NSString*)date completion:(void (^)(void))completion;
@end

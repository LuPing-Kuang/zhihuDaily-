//
//  DateModule.m
//  zhihuDaily
//
//  Created by 邝路平 on 16/6/12.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import "DateModule.h"

@implementation DateModule

#pragma mark date和string的互换
-(NSString*)dateConvertToString:(NSDate*)date withFormat:(NSString*)format{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=format;
    NSString *strDate=[formatter stringFromDate:date];
    return strDate;
}

-(NSDate*)stringConvertToDate:(NSString*)strDate withFormat:(NSString*)format{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=format;
    NSDate *date=[formatter dateFromString:strDate];
    return date;
}


-(NSString*)convertDateString:(NSString*)strDate FromFormat:(NSString*)fromFormat toFormat:(NSString*)toFormat{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=fromFormat;
    NSDate *date=[formatter dateFromString:strDate];
    formatter.dateFormat=toFormat;
    NSString *str=[formatter stringFromDate:date];
    return str;
}

-(NSString*)getCurrentDate{
    NSString *strDate=[self dateConvertToString:[NSDate date] withFormat:@"yyyyMMddHHmmssff"];
    return strDate;
}

#warning   NSCalendarIdentifierChinese和其他枚举类型的区别
-(NSString*)getWeekdayFromDate:(NSDate*)date{
    NSCalendar *calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSTimeZone *timeZone=[[NSTimeZone alloc]init];
    [calendar setTimeZone:timeZone];
    NSCalendarUnit weekdayUint=NSCalendarUnitWeekday;
    NSInteger weekday=[calendar component:weekdayUint fromDate:date];
    NSArray *weekdayArray=[NSArray arrayWithObjects:[NSNull null],@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期天", nil];
    return [weekdayArray objectAtIndex:weekday];
    
}

-(NSString*)appendDateStringToWeekdayString:(NSDate*)date withFormat:(NSString*)format{
    return [NSString stringWithFormat:@"%@ %@",[self dateConvertToString:date withFormat:format],[self getWeekdayFromDate:date]];
}

@end

//
//  NSDate+Dispaly.m
//  BLUtilityProject
//
//  Created by Lei Bao on 2018/7/25.
//  Copyright © 2018年 iHealthlabs. All rights reserved.
//

#import "NSDate+Dispaly.h"

@implementation NSDate (Dispaly)

- (NSString *)UTCStringWithDateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = dateFormat;
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    return [dateFormatter stringFromDate:self];
}

- (NSString *)localStringWithDateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = dateFormat;
    dateFormatter.locale = [NSLocale currentLocale];
    return [dateFormatter stringFromDate:self];
}

/**
 is 24 hours or not
 @return YES: 24 hours
 */
- (BOOL)is24Hrs{
    NSString *formatStringForHours=[NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    /* if 24hrs, formatStringForHours contains H, if 12 hrs, formatStringForHours contains ah */
    NSRange containsA=[formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM=containsA.location!=NSNotFound;
    if (hasAMPM==false) return YES;
    else return NO;
}

- (BOOL)isSameDay:(NSDate*)date{
    if (!date) {
        return NO;
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *nowComponents = [calendar components:unit fromDate:self];
    NSDateComponents *selfComponents = [calendar components:unit fromDate:date];
    BOOL result = (nowComponents.year ==selfComponents.year && nowComponents.month == selfComponents.month && nowComponents.day ==selfComponents.day);
    return result;
}
@end

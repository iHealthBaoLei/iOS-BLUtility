//
//  NSDate+Dispaly.h
//  BLUtilityProject
//
//  Created by Lei Bao on 2018/7/25.
//  Copyright © 2018年 iHealthlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Dispaly)

- (NSString *)UTCStringWithDateFormat:(NSString *)dateFormat;
- (NSString *)localStringWithDateFormat:(NSString *)dateFormat;
- (BOOL)isSameDay:(NSDate*)date;
- (BOOL)is24Hrs;
@end

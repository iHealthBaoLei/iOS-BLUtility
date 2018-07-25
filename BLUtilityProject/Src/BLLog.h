//
//  BLLog.h
//  BLUtilityProject
//
//  Created by Lei Bao on 2017/12/7.
//  Copyright © 2017年 iHealthlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BLLogW(...)   [[BLLog shareInstance] writeLocalLog:[NSString stringWithFormat:@"%s\n\t\t%@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__]]]

@interface BLLog : NSObject
/**
 *  获得单例
 *
 *  @return 单例
 */
+ (instancetype)shareInstance;

/**
 *  写入本地日志文件
 *
 *  @param text 需要写入的字符串
 */
- (void)writeLocalLog:(NSString *)text;

/**
 将控制台数据写入日志文件
 */
- (void)redirectNSlogToDocumentFolder;
@end

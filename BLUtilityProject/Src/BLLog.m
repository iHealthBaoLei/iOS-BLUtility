//
//  BLLog.m
//  BLUtilityProject
//
//  Created by Lei Bao on 2017/12/7.
//  Copyright © 2017年 iHealthlabs. All rights reserved.
//

#import "BLLog.h"

#import <UIKit/UIKit.h>
#include <sys/sysctl.h>

static char *queueName = "BLLogWriteQueue";

@interface BLLog ()
@property (nonatomic) dispatch_queue_t queue;//写队列
@property (strong, nonatomic) NSDateFormatter *dateFormatter;//日志文件名中的日期格式
@property (copy, nonatomic)  NSString *docPath; //Documents路径
@property (copy, nonatomic)  NSString *logPath; //日志文件的路径

@end

@implementation BLLog

#pragma mark - single
+ (instancetype)shareInstance{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - overwrite init method
- (instancetype)init{
    if (self = [super init]) {
        self.queue = dispatch_queue_create(queueName, DISPATCH_QUEUE_SERIAL);
        self.docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        //Documents文件夹下，创建一个新的目录／Log／,用于存放Log文件
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/SDKLog",_docPath] withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            self.logPath = _docPath;
        } else {
            self.logPath = [_docPath stringByAppendingPathComponent:@"SDKLog"];
        }
        self.dateFormatter = [[NSDateFormatter alloc]init];
        [self.dateFormatter setDateFormat:@"YYYY_MM_dd"];
        
    }
    return self;
}

#pragma mark -
- (void)redirectNSlogToDocumentFolder{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@_%@.log",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"],[NSDate date]];
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    // 先删除已经存在的文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:logFilePath error:nil];
    
    // 将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}

#pragma mark - Local Log
/**
 *  将字符串写入日志文件
 *  保存日志文件的位置：Documents/Log/
 *
 *  @param text 字符串
 */
- (void)writeLocalLog:(NSString *)text{
    __weak typeof(self) weakSelf = self;
    dispatch_async(_queue, ^{
        if (text && text.length > 0) {
            
            NSString *dateString = [weakSelf.dateFormatter stringFromDate:[NSDate date]];//UTC 时间转换成year_month_day格式
            NSString *fileName = [NSString stringWithFormat:@"iGluco_SDK_Log_%@.log",dateString];
            NSString *filePath = [weakSelf.logPath stringByAppendingPathComponent:fileName];
            if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
                [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
                NSFileHandle *handle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
                //                NSString *toBeWriteString = [NSString stringWithFormat:@"\n"];
                
                NSMutableString *toBeWriteString = [[NSMutableString alloc]init];
                [toBeWriteString appendString:@"/* Basic Info */\n"];
                [toBeWriteString appendString:[NSString stringWithFormat:@"iOS Version:\t%f\n",[[[UIDevice currentDevice] systemVersion] floatValue]]];
                [toBeWriteString appendString:[NSString stringWithFormat:@"Model Name:\t%@\n",[self modelIdentifier]]];
                [toBeWriteString appendString:[NSString stringWithFormat:@"App Version:\t%@\n",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]];
                [toBeWriteString appendString:[NSString stringWithFormat:@"App Build:\t%@\n",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]];
                [toBeWriteString appendString:[NSString stringWithFormat:@"Bundle ID:\t%@\n",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]]];
                [toBeWriteString appendString:[NSString stringWithFormat:@"\n(UTC)%@:\n\t%@\n\n",[NSDate date],text]];
                [handle writeData:[toBeWriteString dataUsingEncoding:NSUTF8StringEncoding]];
                [handle closeFile];
            } else {
                NSFileHandle *handle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
                [handle seekToEndOfFile];
                NSString *toBeWriteString = [NSString stringWithFormat:@"(UTC)%@:\n\t%@\n\n",[NSDate date],text];
                
                [handle writeData:[toBeWriteString dataUsingEncoding:NSUTF8StringEncoding]];
                [handle closeFile];
            }
        }
    });
}

- (NSString *)getSysInfoByName:(char *)typeSpecifier{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

- (NSString *)modelIdentifier{
    return [self getSysInfoByName:"hw.machine"];
}

@end

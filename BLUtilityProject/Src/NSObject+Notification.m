//
//  NSObject+Notification.m
//  BLUtilityProject
//
//  Created by Lei Bao on 2018/7/25.
//  Copyright © 2018年 iHealthlabs. All rights reserved.
//

#import "NSObject+Notification.h"

@implementation NSObject (Notification)
- (void)addNotificationName:(NSString *)name sel:(SEL)aSelector{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:name object:nil];// 移除通知，防止重复添加
    [[NSNotificationCenter defaultCenter]addObserver:self selector:aSelector name:name object:nil];
}
- (void)removeNotificationName:(NSString *)name{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:name object:nil];
}
@end

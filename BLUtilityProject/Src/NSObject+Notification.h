//
//  NSObject+Notification.h
//  BLUtilityProject
//
//  Created by Lei Bao on 2018/7/25.
//  Copyright © 2018年 iHealthlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Notification)
/**
 监听通知
 
 @param name 通知名称
 @param aSelector 回调
 */
- (void)addNotificationName:(NSString *)name sel:(SEL)aSelector;

/**
 移除通知
 
 @param name 通知名称
 */
- (void)removeNotificationName:(NSString *)name;
@end

//
//  UIDevice+BLDeviceInfo.h
//  BLUtilityProject
//
//  Created by Lei Bao on 2017/12/7.
//  Copyright © 2017年 iHealthlabs. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIDevice (BLDeviceInfo)

/**
 get readable model name such as "iPhone 8 (A1905)"

 @return model name
 */
+ (NSString *)modelName;
/**
 get readable model name such as "iPhone 8"
 
 @return model name
 */
+ (NSString *)shortModelName;

/**
 get iOS version

 @return such as iOS 11.0
 */
+ (NSString *)iOSVersion;

@end

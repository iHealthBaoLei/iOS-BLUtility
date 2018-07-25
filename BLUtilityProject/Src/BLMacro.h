//
//  BLMacro.h
//  BLUtilityProject
//
//  Created by Lei Bao on 2017/12/7.
//  Copyright © 2017年 iHealthlabs. All rights reserved.
//

#ifndef BLMacro_h
#define BLMacro_h

/* Device type */
#define kIsIPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define kIsIPhone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

/* Screen size */
#define LCDW ([[UIScreen mainScreen] bounds].size.width)
#define LCDH ([[UIScreen mainScreen] bounds].size.height)
#define LCDMAX ((LCDW > LCDH) ? LCDW : LCDH)

#define kIPhoneX (kIsIPhone&&LCDMAX==812)?YES:NO
#define kRetina5_5 (kIsIPhone&&LCDMAX==736)?YES:NO
#define kRetina4_7 (kIsIPhone&&LCDMAX==667)?YES:NO
#define kRetina4_0 (kIsIPhone&&LCDMAX==568)?YES:NO
#define kRetina3_5 (kIsIPhone&&LCDMAX==480)?YES:NO

#define kIPhoneX_portrait (kIsIPhone&&LCDH==812)?YES:NO
#define kRetina5_5_portrait (kIsIPhone&&LCDH==736)?YES:NO
#define kRetina4_7_portrait (kIsIPhone&&LCDH==667)?YES:NO
#define kRetina4_0_portrait (kIsIPhone&&LCDH==568)?YES:NO
#define kRetina3_5_portrait (kIsIPhone&&LCDH==480)?YES:NO

#define kIPhoneX_landscape (kIsIPhone&&LCDW==812)?YES:NO
#define kRetina5_5_landscape (kIsIPhone&&LCDW==736)?YES:NO
#define kRetina4_7_landscape (kIsIPhone&&LCDW==667)?YES:NO
#define kRetina4_0_landscape (kIsIPhone&&LCDW==568)?YES:NO
#define kRetina3_5_landscape (kIsIPhone&&LCDW==480)?YES:NO

#define kIsIPAD_portrait (kIsIPAD&&LCDH==1024)?YES:NO
#define kIsIPAD_landscape (kIsIPAD&&LCDH==768)?YES:NO

#define kIsIPAD_Pro_10_5_portrait (kIsIPAD&&LCDH==1112)?YES:NO
#define kIsIPAD_Pro_10_5_landscape (kIsIPAD&&LCDH==834)?YES:NO

#define kIsIPAD_Pro_12_9_portrait (kIsIPAD&&LCDH==1366)?YES:NO
#define kIsIPAD_Pro_12_9_landscape (kIsIPAD&&LCDH==1024)?YES:NO

/* App information */
#define APP_BUNDLE_ID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

/* iOS system version */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)             ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)    ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/* Console log */
#ifndef DEBUG
    #define DMLog(...) do { } while (0)
#else
    #define DMLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#endif

/* Color UIColorFromRGB(0x123456)*/
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

#endif /* BLUntilityMacro_h */

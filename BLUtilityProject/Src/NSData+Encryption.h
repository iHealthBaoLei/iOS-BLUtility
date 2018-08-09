//
//  NSData+Encryption.h
//  BLUtilityProject
//
//  Created by Lei Bao on 2018/8/9.
//  Copyright © 2018年 iHealthlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Encryption)
- (NSData *)AES256ParmEncryptWithKey:(NSString *)key;
- (NSData *)AES256ParmDecryptWithKey:(NSString *)key;
@end

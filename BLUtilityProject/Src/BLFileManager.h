//
//  BLFileManager.h
//  BLUtilityProject
//
//  Created by Lei Bao on 2018/7/25.
//  Copyright © 2018年 iHealthlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

static inline NSString *DocumentDirectoryPath(){
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

static inline NSString *DocumentDirectoryPathWithFileName(NSString *fileName){
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:fileName];
}

static inline BOOL FileExistsAtPath(NSString *path){
    return [[NSFileManager defaultManager]fileExistsAtPath:path];
}

static inline BOOL SaveFile(NSString *path,id file){
    if (!path || !file) {
        return NO;
    }
    if ([file respondsToSelector:@selector(writeToFile:atomically:)]) {
        return [file writeToFile:path atomically:YES];
    } else {
        return NO;
    }
}

static inline BOOL DeleteFile(NSString *path){
    if (!path) {
        return NO;
    }
    return [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
}

static inline BOOL RenameFile(NSString *path,NSString *newName){
    if (!path || !newName) {
        return NO;
    }
    if (FileExistsAtPath(path)) {
        NSMutableArray *m_array = [NSMutableArray arrayWithArray:[path componentsSeparatedByString:@"/"]];
        [m_array replaceObjectAtIndex:m_array.count-1 withObject:newName];
        return [[NSFileManager defaultManager]moveItemAtPath:path toPath:[m_array componentsJoinedByString:@"/"] error:nil];
    } else {
        return NO;
    }
}

@interface BLFileManager : NSObject

@end

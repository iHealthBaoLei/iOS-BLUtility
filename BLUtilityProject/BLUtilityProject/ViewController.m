//
//  ViewController.m
//  BLUtilityProject
//
//  Created by Lei Bao on 2017/12/7.
//  Copyright © 2017年 iHealthlabs. All rights reserved.
//

#import "ViewController.h"
#import "BLMacro.h"
#import "BLLog.h"
#import "BLFileManager.h"
#import "NSData+Encryption.h"

static inline NSData *DataWithUTF8String(NSString *string){
    if (!string || string.length == 0){
        return nil;
    }
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data copy];
}
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BOOL flag = SaveFile(DocumentDirectoryPathWithFileName(@"a.txt"), @[@"哈哈"]);
    NSLog(@"save result: %d",flag);
    
    flag = RenameFile(DocumentDirectoryPathWithFileName(@"a.txt"), @"b.log");
    NSLog(@"rename result: %d",flag);
    
    flag = DeleteFile(DocumentDirectoryPathWithFileName(@"b.log"));
    NSLog(@"delete result: %d",flag);
    
    
    NSData *data = DataWithUTF8String(@"123456");
    NSLog(@"data:%@",data);
    
    NSData *encryData = [data AES256ParmEncryptWithKey:@"abcd"];
    NSLog(@"encryData:%@",encryData);
    
    NSData *decryData = [encryData AES256ParmDecryptWithKey:@"abcd"];
    NSLog(@"decryData:%@",decryData);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

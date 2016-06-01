//
//  FileTools.m
//  BSBDJ
//
//  Created by Yahaong on 16/5/30.
//  Copyright © 2016年 yahaong. All rights reserved.
//

#import "FileTools.h"

@implementation FileTools
+(unsigned long long)fileSizeForfile:(NSString *)path
{
    unsigned long long size = 0;
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDictionary *attrs = [manager attributesOfItemAtPath:path error:nil];
    if ([attrs.fileType isEqualToString:NSFileTypeDirectory]) {
        NSDirectoryEnumerator *directoryEnumerator = [manager enumeratorAtPath:path];
        for (NSString *subPath in directoryEnumerator) {
            NSString *fullSubPath = [path stringByAppendingPathComponent:subPath];
            size += [manager attributesOfItemAtPath:fullSubPath error:nil].fileSize;
        }
    }else {
            size += attrs.fileSize;
        }
    return size;
}
@end

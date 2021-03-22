//
//  KMLyricParser.m
//  KMMusic
//
//  Created by Luder on 2021/3/11.
//  Copyright © 2021年 KM. All rights reserved.
//

#import "KMLyricParser.h"

@implementation KMLyricParser

+(NSArray <KMLyricModel *>*)parseLyricByFileName:(NSString *)filename{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
    NSString *fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *lines = [fileContent componentsSeparatedByString:@"\n"];
    
//    [11:11.11]
    NSRegularExpression *express = [NSRegularExpression regularExpressionWithPattern:@"(\\[\\d{2}:\\d{2}.\\d{2}\\])" options:0 error:nil];
    
    NSMutableArray <KMLyricModel *> *tmpArr = [[NSMutableArray alloc]init];
    for (NSString *line in lines) {
        NSArray *results = [express matchesInString:line options:0 range:NSMakeRange(0, line.length)];
//        每行歌词可能对应多个时间戳，取最后一个匹配的时间戳后面的内容为歌词内容
        NSTextCheckingResult *lastResult = [results lastObject];
        NSString *lineLyric = [line substringFromIndex:(lastResult.range.location + lastResult.range.length)];
        
        for (NSTextCheckingResult *result in results) {
            NSString *lineTime = [line substringWithRange:result.range];
            
            KMLyricModel *lyricModel = [[KMLyricModel alloc] init];
            lyricModel.initalTime = [KMLyricParser stringToTimeInterval:lineTime];
            lyricModel.lyricContent = lineLyric;
            
            [tmpArr addObject:lyricModel];
        }
    }
//    按时间戳升序排列
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"initalTime" ascending:YES];
    [tmpArr sortUsingDescriptors:@[descriptor]];
    
    NSArray *lyricModelArr = [NSArray arrayWithArray:tmpArr];
    
//    for (KMLyricModel *model in lyricModelArr) {
//        NSLog(@"%f %@", model.initalTime, model.lyricContent);
//    }
    
    return lyricModelArr;
}

+(NSTimeInterval)stringToTimeInterval:(NSString *)timeStr{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"[mm:ss.SS]"];
    
    NSDate *nowDate = [fmt dateFromString:timeStr];
    NSDate *startDate = [fmt dateFromString:@"[00:00.00]"];
    
    return [nowDate timeIntervalSinceDate:startDate];
}


@end

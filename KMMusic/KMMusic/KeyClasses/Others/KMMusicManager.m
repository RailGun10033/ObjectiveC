//
//  KMMusicManager.m
//  KMMusic
//
//  Created by Luder on 2021/3/13.
//  Copyright © 2021年 KM. All rights reserved.
//

#import "KMMusicManager.h"
@interface KMMusicManager()

@property (nonatomic, copy)NSString *fileName;

@end

@implementation KMMusicManager


+(instancetype)sharedManager{
    static KMMusicManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (void)playMusicWithFileName:(NSString *)filename{
    if (![self.fileName isEqualToString:filename]) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:nil];//获取文件路径
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filePath] error:nil];//初始化播放器
        self.fileName = filename;//记录当前文件名
        [self.audioPlayer prepareToPlay];//开始缓存
    }
    
//    延时一秒，给缓冲预留更充足的时间
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.audioPlayer play];
    });
}

//暂停
- (void)pause{
    [self.audioPlayer pause];
}

//当前播放时长
- (NSTimeInterval)currentTime{
    return _audioPlayer.currentTime;
}

- (void)setCurrentTime:(NSTimeInterval)currentTime{
    _audioPlayer.currentTime = currentTime;
}

//曲目总时长
- (NSTimeInterval)duration{
    return _audioPlayer.duration;
}


@end

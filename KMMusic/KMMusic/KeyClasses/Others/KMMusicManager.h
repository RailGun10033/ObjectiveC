//
//  KMMusicManager.h
//  KMMusic
//
//  Created by Luder on 2021/3/13.
//  Copyright © 2021年 KM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface KMMusicManager : NSObject

@property(nonatomic, assign)NSTimeInterval duration;
@property(nonatomic, assign)NSTimeInterval currentTime;

@property(nonatomic, strong)AVAudioPlayer *audioPlayer;

+(instancetype)sharedManager;

- (void)playMusicWithFileName:(NSString *)filename;
- (void)pause;
@end

NS_ASSUME_NONNULL_END

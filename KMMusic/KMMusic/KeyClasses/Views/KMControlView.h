//
//  KMControlView.h
//  KMMusic
//
//  Created by Luder on 2021/3/12.
//  Copyright © 2021年 KM. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface KMControlView : NSView

@property(nonatomic, strong)NSTextField *currentTimeLabel;
@property(nonatomic, strong)NSSlider *progressSlider;
@property(nonatomic, strong)NSTextField *durationTimeLabel;

@property(nonatomic, strong)NSButton *playBtn;
@property(nonatomic, strong)NSButton *previousBtn;
@property(nonatomic, strong)NSButton *nextBtn;

@property(nonatomic, assign)BOOL isPlaying;

- (void)setControls;
@end

NS_ASSUME_NONNULL_END

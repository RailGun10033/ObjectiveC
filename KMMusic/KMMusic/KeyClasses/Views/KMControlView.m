//
//  KMControlView.m
//  KMMusic
//
//  Created by Luder on 2021/3/12.
//  Copyright © 2021年 KM. All rights reserved.
//

#import "KMControlView.h"

@implementation KMControlView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)setControls{
    
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor grayColor].CGColor;
    
    _previousBtn = [[NSButton alloc] initWithFrame: NSMakeRect(0, 0, 128, 128)];
    _previousBtn.bordered = NO;
    _previousBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_previousBtn];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_previousBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:100
                         ]];
    NSImage *imgPrevious = [NSImage imageNamed: @"player_btn_pre_normal"];
    [_previousBtn setImage:imgPrevious];
    _previousBtn.wantsLayer = YES;
    _previousBtn.layer.backgroundColor = [NSColor clearColor].CGColor;
    
    _playBtn = [[NSButton alloc] initWithFrame: NSMakeRect(0, 0, 128, 128)];
    _playBtn.bordered = NO;
    _playBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_playBtn];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_playBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0
                         ]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_playBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_previousBtn attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:50
                         ]];
    
    NSImage *imgPlay = [NSImage imageNamed: @"player_btn_play_normal"];
    [_playBtn setImage:imgPlay];
    
    
    _nextBtn = [[NSButton alloc] initWithFrame: NSMakeRect(0, 0, 128, 128)];
    _nextBtn.bordered = NO;
    _nextBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_nextBtn];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_nextBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_playBtn attribute:NSLayoutAttributeRight multiplier:1.0 constant:20
                         ]];
    NSImage *imgNext = [NSImage imageNamed: @"player_btn_next_normal"];
    [_nextBtn setImage:imgNext];
    
    
    
    _progressSlider = [[NSSlider alloc] initWithFrame:NSMakeRect(0, 0, 100, 50)];
    [self addSubview:_progressSlider];
    _progressSlider.translatesAutoresizingMaskIntoConstraints = NO;
    _progressSlider.trackFillColor = [NSColor greenColor];
    
    _currentTimeLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 100, 50)];
    [self addSubview:_currentTimeLabel];
    _currentTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _currentTimeLabel.editable = NO;
    _currentTimeLabel.bordered = NO;
    _currentTimeLabel.backgroundColor = [NSColor clearColor];
    _currentTimeLabel.stringValue  = @"00:00";
    
    _durationTimeLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 100, 50)];
    [self addSubview:_durationTimeLabel];
    _durationTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _durationTimeLabel.editable = NO;
    _durationTimeLabel.bordered = NO;
    _durationTimeLabel.backgroundColor = [NSColor clearColor];
    _durationTimeLabel.stringValue  = @"00:00";
    
    NSDictionary *views = @{@"v0" : _currentTimeLabel, @"v1":_progressSlider, @"v2":_durationTimeLabel};
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[v0(60)]-10-[v1]-10-[v2(60)]-10-|" options:0 metrics:nil views:views]];
    
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[v0]-65-|" options:0 metrics:nil views:views]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[v1]-65-|" options:0 metrics:nil views:views]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[v2]-65-|" options:0 metrics:nil views:views]];
    
    

}

- (void)setIsPlaying:(BOOL)isPlaying{
    if (isPlaying) {
        NSImage *imgPlay = [NSImage imageNamed: @"player_btn_pause_normal"];
        [_playBtn setImage:imgPlay];
    } else {
        NSImage *imgPlay = [NSImage imageNamed: @"player_btn_play_normal"];
        [_playBtn setImage:imgPlay];
    }
}


@end

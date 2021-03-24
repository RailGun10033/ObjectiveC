//
//  NSViewTracking.m
//  MineSweeper
//
//  Created by Luder on 2021/3/24.
//  Copyright © 2021年 Luder. All rights reserved.
//

#import "NSViewTracking.h"
@interface NSViewTracking()
@property(nonatomic, strong)NSTrackingArea *trackingArea;
@end

@implementation NSViewTracking

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}



- (void)mouseUp:(NSEvent *)event{
    if ([self.delegate respondsToSelector:@selector(actionResponseX:y:)]) {
        [self.delegate actionResponseX:event.locationInWindow.x y:event.locationInWindow.y];
    }
}

- (void)rightMouseUp:(NSEvent *)event{
    if ([self.delegate respondsToSelector:@selector(rightActionResponseX:y:)]) {
        [self.delegate rightActionResponseX:event.locationInWindow.x y:event.locationInWindow.y];
    }
}

- (void)addListener{
    
    _trackingArea = [[NSTrackingArea alloc] initWithRect:self.frame
                                                 options:NSTrackingMouseMoved+NSTrackingActiveInKeyWindow+NSTrackingMouseEnteredAndExited
                                                   owner:self
                                                userInfo:nil];
        [self addTrackingArea:_trackingArea];
}
@end

//
//  KMColorLabel.m
//  KMMusic
//
//  Created by Luder on 2021/3/11.
//  Copyright © 2021年 KM. All rights reserved.
//

#import "KMColorLabel.h"
@interface KMColorLabel()<NSTextDelegate>

@end
@implementation KMColorLabel

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [[NSColor colorWithRed:45/255.0 green:185/255.0 blue:10/255.0 alpha:0.5] setFill];
    
    dirtyRect = CGRectMake(dirtyRect.origin.x + dirtyRect.size.width * _progress, dirtyRect.origin.y, dirtyRect.size.width *(1-_progress), dirtyRect.size.height);
    // Drawing code here.
    NSRectFillUsingOperation(dirtyRect, NSCompositingOperationDestinationIn);
}

-(void)setProgress:(CGFloat)progress{
//    NSLog(@"%f",progress);
    _progress = progress;
    
    [self setNeedsDisplay];
}

-(void)controlTextDidChange:(NSNotification *)obj{
    [self sizeToFit];
}

@end

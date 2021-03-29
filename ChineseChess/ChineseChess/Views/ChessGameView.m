//
//  ChessGameView.m
//  ChineseChess
//
//  Created by Luder on 2021/3/26.
//  Copyright © 2021年 Luder. All rights reserved.
//

#import "ChessGameView.h"
@interface ChessGameView()

@property(nonatomic, strong)NSTrackingArea *trackingArea;

@end

@implementation ChessGameView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
//    [_chessGameModel nsLogGameModel];
    
    NSBezierPath *clearRect = [NSBezierPath bezierPathWithRect:dirtyRect];
    [[NSColor clearColor] set];
    [clearRect fill];
    
    float cellSize = self.frame.size.height / 10;
    
    NSBezierPath *linePath = [NSBezierPath bezierPath];
    [linePath setLineWidth:1.0];
    [[NSColor blackColor] set];
//    外框
    for (int i=0; i <=1; i++) {
        float padding = 2;
        for (int j=0; j <=1; j++) {
            if (i == 0) {
                NSPoint aPoint = NSMakePoint(cellSize/2 - padding, cellSize/2 + j * 9 * cellSize + (j-0.5) * 2 * padding);
                NSPoint bPoint = NSMakePoint(cellSize/2 + padding + cellSize * 8, cellSize/2 +j * 9 * cellSize + (j-0.5) * 2 * padding);
                [linePath moveToPoint:aPoint];
                [linePath lineToPoint:bPoint];
            }else{
                NSPoint aPoint = NSMakePoint(cellSize/2 + (j-0.5) * 2 * padding + j *cellSize * 8, cellSize/2 - padding);
                NSPoint bPoint = NSMakePoint(cellSize/2 + (j-0.5) * 2 * padding + j *cellSize * 8, cellSize/2 + padding + 9 * cellSize);
                [linePath moveToPoint:aPoint];
                [linePath lineToPoint:bPoint];
            }
        }
    }

//    横线
    for (int i = 0; i <= 9; i ++) {
        [linePath moveToPoint:NSMakePoint(cellSize/2, cellSize/2 + cellSize * i)];
        [linePath lineToPoint:NSMakePoint(cellSize/2 + cellSize * 8, cellSize/2 + cellSize * i)];
    }
    
//    竖线
    for (int i = 0; i <= 8; i ++) {
        if (i == 0 || i == 8) {
            [linePath moveToPoint:NSMakePoint(cellSize/2 + cellSize * i, cellSize/2)];
            [linePath lineToPoint:NSMakePoint(cellSize/2 + cellSize * i, cellSize/2 + cellSize * 9)];
        }else{
            
            [linePath moveToPoint:NSMakePoint(cellSize/2 + cellSize * i, cellSize/2)];
            [linePath lineToPoint:NSMakePoint(cellSize/2 + cellSize * i, cellSize/2 + cellSize * 4)];
            
            [linePath moveToPoint:NSMakePoint(cellSize/2 + cellSize * i, cellSize/2 + cellSize * 5)];
            [linePath lineToPoint:NSMakePoint(cellSize/2 + cellSize * i, cellSize/2 + cellSize * 9)];

        }
    }
    
//    九宫斜线
    for (int i=0; i <=1; i++) {
        for (int j=0; j <=1; j++) {
            NSPoint aPoint = NSMakePoint(cellSize/2 + cellSize * 3,cellSize/2 + i* cellSize * 7 + j * cellSize * 2);
            NSPoint bPoint = NSMakePoint(cellSize/2 + cellSize * 5,cellSize/2 + i*cellSize * 7 + (1-j) * cellSize * 2);
            [linePath moveToPoint:aPoint];
            [linePath lineToPoint:bPoint];
        }
    }
//    炮兵标记
    NSArray *markPoints = @[@[@1,@2],@[@7,@2],
                            @[@0,@3],@[@2,@3],@[@4,@3],@[@6,@3],@[@8,@3],
                            @[@0,@6],@[@2,@6],@[@4,@6],@[@6,@6],@[@8,@6],
                            @[@1,@7],@[@7,@7],
                            ];
    
    for (NSArray *arr in markPoints) {
        float padding = 2;
        float width = 8;
        int x = [arr[0] intValue];
        int y = [arr[1] intValue];
        
        NSPoint pp = NSMakePoint(cellSize/2 + x *cellSize, cellSize/2 + y * cellSize);
        if (x > 0) {
            NSPoint p0 = NSMakePoint(pp.x - padding , pp.y + padding + width);
            NSPoint p1 = NSMakePoint(pp.x - padding , pp.y + padding);
            NSPoint p2 = NSMakePoint(pp.x - padding - width , pp.y + padding);
            NSPoint p3 = NSMakePoint(pp.x - padding - width , pp.y - padding);
            NSPoint p4 = NSMakePoint(pp.x - padding , pp.y - padding);
            NSPoint p5 = NSMakePoint(pp.x - padding , pp.y - padding - width);
            [linePath moveToPoint:p0];
            [linePath lineToPoint:p1];
            [linePath lineToPoint:p2];
            
            [linePath moveToPoint:p3];
            [linePath lineToPoint:p4];
            [linePath lineToPoint:p5];
            
        }
        
        if (x < 8){
            NSPoint p0 = NSMakePoint(pp.x + padding , pp.y + padding + width);
            NSPoint p1 = NSMakePoint(pp.x + padding , pp.y + padding);
            NSPoint p2 = NSMakePoint(pp.x + padding + width , pp.y + padding);
            NSPoint p3 = NSMakePoint(pp.x + padding + width , pp.y - padding);
            NSPoint p4 = NSMakePoint(pp.x + padding , pp.y - padding);
            NSPoint p5 = NSMakePoint(pp.x + padding , pp.y - padding - width);
            [linePath moveToPoint:p0];
            [linePath lineToPoint:p1];
            [linePath lineToPoint:p2];
            
            [linePath moveToPoint:p3];
            [linePath lineToPoint:p4];
            [linePath lineToPoint:p5];
        }
    }
    
    [linePath stroke];
    
    
    //画棋子
    for (int i = 0; i <=9; i++) {
        for (int j = 0; j <= 8; j++) {
            if ([_chessGameModel.chessArrMs[i][j] isKindOfClass: ChessManModel.class]) {
                NSPoint pp = NSMakePoint(cellSize/2 + j *cellSize, cellSize/2 + i * cellSize);
                float rd = (cellSize - 4)/ 2;
                ChessManModel *cmm = _chessGameModel.chessArrMs[i][j];
                NSRect rect = NSMakeRect(pp.x - rd, pp.y - rd, rd*2, rd*2);
                NSBezierPath *circlePath = [NSBezierPath bezierPathWithOvalInRect:rect];
                [[NSColor colorWithRed:0.9 green:0.75 blue:0.53 alpha:1.0] set];
                [circlePath fill];
                
                NSString *title = cmm.title;
                float fontsize = rd * 1.2;
                NSMutableDictionary *md = [NSMutableDictionary dictionary];
//                [md setObject:[NSFont fontWithName:@"FZLSFW--GB1-0" size:fontsize] forKey:NSFontAttributeName];
                [md setObject:[NSFont fontWithName:@"STSongti-TC-Bold" size:fontsize] forKey:NSFontAttributeName];
                NSColor *color = cmm.isRedSide ? [NSColor redColor]: [NSColor blackColor];
                
                [md setObject:color forKey:NSForegroundColorAttributeName];
                [title drawAtPoint:NSMakePoint(pp.x-fontsize/2, pp.y-fontsize/1.6) withAttributes:md];
                
                float rate = 0.85;
                NSRect rect2 = NSMakeRect(pp.x - rd*rate, pp.y - rd*rate, rd*2*rate, rd*2*rate);
                NSBezierPath *circlePath2 = [NSBezierPath bezierPathWithOvalInRect:rect2];
                [color set];
                if (cmm.isSelect) {
                    [[NSColor whiteColor] set];
                }
                
                [circlePath2 stroke];
            }
        }
    }
    
    //画走法
    for (NSArray *pos in _chessGameModel.chessWays) {
        NSNumber *xx = pos[0];
        NSNumber *yy = pos[1];
        int x = xx.intValue;
        int y = yy.intValue;
        NSPoint pp = NSMakePoint(cellSize/2 + x *cellSize, cellSize/2 + y * cellSize);
        float rd = 5;
        NSRect rect = NSMakeRect(pp.x - rd, pp.y - rd, rd*2, rd*2);
        NSBezierPath *circlePath = [NSBezierPath bezierPathWithOvalInRect:rect];
        [[NSColor colorWithRed:0.42 green:0.79 blue:0.38 alpha:1.0] set];
        [circlePath fill];
    }
    
    
    // Drawing code here.
}

- (instancetype)init{
    if (self = [super init]) {
        _chessGameModel = [[ChessGameModel alloc] init];
    }
    
    return self;
}

- (void)setUpListener{
    _trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds options:NSTrackingMouseEnteredAndExited+NSTrackingMouseMoved+NSTrackingActiveInKeyWindow owner:self userInfo:nil];
    [self addTrackingArea:_trackingArea];
}
- (void)mouseUp:(NSEvent *)event{
    
    
    int cellSize = (int)self.frame.size.height / 10;
    float x0 = event.locationInWindow.x - self.frame.origin.x;
    float y0 = event.locationInWindow.y - self.frame.origin.y;
    float xF = (x0 - 0.5* cellSize) / cellSize;
    float yF = (y0 - 0.5* cellSize) / cellSize;
    
    int x = (int)xF;
    int y = (int)yF;
    if (xF >= (int)xF + 0.5) {
        x++;
    }
    if (yF >= (int)yF + 0.5) {
        y++;
    }
    
    
    float xx = (x + 0.5) * cellSize;
    float yy = (y + 0.5) * cellSize;
    
    float rd = (cellSize - 4)/ 2;
    if((xx-x0)*(xx-x0) + (yy-y0)*(yy-y0) > rd * rd) {
        return;
    }
//    NSLog(@"%d, %d", x,y);
    [_chessGameModel actionChessWithX:x y: y];
    
    self.needsDisplay = YES;
    
    if (_chessGameModel.isOver) {
        NSAlert *alert = [[NSAlert alloc] init];
        alert.informativeText = [NSString stringWithFormat:@"%@色方胜利!", _chessGameModel.isRedTurn? @"黑":@"红"];
        [alert runModal];
    }
}


@end

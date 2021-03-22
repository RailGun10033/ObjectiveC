//
//  ContainerView.m
//  TetrisWorld
//
//  Created by Luder on 2021/3/18.
//  Copyright © 2021年 KM. All rights reserved.
//

#import "ContainerView.h"

@implementation ContainerView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
}




- (void)setupModel{
    _containerModel = [[ContainerModel alloc] init];
    _tfArrM = [[NSMutableArray alloc] init];

    NSView *bgView = [[NSView alloc]initWithFrame: NSMakeRect(0, 0, CONW * CELLSIZE+1, CONH * CELLSIZE +1)];
    bgView.wantsLayer = YES;
    bgView.layer.backgroundColor = [NSColor whiteColor].CGColor;
    bgView.layer.borderColor = [NSColor blackColor].CGColor;
    bgView.layer.borderWidth = 1.0;
    [self addSubview:bgView];
    
}

- (void)setupTimer{
    __block int i = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (self->_containerModel.isOver) {
            [self->_timer invalidate];
            NSAlert *alert = [[NSAlert alloc] init];
            alert.informativeText = @"Over!";
            [alert runModal];
        }
        if (i < 5) {
            i++;
        }else{
            i = 0;
            [self->_containerModel moveV];
        }
        
        [self refreshUI];
    }];
}

- (void)stopTimer{
    [_timer invalidate];
    _timer = nil;
}

- (void)clearUI{
    for (NSTextField *tf in _tfArrM) {
        [tf removeFromSuperview];
    }
}
- (void)refreshUI{
    [self clearUI];
    
    for (CellModel *cellModel in _containerModel.tetrisModel.currentFourCellsModel.cellModels) {
        CGFloat x = (cellModel.x + _containerModel.tetrisModel.x) * CELLSIZE;
        CGFloat y = (cellModel.y + _containerModel.tetrisModel.y) * CELLSIZE;
        [self addTFWithx:x+1 y:y+1 colorIndex:cellModel.colorIndex];
    }
    
    for (int i = 0; i < CONH; i++) {
        for (int j = 0; j< CONW; j++) {
            if([_containerModel.bufferPoints[i][j] isKindOfClass:[CellModel class]]){
                CGFloat x = j * CELLSIZE;
                CGFloat y = i * CELLSIZE;
                CellModel *cellModel = _containerModel.bufferPoints[i][j];
                [self addTFWithx:x+1 y:y+1 colorIndex:cellModel.colorIndex];
            }
        }
    }
    
    for (CellModel *cellModel in _containerModel.tetrisModel.nextFourCellsModel.cellModels) {
        CGFloat x = (cellModel.x + CONW + 1) * CELLSIZE;
        CGFloat y = (cellModel.y + CONH - 6) * CELLSIZE;
        [self addTFWithx:x+1 y:y+1 colorIndex:cellModel.colorIndex];
    }
    
    NSTextField *tf = [[NSTextField alloc]initWithFrame:NSMakeRect((CONW + 1)*CELLSIZE, (CONH - 9)*CELLSIZE, CELLSIZE*3, CELLSIZE)];
    tf.editable = NO;
    tf.bordered = NO;
    tf.backgroundColor = [NSColor clearColor];
    tf.stringValue =[NSString stringWithFormat:@"Scores:%d", _containerModel.scores];
    tf.font = [NSFont systemFontOfSize:24];
    [self addSubview: tf];
    [_tfArrM addObject:tf];
    
}


- (void)addTFWithx:(int)x y:(int)y colorIndex:(int) colorIndex{
    NSImageView *view = [[NSImageView alloc]initWithFrame:NSMakeRect(x, y, CELLSIZE-1, CELLSIZE-1)];

    [view setImage: [self switchImage:colorIndex]];
    [self addSubview: view];
    [_tfArrM addObject:view];
    view.wantsLayer = YES;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [self switchColor:colorIndex].CGColor;
    

    
}

- (NSColor *)switchColor:(int) colorIndex{
    NSColor *color = nil;
    
    switch (colorIndex) {
        case 0:
            color = [NSColor colorWithRed:0.8 green:0.36 blue:0.30 alpha:1.0];
            break;
        case 1:
            color = [NSColor colorWithRed:0.97 green:0.82 blue:0.37 alpha:1.0];
            break;
        case 2:
            color = [NSColor colorWithRed:0.29 green:0.62 blue:0.39 alpha:1.0];
            break;
        default:
            color = [NSColor colorWithRed:0.36 green:0.54 blue:0.93 alpha:1.0];
            break;
    }
    
    return color;
}

- (NSImage *)switchImage:(int) colorIndex{
    NSString *color;
    switch (colorIndex) {
        case 0:
            color = @"red";
            break;
        case 1:
            color = @"orange";
            break;
        case 2:
            color = @"green";
            break;
        default:
            color = @"blue";
            break;
    }
    
    NSImage *img = [NSImage imageNamed:color];
    
    [img setSize:NSMakeSize(CELLSIZE-1, CELLSIZE-1)];
    
    return img;
}

@end

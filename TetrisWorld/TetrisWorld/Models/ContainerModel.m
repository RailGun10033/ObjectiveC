//
//  ContainerModel.m
//  TetrisWorld
//
//  Created by Luder on 2021/3/18.
//  Copyright © 2021年 KM. All rights reserved.
//

#import "ContainerModel.h"
@interface ContainerModel()

@end

@implementation ContainerModel

- (instancetype)init{
    if (self = [super init]) {
        _tetrisModel = [[TetrisModel alloc] initWithCellModel: nil];
        _bufferPoints = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < CONH; i++) {
            NSMutableArray *tmps = [[NSMutableArray alloc] init];
            for(int j = 0; j < CONW; j++){
                [tmps addObject:@(0)];
            }
            [_bufferPoints addObject:tmps];
        }
        
        _scores = 0;
        _isOver = NO;
    }
    
    return self;
}


- (void)moveH:(int)derection{
    if (![self collisionDetect:_tetrisModel.x+derection mY:_tetrisModel.y shape:nil]) {
        _tetrisModel.x += derection;
        [self refreshModel];
    }
}

- (void)moveV{
    if ([self collisionDetect:_tetrisModel.x mY:_tetrisModel.y-1 shape:nil]) {
        [self fixShape];
        [self checkFullLine];
        [self newShape];
    }else{
        _tetrisModel.y--;
        [self refreshModel];
    }
}

- (void)rorateV{
    FourCellsModel *fourCell = [_tetrisModel rotateCellModel];
    if (![self collisionDetect:_tetrisModel.x mY:_tetrisModel.y shape:fourCell]) {
        _tetrisModel.currentFourCellsModel = fourCell;
    }
}

//移动的落下
- (void)fixShape{
    NSUInteger cnt = _tetrisModel.currentFourCellsModel.cellModels.count;
    for (int i=0; i < cnt; i++) {
        CellModel *cellModel = _tetrisModel.currentFourCellsModel.cellModels[i];
        if (cellModel.y + _tetrisModel.y < CONH) {
            _bufferPoints[cellModel.y + _tetrisModel.y][cellModel.x + _tetrisModel.x] = cellModel;
        }
        else{
            _isOver = YES;
        }
        
    }
}
- (void)refreshModel{
    
}

- (void)newShape{
    _tetrisModel = [[TetrisModel alloc] initWithCellModel:_tetrisModel.nextFourCellsModel];
    if ([self collisionDetect:_tetrisModel.x mY:_tetrisModel.y shape:nil]) {
        _isOver = YES;
    }
}

//删除整行
- (void)removeLine:(int)lineNo{
    for (int i = lineNo; i < CONH; i++) {
        for (int j = 0; j< CONW; j++) {
            if([_bufferPoints[i][j] isKindOfClass:[CellModel class]]){
                if (i != CONH - 1){
                    _bufferPoints[i][j] = _bufferPoints[i+1][j];
                }else{
                    _bufferPoints[i][j] = @(0);
                }
            }
        }
    }
}


// 从上到下检测，是否有整行存在
- (void)checkFullLine{
    
    for (int i = CONH-1; i >=0; i--) {
        int cnt = 0;
        for (int j = 0; j< CONW; j++) {
            if([_bufferPoints[i][j] isKindOfClass:[CellModel class]]){
                cnt++;
            }
        }
        
        if (cnt == CONW) {
            _scores++;
            [self removeLine:i];
        }
    }
}


//碰撞检测
- (BOOL)collisionDetect:(NSInteger) mX mY:(NSInteger)mY shape:(nullable FourCellsModel*)fourCell{
    
    NSInteger xMin = CONW;//最左边的距离
    NSInteger xMax = 0;//最右边的距离
    NSInteger yMin = CONH;//最下边的距离
    
    if (fourCell == nil) {
        fourCell = _tetrisModel.currentFourCellsModel;
    }
    for (CellModel *cellModel in fourCell.cellModels) {
        xMin = xMin < cellModel.x ? xMin : cellModel.x;
        xMax = xMax > cellModel.x ? xMax : cellModel.x;
        yMin = yMin < cellModel.y ? yMin : cellModel.y;
        
        //    判断是否和边界碰撞
        if (cellModel.x+ mX < 0 || cellModel.x+ mX > CONW-1 ) {
            return YES;
        }
        if((cellModel.y + mY) < 0){
            return YES;
        }
        
        //    判断是否和剩余方块碰撞
        if (cellModel.y + mY < CONH-1) {
            if ([_bufferPoints[cellModel.y + mY][cellModel.x+mX] isKindOfClass:[CellModel class]]) {
                return YES;
            }
        }
        
    }
    

    
    // 判断是否超高
    
    for (int j = 0; j < CONW ; j++) {
        if([_bufferPoints[CONH-1][j] isKindOfClass:[CellModel class]]){
            _isOver = YES;
            return YES;
        }
    }
    return NO;
}


@end

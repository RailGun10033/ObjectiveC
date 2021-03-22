//
//  TetrisModel.m
//  TetrisWorld
//
//  Created by Luder on 2021/3/18.
//  Copyright © 2021年 KM. All rights reserved.
//

#import "TetrisModel.h"

@implementation TetrisModel

- (instancetype)initWithCellModel:(nullable FourCellsModel*) fourCellModel{
    if (self = [super init]) {
        if (fourCellModel == nil) {
            _currentFourCellsModel = [[FourCellsModel alloc] initWithx:nil y:nil];
        }else{
            _currentFourCellsModel = fourCellModel;
        }
        _x = 3;
        _y = CONH;
        _nextFourCellsModel = [[FourCellsModel alloc] initWithx:nil y:nil];
    }
    return self;
}

- (FourCellsModel *)rotateCellModel{
    FourCellsModel *fourCells = [[FourCellsModel alloc] initWithx:@(_currentFourCellsModel.shapeType) y: @(_currentFourCellsModel.shapeIndex)];
    [fourCells rotateShape];
    return fourCells;
}


@end

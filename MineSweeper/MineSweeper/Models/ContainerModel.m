//
//  ContainerModel.m
//  MineSweeper
//
//  Created by Luder on 2021/3/23.
//  Copyright © 2021年 Luder. All rights reserved.
//

#import "ContainerModel.h"

@interface ContainerModel()




@end

@implementation ContainerModel

- (instancetype)initWithSize:(int)rows cols:(int)cols mineCount:(int)mineCount{
    if (self = [super init]) {
        _rows = rows;
        _cols = cols;
        _mineCount = mineCount;
        _isWin = NO;
        _isBegin = NO;
        _flagCount = 0;
        [self loadCellModels];
        [self generateMines];
        [self caculateSurroundingMineCount];
    }
    return self;
}

- (void)loadCellModels{
    NSMutableArray *tmps = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _rows; i++) {
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        for (int j = 0; j < _cols; j++) {
            CellModel *cellModel = [[CellModel alloc] init];
            [tmp addObject:cellModel];
        }
        [tmps addObject:tmp];
    }
    
    _cellModels = tmps;
}


//随机生成地雷
- (void)generateMines{
    
    for (int i = 0; i < _mineCount; i++) {
        while (true) {
            int x = arc4random_uniform(_rows);
            int y = arc4random_uniform(_cols);
            if (_cellModels[x][y].value == 0) {
                _cellModels[x][y].value = -1;
                break;
            }
        }
    }
}

//计算每个单元格周围地雷的数量
- (void)caculateSurroundingMineCount{
    for (int i = 0; i < _rows; i++) {
        for (int j = 0; j < _cols; j++) {
            if(_cellModels[i][j].value == -1){
                continue;
            }else{
                int mineCnt = 0;
                int leftMost = MAX(j-1, 0);
                int rightMost = MIN(j+1, _rows-1);
                int topMost = MIN(i+1, _cols-1);
                int bottomMost = MAX(i-1, 0);
                
                for (int m = bottomMost; m <= topMost; m++) {
                    for (int n = leftMost; n <= rightMost; n++) {
                        if(_cellModels[m][n].value == -1){
                            mineCnt++;
                        }
                    }
                }
                
                _cellModels[i][j].value = mineCnt;
            }
        }
    }
    
}

- (void)nslogMines{
    for (int i = 0; i < _rows; i++) {
        for (int j = 0; j < _cols; j++) {
            
            switch (_cellModels[i][j].bFlag) {
                case 0:
                    printf("?,");
                    break;
                case 1:
                    printf("!,");
                    break;
                case 2:
                    if (_cellModels[i][j].value == -1) {
                        printf("*,");
                    }else{
                        printf("%d,", _cellModels[i][j].value);
                    }
                    break;
                default:
                    break;
            }
        }
        printf("\n");
    }
    
    printf("-----------------\n");
    for (int i = 0; i < _rows; i++) {
        for (int j = 0; j < _cols; j++) {
            if (_cellModels[i][j].value == -1) {
                printf("*,");
            }else{
                printf("%d,", _cellModels[i][j].value);
            }
        }
        printf("\n");
    }

}

- (void)leftClickWithX:(int)x y:(int)y isFirst:(BOOL) isFirst{
    _isBegin = YES;
    //被标记，或已展示停止
    if (_cellModels[x][y].bFlag != 0) {
        return;
    }
    
    //点击的时候踩雷，游戏结束
    if (isFirst) {
        if (_cellModels[x][y].value == -1) {
            for (int i = 0; i < _rows; i++) {
                for (int j = 0; j < _cols; j++) {
                    _cellModels[x][y].bFlag = 2;
                }
            }
            _isOver = YES;
            return;
        }
    }
    
    //扫描单元格是雷，停止对该单元格的扫描
    if (_cellModels[x][y].value == -1) {
        return;
    }
    //扫描单元格value不是0， 停止对该单元的扫描，并展示该单元格
    else if (_cellModels[x][y].value > 0){
        _cellModels[x][y].bFlag = 2;
        return;
    }
    
    
    //扫描单元格不是雷，则需要继续扫描其周围的所有单元格
    _cellModels[x][y].bFlag = 2; //展示该单元格
    
    int leftMost = MAX(y-1, 0);
    int rightMost = MIN(y+1, _rows-1);
    int topMost = MIN(x+1, _cols-1);
    int bottomMost = MAX(x-1, 0);
    
    for (int m = bottomMost; m <= topMost; m++) {
        for (int n = leftMost; n <= rightMost; n++) {
            if (m != x || n != y) {
                [self leftClickWithX:m y:n isFirst:NO];
            }
        }
    }
    
    
}


//右键标记或取消单元格
- (void)rightClickWithX:(int)x y:(int)y{
    switch (_cellModels[x][y].bFlag) {
        case 0:
            _cellModels[x][y].bFlag = 1;
            _flagCount++;
            break;
        case 1:
            _cellModels[x][y].bFlag = 0;
            _flagCount--;
            break;
        default:
            break;
    }
}

- (BOOL)isWinner{
    if (_isOver) {
        return NO;
    }
    
    int count = _rows * _cols - _mineCount;
    for (int i = 0; i < _rows; i++) {
        for (int j = 0; j < _cols; j++) {
            if(_cellModels[i][j].bFlag == 2){
                count--;
            }

        }
    }

    
    if (count == 0) {
        return YES;
    }else{
        return NO;
    }
}

- (void)boomModel{
    for (int i = 0; i < _rows; i++) {
        for (int j = 0; j < _cols; j++) {
            _cellModels[i][j].bFlag = 2;
            
        }
    }

}


@end

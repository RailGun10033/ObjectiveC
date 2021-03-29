//
//  ChessGameModel.m
//  ChineseChess
//
//  Created by Luder on 2021/3/25.
//  Copyright © 2021年 Luder. All rights reserved.
//

#import "ChessGameModel.h"

@implementation ChessGameModel

- (instancetype)init{
    if (self = [super init]) {
        self.redPlayer   = [[ChessPlayer alloc] initWithSide:YES];
        self.blackPlayer = [[ChessPlayer alloc] initWithSide:NO];
        self.chessArrMs = [[NSMutableArray alloc] init];
        self.isRedTurn = YES;
        self.isOver = NO;
        
        for (int i = 0; i <= 9; i++) {
            NSMutableArray *tmps = [[NSMutableArray alloc] init];
            for (int j = 0; j <= 8; j++) {
                [tmps addObject:@0];
            }
            [self.chessArrMs addObject:tmps];
        }
        
        for (ChessManModel *cmm in self.redPlayer.chessManModels) {
            self.chessArrMs[cmm.y][cmm.x] = cmm;
        }
        
        for (ChessManModel *cmm in self.blackPlayer.chessManModels) {
            self.chessArrMs[cmm.y][cmm.x] = cmm;
        }
        
        
    }
    return self;
}


- (void)nsLogGameModel{
    for (int i = 9; i >=0; i--) {
        for (int j = 0; j <= 8; j++) {
            if ([self.chessArrMs[i][j] isKindOfClass:[ChessManModel class]]) {
                ChessManModel *cmm = self.chessArrMs[i][j];
                printf("%s", cmm.title.UTF8String);
            }else{
                printf("〇");
            }
        }
        
        
        printf("\n");
        
    }
}

- (void)actionChessWithX:(int) x y:(int)y{
    if (_isOver) {
        return;
    }
    BOOL b = [self.chessArrMs[y][x] isKindOfClass:ChessManModel.class];
    if (self.selectChessManModel == nil) {
        if (b) {
            // buffer为空，当前棋子不为空，将当前的棋子存入buffer中，
            ChessManModel *cmm = self.chessArrMs[y][x];
            if (cmm.isRedSide != _isRedTurn) {
                return;
            }
            self.selectChessManModel = self.chessArrMs[y][x];
            self.selectChessManModel.isSelect = YES;
            _chessWays = [self searchPostions:self.selectChessManModel];
        }else{
            return;
        }
    }else{
        ChessManModel *cmm = self.selectChessManModel;
        if (b) {
            ChessManModel *cmmRemove = self.chessArrMs[y][x];
            // buffer不为空， 当前不为空
            if (cmmRemove.isRedSide == cmm.isRedSide) {
                // buffer 与当前是同一方的， 取消选择
                cmm.isSelect = NO;
                self.selectChessManModel = nil;
                self.chessWays = nil;
                
                self.selectChessManModel = self.chessArrMs[y][x];
                self.selectChessManModel.isSelect = YES;
                _chessWays = [self searchPostions:self.selectChessManModel];
            }else{
                // buffer 与当前不同， 吃子
                if (cmmRemove.isRedSide) {
                    [self.redPlayer.chessManModels removeObject:cmmRemove];
                }else{
                    [self.blackPlayer.chessManModels removeObject:cmmRemove];
                }
                if([self isInPostionsWithX:x y:y]){
                    self.chessArrMs[cmm.y][cmm.x] = @0;
                    self.chessArrMs[y][x] = cmm;
                    cmm.x = x;
                    cmm.y = y;
                    _isRedTurn = !_isRedTurn;
                }
                
                
                cmm.isSelect = NO;
                self.selectChessManModel = nil;
                self.chessWays = nil;
                
                
                if ([self isNoWays:_isRedTurn]) {
                    _isOver = YES;
                }
                
            }
        }else{
            // buffer不为空， 当前为空，移动到当前位置
            if([self isInPostionsWithX:x y:y]){
                self.chessArrMs[cmm.y][cmm.x] = @0;
                self.chessArrMs[y][x] = cmm;
                cmm.x = x;
                cmm.y = y;
                _isRedTurn = !_isRedTurn;
            }
            
            cmm.isSelect = NO;
            self.selectChessManModel = nil;
            _chessWays = nil;
            
            
            if ([self isNoWays:_isRedTurn]) {
                _isOver = YES;
            }
        }
    }
}

- (NSMutableArray *)searchPostions:(ChessManModel *)cmm{
    NSMutableArray *chessWays = [[NSMutableArray alloc] init];
    
    NSArray *arr = [self actionChess:cmm];
    
    for (NSArray *pos in arr) {
        NSNumber *xx = pos[0];
        NSNumber *yy = pos[1];
        int x = xx.intValue;
        int y = yy.intValue;
        
        //虚拟移动到pos
        ChessManModel *cmm2;
        if ([_chessArrMs[y][x] isKindOfClass:ChessManModel.class]) {
            cmm2 = _chessArrMs[y][x];
            if (cmm2.isRedSide) {
                [_redPlayer.chessManModels removeObject:cmm2];
            }else{
                [_blackPlayer.chessManModels removeObject:cmm2];
            }
        }
        _chessArrMs[y][x] = cmm;
        int originX = cmm.x;
        int originY = cmm.y;
        _chessArrMs[originY][originX] = @0;
        cmm.x = x;
        cmm.y = y;
        
        //判断移动到虚拟位置后，是否GameOver
        if (![self isGameOver:cmm.isRedSide]) {
            [chessWays addObject:pos];
        }
        
        //从虚拟位置退回
        if (cmm2 == nil) {
            _chessArrMs[y][x] = @0;
        }else{
            _chessArrMs[y][x] = cmm2;
            if (cmm2.isRedSide) {
                [_redPlayer.chessManModels addObject:cmm2];
            }else{
                [_blackPlayer.chessManModels addObject:cmm2];
            }
        }
        cmm.x = originX;
        cmm.y = originY;
        _chessArrMs[originY][originX] = cmm;
        
    }
    
    return chessWays;
}

- (BOOL)isInPostionsWithX:(int)x0 y:(int)y0{
    BOOL b = false;
    for (NSArray *pos in _chessWays) {
        NSNumber *xx = pos[0];
        NSNumber *yy = pos[1];
        int x = xx.intValue;
        int y = yy.intValue;
        if (x == x0 && y == y0 ) {
            b = true;
            break;
        }
    }
    
    return b;
}

- (NSArray *)actionChess:(ChessManModel *)cmm{
    NSArray *arr;
    switch (cmm.chessManType) {
        case ChessManTypeJu:
            arr = [self actionJu:cmm];
            break;
        case ChessManTypeMa:
            arr = [self actionMa:cmm];
            break;
        case ChessManTypeXiang:
            arr = [self actionXiang:cmm];
            break;
        case ChessManTypeShi:
            arr = [self actionShi:cmm];
            break;
        case ChessManTypePao:
            arr = [self actionPao:cmm];
            break;
        case ChessManTypeBing:
            arr = [self actionBing:cmm];
            break;
        case ChessManTypeShuai:
            arr = [self actionShuai:cmm];
            break;
        default:
            break;
    }
    return arr;
}


- (NSArray *)actionJu:(ChessManModel *)cmm{
    NSMutableArray *arr = [NSMutableArray array];
    int left = 0;
    int right = 8;
    int top = 9;
    int bottom = 0;
    
    int currentx = cmm.x;
    int currenty = cmm.y;
    
//    向左搜索
    while (true) {
        currentx--;
        if (currentx >= left) {
            [arr addObject:@[@(currentx), @(currenty)]];
            if ([_chessArrMs[currenty][currentx] isKindOfClass:ChessManModel.class]) {
                break;
            }
        }else{
            break;
        }
    }
    
    //向右搜索
    currentx = cmm.x;
    currenty = cmm.y;
    while (true) {
        currentx++;
        if (currentx <= right) {
            [arr addObject:@[@(currentx), @(currenty)]];
            if ([_chessArrMs[currenty][currentx] isKindOfClass:ChessManModel.class]) {
                break;
            }
        }else{
            break;
        }
    }
    
    //向上搜索
    currentx = cmm.x;
    currenty = cmm.y;
    while (true) {
        currenty++;
        if (currenty <= top) {
            [arr addObject:@[@(currentx), @(currenty)]];
            if ([_chessArrMs[currenty][currentx] isKindOfClass:ChessManModel.class]) {
                break;
            }
        }else{
            break;
        }
    }
    
    //向下搜索
    currentx = cmm.x;
    currenty = cmm.y;
    while (true) {
        currenty--;
        if (currenty >= bottom) {
            [arr addObject:@[@(currentx), @(currenty)]];
            if ([_chessArrMs[currenty][currentx] isKindOfClass:ChessManModel.class]) {
                break;
            }
        }else{
            break;
        }
    }
    
    arr =  [NSMutableArray arrayWithArray: [self isSameSide:cmm arr:arr]];
    
    return arr;
}

- (NSArray *)actionMa:(ChessManModel *)cmm{
    NSMutableArray *arr= [NSMutableArray array];
    int left = 0;
    int right = 8;
    int top = 9;
    int bottom = 0;

    for (int i=-2; i <= 2; i++) {
        for (int j=-2; j <= 2; j++) {
            if (abs(i) == abs(j) || i == 0 || j == 0) {
                continue;
            }
            int targetX = cmm.x + i;
            int targetY = cmm.y + j;
            int centerX = 0;
            int centerY = 0;
            if (abs(i) > abs(j)) {
                centerX = cmm.x + i/2;
                centerY = cmm.y;
            }else{
                centerX = cmm.x;
                centerY = cmm.y + j/2;
            }
            
            if (targetX>=left && targetX<=right && targetY>=bottom && targetY <= top && ![_chessArrMs[centerY][centerX] isKindOfClass:ChessManModel.class]) {
                [arr addObject:@[@(targetX), @(targetY)]];
            }
        }
    }
    
    
    arr =  [NSMutableArray arrayWithArray: [self isSameSide:cmm arr:arr]];
    return arr;
}

- (NSArray *)actionXiang:(ChessManModel *)cmm{
    NSMutableArray *arr= [NSMutableArray array];
    int left = 0;
    int right = 8;
    int top = 4;
    int bottom = 0;
    if (!cmm.isRedSide) {
        top = 9;
        bottom = 5;
    }
    
    for (int i=-1; i <= 1; i++) {
        for (int j=-1; j <= 1; j++) {
            int targetX = cmm.x + i*2;
            int targetY = cmm.y + j*2;
            int centerX = cmm.x + i;
            int centerY = cmm.y + j;
            if (targetX>=left && targetX<=right && targetY>=bottom && targetY <= top && ![_chessArrMs[centerY][centerX] isKindOfClass:ChessManModel.class]) {
                [arr addObject:@[@(targetX), @(targetY)]];
            }
            j++;
        }
        i++;
    }
    
    
    arr =  [NSMutableArray arrayWithArray: [self isSameSide:cmm arr:arr]];
    return arr;
}

- (NSArray *)actionShi:(ChessManModel *)cmm{
    NSMutableArray *arr = [NSMutableArray array];
    
    int left = 3;
    int right = 5;
    int top = 2;
    int bottom = 0;
    if (!cmm.isRedSide) {
        top = 9;
        bottom = 7;
    }
    
    if (cmm.x == left) {
        if (cmm.y == bottom) {
//            左下角
            [arr addObject:@[@(cmm.x+1), @(cmm.y+1)]];
        }else{
//            左上角
            [arr addObject:@[@(cmm.x+1), @(cmm.y-1)]];
        }
    }else if (cmm.x == right){
        if (cmm.y == bottom) {
//            右下角
            [arr addObject:@[@(cmm.x-1), @(cmm.y+1)]];
        }else{
//            右上角
            [arr addObject:@[@(cmm.x-1), @(cmm.y-1)]];
        }
    }else{
//        中心
        [arr addObject:@[@(cmm.x+1), @(cmm.y+1)]];
        [arr addObject:@[@(cmm.x+1), @(cmm.y-1)]];
        [arr addObject:@[@(cmm.x-1), @(cmm.y+1)]];
        [arr addObject:@[@(cmm.x-1), @(cmm.y-1)]];
    }
    
    arr =  [NSMutableArray arrayWithArray: [self isSameSide:cmm arr:arr]];
    
    return arr;
}

- (NSArray *)actionPao:(ChessManModel *)cmm{
    NSMutableArray *arr = [NSMutableArray array];
    int left = 0;
    int right = 8;
    int top = 9;
    int bottom = 0;
    BOOL isGunCarriage;
    
    int currentx = cmm.x;
    int currenty = cmm.y;
    
    //    向左搜索
    isGunCarriage = NO;
    while (true) {
        currentx--;
        if (currentx >= left) {
            if (isGunCarriage) {
                //已经有炮架了，遇到的第一个非空的就是目标位置
                if ([_chessArrMs[currenty][currentx] isKindOfClass:ChessManModel.class]){
                    [arr addObject:@[@(currentx), @(currenty)]];
                    break;
                }
            }else{
                //没有炮架，空白的就是目标位置
                if (![_chessArrMs[currenty][currentx] isKindOfClass:ChessManModel.class]) {
                    [arr addObject:@[@(currentx), @(currenty)]];
                }else{
                    isGunCarriage = YES;
                }
            }
        }else{
            break;
        }
    }
    
    //向右搜索
    currentx = cmm.x;
    currenty = cmm.y;
    isGunCarriage = NO;
    while (true) {
        currentx++;
        if (currentx <=  right) {
            if (isGunCarriage) {
                //已经有炮架了，遇到的第一个非空的就是目标位置
                if ([_chessArrMs[currenty][currentx] isKindOfClass:ChessManModel.class]){
                    [arr addObject:@[@(currentx), @(currenty)]];
                    break;
                }
            }else{
                //没有炮架，空白的就是目标位置
                if (![_chessArrMs[currenty][currentx] isKindOfClass:ChessManModel.class]) {
                    [arr addObject:@[@(currentx), @(currenty)]];
                }else{
                    isGunCarriage = YES;
                }
            }
        }else{
            break;
        }
    }

    
    //向上搜索
    currentx = cmm.x;
    currenty = cmm.y;
    isGunCarriage = NO;
    while (true) {
        currenty++;
        if (currenty <= top) {
            if (isGunCarriage) {
                //已经有炮架了，遇到的第一个非空的就是目标位置
                if ([_chessArrMs[currenty][currentx] isKindOfClass:ChessManModel.class]){
                    [arr addObject:@[@(currentx), @(currenty)]];
                    break;
                }
            }else{
                //没有炮架，空白的就是目标位置
                if (![_chessArrMs[currenty][currentx] isKindOfClass:ChessManModel.class]) {
                    [arr addObject:@[@(currentx), @(currenty)]];
                }else{
                    isGunCarriage = YES;
                }
            }
        }else{
            break;
        }
    }

    
    //向下搜索
    currentx = cmm.x;
    currenty = cmm.y;
    isGunCarriage = NO;
    while (true) {
        currenty--;
        if (currenty >= bottom) {
            if (isGunCarriage) {
                //已经有炮架了，遇到的第一个非空的就是目标位置
                if ([_chessArrMs[currenty][currentx] isKindOfClass:ChessManModel.class]){
                    [arr addObject:@[@(currentx), @(currenty)]];
                    break;
                }
            }else{
                //没有炮架，空白的就是目标位置
                if (![_chessArrMs[currenty][currentx] isKindOfClass:ChessManModel.class]) {
                    [arr addObject:@[@(currentx), @(currenty)]];
                }else{
                    isGunCarriage = YES;
                }
            }
        }else{
            break;
        }
    }

    
    arr =  [NSMutableArray arrayWithArray: [self isSameSide:cmm arr:arr]];
    
    return arr;
}

- (NSArray *)actionBing:(ChessManModel *)cmm{
    NSMutableArray *arr = [NSMutableArray array];
    if (cmm.isRedSide) {
        if (cmm.y <= 4) {
//            红兵没过河之前只能向前进一步
            [arr addObject:@[@(cmm.x), @(cmm.y+1)]];
        }else if(cmm.y <= 9){
//            红兵过河后没有导地线前可以前进一步，或左右移动一步
            [arr addObject:@[@(cmm.x), @(cmm.y+1)]];
            if (cmm.x > 0) {
                [arr addObject:@[@(cmm.x-1), @(cmm.y)]];
            }
            if (cmm.x < 8) {
                [arr addObject:@[@(cmm.x+1), @(cmm.y)]];
            }
        }else{
//            红兵到底线后只能左右移动了
            if (cmm.x > 0) {
                [arr addObject:@[@(cmm.x-1), @(cmm.y)]];
            }
            if (cmm.x < 8) {
                [arr addObject:@[@(cmm.x+1), @(cmm.y)]];
            }
        }
    }else{
        if (cmm.y >= 5) {
//        黑卒没过河之前只能向前进一步
            [arr addObject:@[@(cmm.x), @(cmm.y-1)]];
        }else if(cmm.y >= 0){
            //            黑卒过河后没有导地线前可以前进一步，或左右移动一步
            [arr addObject:@[@(cmm.x), @(cmm.y-1)]];
            if (cmm.x > 0) {
                [arr addObject:@[@(cmm.x-1), @(cmm.y)]];
            }
            if (cmm.x < 8) {
                [arr addObject:@[@(cmm.x+1), @(cmm.y)]];
            }
        }else{
            //            黑卒到底线后只能左右移动了
            if (cmm.x > 0) {
                [arr addObject:@[@(cmm.x-1), @(cmm.y)]];
            }
            if (cmm.x < 8) {
                [arr addObject:@[@(cmm.x+1), @(cmm.y)]];
            }
        }
    }
    
    arr =  [NSMutableArray arrayWithArray: [self isSameSide:cmm arr:arr]];
    return arr;
}

- (NSArray *)actionShuai:(ChessManModel *)cmm{
    NSMutableArray *arr= [NSMutableArray array];
    int left = 3;
    int right = 5;
    int top = 2;
    int bottom = 0;
    if (!cmm.isRedSide) {
        top = 9;
        bottom = 7;
    }
    
    if (cmm.x > left) {
        [arr addObject:@[@(cmm.x-1), @(cmm.y)]];
    }
    if (cmm.x < right) {
        [arr addObject:@[@(cmm.x+1), @(cmm.y)]];
    }
    if (cmm.y > bottom) {
        [arr addObject:@[@(cmm.x), @(cmm.y-1)]];
    }
    if (cmm.y < top) {
        [arr addObject:@[@(cmm.x), @(cmm.y+1)]];
    }
    
    arr =  [NSMutableArray arrayWithArray: [self isSameSide:cmm arr:arr]];
    
    return arr;
}

- (NSArray *)isSameSide:(ChessManModel *)cmm arr:(NSMutableArray *)arr{
    NSMutableArray *tmps = [[NSMutableArray alloc] init];
    for (NSArray *pos in arr) {
        NSNumber *xx = pos[0];
        NSNumber *yy = pos[1];
        int x = xx.intValue;
        int y = yy.intValue;
        if ([_chessArrMs[y][x] isKindOfClass:ChessManModel.class]) {
            ChessManModel *cmm2 = _chessArrMs[y][x];
            if (cmm2.isRedSide != cmm.isRedSide) {
                [tmps addObject:pos];
            }
        }else{
            [tmps addObject:pos];
        }
        
    }
    return tmps;
}

- (BOOL)isGameOver:(BOOL)isRedSide{
    NSArray <ChessManModel*> *arr;
    ChessManModel *ourKing;
    ChessManModel *otherKing;
    for (ChessManModel *cm in _redPlayer.chessManModels) {
        if (cm.chessManType == ChessManTypeShuai) {
            if (isRedSide) {
                ourKing = cm;
            }else{
                otherKing = cm;
            }
            break;
        }
    }
    
    for (ChessManModel *cm in _blackPlayer.chessManModels) {
        if (cm.chessManType == ChessManTypeShuai) {
            if (!isRedSide) {
                ourKing = cm;
            }else{
                otherKing = cm;
            }
            break;
        }
    }
    
    if (!isRedSide) {
        arr = _redPlayer.chessManModels;
    }else{
        arr = _blackPlayer.chessManModels;
    }
    
//    己方虚拟移动后，若老帅/将，位于对方吃子上，则被将军了
    for (ChessManModel *cm in arr) {
        NSArray *poss = [self actionChess:cm];
        
        for (NSArray *pos in poss) {
            NSNumber *xx = pos[0];
            NSNumber *yy = pos[1];
            int x = xx.intValue;
            int y = yy.intValue;
            
            if (ourKing.x == x && ourKing.y == y) {
                return YES;
            }
        }
    }
    
//    判断将帅见面的情况
    if(ourKing.x == otherKing.x){
        int topKing = MAX(ourKing.y, otherKing.y) - 1;
        int bottomKing = MIN(ourKing.y, otherKing.y) + 1;
        
        int spaceCnt = 0;
        for (int i = bottomKing; i<=topKing; i++) {
            if ([_chessArrMs[i][ourKing.x] isKindOfClass:ChessManModel.class]) {
                return NO;
            }else{
                spaceCnt++;
            }
        }
        
        if (spaceCnt == topKing - bottomKing + 1) {
            return YES;
        }
        
    }

    return NO;
}

- (BOOL)isNoWays:(BOOL)isRedSide{
    NSArray <ChessManModel*> *arr;
    if (isRedSide) {
        arr = _redPlayer.chessManModels;
    }else{
        arr = _blackPlayer.chessManModels;
    }
    
    for (ChessManModel *cm in arr) {
        NSArray *a = [self searchPostions:cm];
        if (a.count > 0) {
            return NO;
        }
    }
    return YES;
}


@end

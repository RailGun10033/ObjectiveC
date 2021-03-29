//
//  ChessPlayer.m
//  ChineseChess
//
//  Created by Luder on 2021/3/25.
//  Copyright © 2021年 Luder. All rights reserved.
//

#import "ChessPlayer.h"

@implementation ChessPlayer

- (instancetype)initWithSide:(BOOL) isRedSide{
    if (self = [super init]) {
        self.chessManModels = [[NSMutableArray alloc] init];
        self.isRedSide = isRedSide;
        NSArray *positions = @[
                               @[@[@0,@0], @[@8,@0]],
                               @[@[@1,@0], @[@7,@0]],
                               @[@[@2,@0], @[@6,@0]],
                               @[@[@3,@0], @[@5,@0]],
                               @[@[@1,@2], @[@7,@2]],
                               @[@[@0,@3], @[@2,@3], @[@4,@3], @[@6,@3], @[@8,@3],],
                               @[@[@4,@0]],
                               ];
        
        for (int i = 0; i < positions.count; i++) {
            for (NSArray *arr in positions[i]) {
                int x = [arr[0] intValue];
                int y = [arr[1] intValue];
                if (!self.isRedSide) {
                    y = 9 - y;
                }
                ChessManModel *chessManModel = [[ChessManModel alloc] initWithType:i X:x Y:y isRed:self.isRedSide];
                [self.chessManModels addObject: chessManModel];
            }
        }
    }
    
    return self;
}


@end

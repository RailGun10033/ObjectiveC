//
//  ChessManModel.m
//  ChineseChess
//
//  Created by Luder on 2021/3/25.
//  Copyright © 2021年 Luder. All rights reserved.
//

#import "ChessManModel.h"

@implementation ChessManModel


- (instancetype)initWithType:(ChessManType) chessManType X:(int)x Y:(int)y isRed:(BOOL) isRed{
    if (self = [super init]) {
        self.chessManType = chessManType;
        self.x = x;
        self.y = y;
        self.isRedSide = isRed;
        self.title = [self loadTitle:chessManType isRed:isRed];
        self.isSelect = NO;
    }
    return self;
}

- (NSString *)loadTitle:(ChessManType) chessManType isRed:(BOOL) isRed{
    NSString *title = @"无";
    switch (chessManType) {
        case ChessManTypeJu:
            title = @"車";
            break;
        case ChessManTypeMa:
            title = @"馬";
            break;
        case ChessManTypeXiang:
            title = isRed ? @"相":@"象";
            break;
        case ChessManTypeShi:
            title = @"士";
            break;
        case ChessManTypePao:
            title = @"炮";
            break;
        case ChessManTypeBing:
            title = isRed ? @"兵":@"卒";
            break;
        case ChessManTypeShuai:
            title = isRed ? @"帥":@"將";
            break;
        default:
            break;
    }
    return title;
}


@end

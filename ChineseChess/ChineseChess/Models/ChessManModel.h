//
//  ChessManModel.h
//  ChineseChess
//
//  Created by Luder on 2021/3/25.
//  Copyright © 2021年 Luder. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum{
    ChessManTypeJu = 0,
    ChessManTypeMa = 1,
    ChessManTypeXiang = 2,
    ChessManTypeShi = 3,
    ChessManTypePao = 4,
    ChessManTypeBing = 5,
    ChessManTypeShuai = 6,
}ChessManType;


@interface ChessManModel : NSObject

@property(nonatomic, assign)BOOL isRedSide; // YES - 红方， NO - 黑方；
@property(nonatomic, assign)ChessManType chessManType; // 棋子类型
@property(nonatomic, assign)int x; //棋子的水平方向坐标
@property(nonatomic, assign)int y; //棋子的竖直方向坐标
@property(nonatomic, assign)BOOL isAlive; //棋子是否存活
@property(nonatomic, assign)BOOL isSelect; //棋子是否被选中
@property(nonatomic, copy)NSString *title;

- (instancetype)initWithType:(ChessManType) chessManType X:(int)x Y:(int)y isRed:(BOOL) isRed;

@end

NS_ASSUME_NONNULL_END

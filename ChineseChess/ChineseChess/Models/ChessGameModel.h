//
//  ChessGameModel.h
//  ChineseChess
//
//  Created by Luder on 2021/3/25.
//  Copyright © 2021年 Luder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChessPlayer.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChessGameModel : NSObject

@property(nonatomic, strong)ChessPlayer *redPlayer;
@property(nonatomic, strong)ChessPlayer *blackPlayer;

@property(nonatomic, assign)BOOL isRedTurn;
@property(nonatomic, assign)BOOL isBegin;
@property(nonatomic, strong)NSMutableArray <NSMutableArray *>* chessArrMs;
@property(nonatomic, assign)BOOL isSelect;
@property(nonatomic, weak, nullable)ChessManModel *selectChessManModel;
@property(nonatomic, strong, nullable)NSMutableArray * chessWays;

@property(nonatomic, assign)BOOL isOver;

- (void)nsLogGameModel;

- (void)actionChessWithX:(int) x y:(int)y;

@end

NS_ASSUME_NONNULL_END

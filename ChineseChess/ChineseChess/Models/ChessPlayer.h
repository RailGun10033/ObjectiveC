//
//  ChessPlayer.h
//  ChineseChess
//
//  Created by Luder on 2021/3/25.
//  Copyright © 2021年 Luder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChessManModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChessPlayer : NSObject

@property(nonatomic, assign)BOOL isRedSide;
@property(nonatomic, assign)BOOL isSelect;
@property(nonatomic, strong)NSMutableArray <ChessManModel *> *chessManModels;

- (instancetype)initWithSide:(BOOL) isRedSide;


@end

NS_ASSUME_NONNULL_END

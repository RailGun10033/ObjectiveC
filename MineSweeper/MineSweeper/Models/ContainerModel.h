//
//  ContainerModel.h
//  MineSweeper
//
//  Created by Luder on 2021/3/23.
//  Copyright © 2021年 Luder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContainerModel : NSObject

@property(nonatomic, assign)int rows;
@property(nonatomic, assign)int cols;
@property(nonatomic, assign)int mineCount;
@property(nonatomic, assign)int flagCount;
@property(nonatomic, assign)BOOL isBegin;
@property(nonatomic, assign)BOOL isOver;
@property(nonatomic, assign)BOOL isWin;
@property(nonatomic, strong)NSArray <NSArray <CellModel*> *> * cellModels;

- (instancetype)initWithSize:(int)rows cols:(int)cols mineCount:(int)mineCount;
- (void)nslogMines;
- (void)leftClickWithX:(int)x y:(int)y isFirst:(BOOL) isFirst;
- (void)rightClickWithX:(int)x y:(int)y;
- (BOOL)isWinner;
- (void)boomModel;
@end

NS_ASSUME_NONNULL_END

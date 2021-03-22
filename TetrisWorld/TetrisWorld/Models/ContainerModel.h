//
//  ContainerModel.h
//  TetrisWorld
//
//  Created by Luder on 2021/3/18.
//  Copyright © 2021年 KM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TetrisModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ContainerModel : NSObject
@property(nonatomic, strong)TetrisModel *tetrisModel;
@property(nonatomic, strong)NSMutableArray <NSMutableArray *> *bufferPoints;
@property(nonatomic, strong)NSMutableArray <CellModel *> * bufferCellModels;
@property(nonatomic, assign)int scores;
@property(nonatomic, assign)BOOL isOver;

- (void)moveH:(int)derection;
- (void)moveV;
- (void)rorateV;
@end

NS_ASSUME_NONNULL_END

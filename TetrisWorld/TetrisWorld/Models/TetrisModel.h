//
//  TetrisModel.h
//  TetrisWorld
//
//  Created by Luder on 2021/3/18.
//  Copyright © 2021年 KM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FourCellsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TetrisModel : NSObject

@property(nonatomic, strong)FourCellsModel *currentFourCellsModel;
@property(nonatomic, strong)FourCellsModel *nextFourCellsModel;

@property(nonatomic, assign)NSInteger x;
@property(nonatomic, assign)NSInteger y;


- (instancetype)initWithCellModel:(nullable FourCellsModel*) fourCellModel;

- (FourCellsModel *)rotateCellModel;
@end

NS_ASSUME_NONNULL_END

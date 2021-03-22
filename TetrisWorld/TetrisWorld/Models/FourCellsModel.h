//
//  FourCellsModel.h
//  TetrisWorld
//
//  Created by Luder on 2021/3/19.
//  Copyright © 2021年 KM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FourCellsModel : NSObject

@property(nonatomic, strong)NSArray <CellModel *> * cellModels;
@property(nonatomic, assign)int shapeType;
@property(nonatomic, assign)int shapeIndex;


- (instancetype)initWithx:(nullable NSNumber*)x y:(nullable NSNumber*)y;
-(void)rotateShape;

@end

NS_ASSUME_NONNULL_END

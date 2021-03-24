//
//  CellModel.h
//  MineSweeper
//
//  Created by Luder on 2021/3/23.
//  Copyright © 2021年 Luder. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CellModel : NSObject

@property (nonatomic, assign)NSInteger x;
@property (nonatomic, assign)NSInteger y;

@property (nonatomic, assign)int bFlag; //0 - 未点击过 1 - 右键标记 2 - 左键点击

@property (nonatomic, assign)int value;

@end

NS_ASSUME_NONNULL_END

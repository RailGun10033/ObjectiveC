//
//  CellModel.h
//  TetrisWorld
//
//  Created by Luder on 2021/3/18.
//  Copyright © 2021年 KM. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CellColorTypeRed,
    CellColorTypeGray,
}CellColorType;
NS_ASSUME_NONNULL_BEGIN

@interface CellModel : NSObject
@property(nonatomic, assign)NSInteger x;
@property(nonatomic, assign)NSInteger y;
@property(nonatomic, assign)CellColorType type;
@property(nonatomic, assign)int colorIndex;

- (instancetype)initWithPosition:(NSInteger) x y:(NSInteger) y;

- (instancetype)initWithPosition:(NSInteger) x y:(NSInteger) y colorIndex:(int)colorIndex;
@end

NS_ASSUME_NONNULL_END

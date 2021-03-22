//
//  CellModel.m
//  TetrisWorld
//
//  Created by Luder on 2021/3/18.
//  Copyright © 2021年 KM. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel
- (instancetype)initWithPosition:(NSInteger) x y:(NSInteger) y{
    if (self = [super init]) {
        self.x = x;
        self.y = y;
        self.type = CellColorTypeRed;
    }
    return self;
}

- (instancetype)initWithPosition:(NSInteger) x y:(NSInteger) y colorIndex:(int)colorIndex{
    if (self = [super init]) {
        self.x = x;
        self.y = y;
        self.type = CellColorTypeRed;
        self.colorIndex = colorIndex;
    }
    return self;
}
@end

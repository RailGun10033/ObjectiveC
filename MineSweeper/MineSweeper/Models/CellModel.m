//
//  CellModel.m
//  MineSweeper
//
//  Created by Luder on 2021/3/23.
//  Copyright © 2021年 Luder. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel

- (instancetype)init{
    
    if (self = [super init]) {
        _bFlag = 0;
        _value = 0;
        
    }
    
    return self;
}

@end

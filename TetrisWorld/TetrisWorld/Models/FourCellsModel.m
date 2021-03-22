//
//  FourCellsModel.m
//  TetrisWorld
//
//  Created by Luder on 2021/3/19.
//  Copyright © 2021年 KM. All rights reserved.
//

#import "FourCellsModel.h"
@interface FourCellsModel()
@property(nonatomic, strong)NSArray <NSArray *>*arrStr;
@end

@implementation FourCellsModel

- (instancetype)initWithx:(nullable NSNumber*)x y:(nullable NSNumber*)y{
    if (self = [super init]) {
        [self loadArr];
        if (x != nil && y != nil) {
            _shapeType  = [x intValue];
            _shapeIndex = [y intValue];
        }else{
            [self randomShape];
        }
        
        
        [self strToShapes:_arrStr[_shapeType][_shapeIndex]];
    }
    return self;
}

- (void)loadArr{
    _arrStr = @[
             @[@"0,1,1,1,2,1,3,1", @"1,0,1,1,1,2,1,3"],
             @[@"1,2,1,1,1,0,2,0", @"0,1,1,1,2,1,2,2", @"1,0,1,1,1,2,0,2", @"2,1,1,1,0,1,0,0"],
             @[@"1,2,1,1,1,0,0,0", @"0,1,1,1,2,1,2,0", @"1,0,1,1,1,2,2,2", @"2,1,1,1,0,1,0,2"],
             @[@"1,2,1,1,2,1,2,0", @"0,1,1,1,1,2,2,2"],
             @[@"1,2,1,1,0,1,0,0", @"0,2,1,2,1,1,2,1"],
             @[@"0,1,1,1,0,0,1,0"],
             @[@"1,2,2,1,1,1,0,1", @"0,1,1,2,1,1,1,0", @"1,0,0,1,1,1,2,1", @"2,1,1,2,1,1,1,0"],
  ];
}

- (void)strToShapes:(NSString *)str{
    NSArray *arr = [str componentsSeparatedByString:@","];
    NSMutableArray *tmps = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < arr.count - 1; i++) {
        int x = [arr[i] intValue];
        int y = [arr[++i] intValue];
        CellModel *cellModel = [[CellModel alloc] initWithPosition:x y:y colorIndex:i/2];
        [tmps addObject:cellModel];
    }
    
    _cellModels = tmps;
}

- (void)randomShape{
    int randX = arc4random_uniform((int)_arrStr.count);
    int randY = arc4random_uniform((int)_arrStr[randX].count);
    _shapeType = randX;
    _shapeIndex = randY;
}
- (void)rotateShape{
    int cnt = (int)_arrStr[_shapeType].count;
    
    if (_shapeIndex < cnt-1) {
        _shapeIndex++;
    }else{
        _shapeIndex = 0;
    }
    [self strToShapes:_arrStr[_shapeType][_shapeIndex]];
}
@end

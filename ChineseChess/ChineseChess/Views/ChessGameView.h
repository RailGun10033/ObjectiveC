//
//  ChessGameView.h
//  ChineseChess
//
//  Created by Luder on 2021/3/26.
//  Copyright © 2021年 Luder. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ChessGameModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChessGameView : NSView

@property(nonatomic, strong)ChessGameModel *chessGameModel;

- (void)setUpListener;
@end

NS_ASSUME_NONNULL_END

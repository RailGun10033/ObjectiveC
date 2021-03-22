//
//  ContainerView.h
//  TetrisWorld
//
//  Created by Luder on 2021/3/18.
//  Copyright © 2021年 KM. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ContainerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContainerView : NSView

@property (nonatomic, strong)ContainerModel *containerModel;

@property (nonatomic, strong)NSMutableArray * tfArrM;
@property (nonatomic, strong)NSTimer *timer;
- (void)setupModel;
- (void)clearUI;
- (void)refreshUI;
- (void)setupTimer;
- (void)stopTimer;
@end

NS_ASSUME_NONNULL_END

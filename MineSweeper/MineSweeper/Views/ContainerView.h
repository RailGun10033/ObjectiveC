//
//  ContainerView.h
//  MineSweeper
//
//  Created by Luder on 2021/3/23.
//  Copyright © 2021年 Luder. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ContainerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ContainerView : NSView
@property(nonatomic, strong)ContainerModel *containerModel;

- (void)setUPUI;

- (void)refreshUI;

- (void)resetUI;
@end

NS_ASSUME_NONNULL_END

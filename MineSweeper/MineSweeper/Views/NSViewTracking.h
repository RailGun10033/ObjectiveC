//
//  NSViewTracking.h
//  MineSweeper
//
//  Created by Luder on 2021/3/24.
//  Copyright © 2021年 Luder. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN
@protocol NSViewTeackingDelegate <NSObject>

-(void)actionResponseX:(float)x y:(float)y;
-(void)rightActionResponseX:(float)x y:(float)y;
@end

@interface NSViewTracking : NSView

@property(nonatomic, weak)id<NSViewTeackingDelegate> delegate;
- (void)addListener;
@end

NS_ASSUME_NONNULL_END

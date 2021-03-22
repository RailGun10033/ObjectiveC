//
//  KMLyricView.h
//  KMMusic
//
//  Created by Luder on 2021/3/11.
//  Copyright © 2021年 KM. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KMLyricModel.h"
#import "KMColorLabel.h"
NS_ASSUME_NONNULL_BEGIN
@class KMLyricView;
@protocol KMLyricViewDelegate <NSObject>

- (void)lyricView:(KMLyricView *)lyricView andScrollProgress:(CGFloat )progress;

@end

@interface KMLyricView : NSView

@property (nonatomic, weak) id<KMLyricViewDelegate> delegate;

@property (nonatomic, strong) NSArray <KMLyricModel *> *lyricModels;

@property (nonatomic, assign)NSInteger currentIndex;

@property (nonatomic, assign)CGFloat lyricProgress;

@property(nonatomic, strong) NSMutableArray<KMColorLabel *> *labelArrM;

@end

NS_ASSUME_NONNULL_END

//
//  KMLyricView.m
//  KMMusic
//
//  Created by Luder on 2021/3/11.
//  Copyright © 2021年 KM. All rights reserved.
//

#import "KMLyricView.h"



#define kScreenWidth 500
#define kTopMargin 200 - lableHeight * 0.5

static CGFloat const lableHeight = 40.0;
@interface KMLyricView()

@property(nonatomic, strong) NSScrollView *verScrollView;
@property(nonatomic, strong) NSScrollView *horScrollView;
@property(nonatomic, strong) NSView *lView;
@end

@implementation KMLyricView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
}

- (void)awakeFromNib{
    [super awakeFromNib];

}

- (void)setLyricModels:(NSArray<KMLyricModel *> *)lyricModels{
    _lView = [[NSView alloc] initWithFrame:self.bounds];
    [self addSubview:_lView];
    
    _lView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"v0": _lView};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[v0]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[v0]-0-|" options:0 metrics:nil views:views]];
    _lView.wantsLayer = YES;
    _lView.layer.backgroundColor = [NSColor grayColor].CGColor;
    
    [_labelArrM removeAllObjects];
    
    _lyricModels = lyricModels;
    int i = 0;
    for (KMLyricModel *lyricModel in lyricModels) {
        KMColorLabel *label = [[KMColorLabel alloc] initWithFrame:NSMakeRect(0, -lableHeight*i + self.bounds.size.height/2, self.bounds.size.width, lableHeight)];
        
        
        [self.labelArrM addObject:label];
        label.font = [NSFont systemFontOfSize:17];
        [label setBordered:NO];
        [label setEditable:NO];
        label.textColor = [NSColor whiteColor];
        label.backgroundColor = [NSColor clearColor];
        label.stringValue = lyricModel.lyricContent;
        [label sizeToFit];
//        label.backgroundColor = [NSColor grayColor];
        [label setFrame: NSMakeRect(self.bounds.size.width/2 - label.frame.size.width/2, label.frame.origin.y, label.frame.size.width, label.frame.size.height)];
        
        [_lView addSubview:label];
        
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [_lView addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_lView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        i++;
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    KMColorLabel *lastLabel = _labelArrM[_currentIndex];
    lastLabel.font = [NSFont systemFontOfSize:17];
    lastLabel.progress = 0;
    
    _currentIndex = currentIndex;
    KMColorLabel *currentLabel = _labelArrM[_currentIndex];
    currentLabel.font = [NSFont systemFontOfSize:20];
    [currentLabel sizeToFit];
    
    int i = 0;
    for (KMColorLabel *label in _labelArrM) {
        [label setFrameOrigin:NSMakePoint(label.frame.origin.x, self.frame.size.height/2 + (currentIndex  - i)*40.0)];
        i++;
    }
    
}

- (NSMutableArray <KMColorLabel *>*)labelArrM{
    if (_labelArrM == nil) {
        _labelArrM = [[NSMutableArray alloc] init];
    }
    
    return  _labelArrM;
}

@end

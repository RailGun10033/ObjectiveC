//
//  ContainerView.m
//  MineSweeper
//
//  Created by Luder on 2021/3/23.
//  Copyright © 2021年 Luder. All rights reserved.
//

#import "ContainerView.h"
#import "NSViewTracking.h"
@interface ContainerView()<NSViewTeackingDelegate>
@property(nonatomic, strong)NSMutableArray <NSMutableArray <NSTextField *>*> * arrM;
@property(nonatomic, strong)NSViewTracking *trackingView;
@property(nonatomic, strong)NSTrackingArea *trackingArea;
@property(nonatomic, assign)float cellSize;


@end

@implementation ContainerView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
        
    // Drawing code here.
}


- (void)setUPUI{
    _cellSize = self.frame.size.height / _containerModel.rows;
    _arrM = [[NSMutableArray alloc] init];
    for (int i = 0; i < _containerModel.rows; i++) {
        NSMutableArray *tmps = [[NSMutableArray alloc] init];
        for (int j = 0; j < _containerModel.cols; j++) {
            NSTextField *tf = [[NSTextField alloc] initWithFrame:NSMakeRect(j*_cellSize, i*_cellSize, _cellSize, _cellSize)];
            tf.stringValue = @"";
            tf.editable = NO;
            tf.font = [NSFont systemFontOfSize:24];
            tf.alignment = NSTextAlignmentCenter;
            [tmps addObject:tf];
            [self addSubview:tf];
            tf.backgroundColor = [NSColor grayColor];
        }
        [_arrM addObject:tmps];
    }
    
    _trackingView = [[NSViewTracking alloc] initWithFrame:self.frame];
    [self addSubview:_trackingView];
    [_trackingView addListener];
    _trackingView.delegate = self;
    
}

- (void)resetUI{
    for (int i = 0; i < _containerModel.rows; i++) {
        for (int j = 0; j < _containerModel.cols; j++) {
            _arrM[i][j].stringValue = @"";
            _arrM[i][j].backgroundColor = [NSColor grayColor];
        }
    }
}

- (void)refreshUI{
    if (_arrM != nil) {
        for (NSArray *arr in _arrM) {
            for (NSTextField *tf in arr) {
                [tf removeFromSuperview];
            }
            
        }
        _arrM = nil;
    }
    [self setUPUI];
        for (int i = 0; i < _containerModel.rows; i++) {
            for (int j = 0; j < _containerModel.cols; j++) {
                
                
                switch (_containerModel.cellModels[i][j].bFlag) {
                    case 1:
                        _arrM[i][j].stringValue = @"🚩";
                        _arrM[i][j].backgroundColor = [NSColor orangeColor];
                        break;
                    case 2:
                        _arrM[i][j].enabled = NO;
                        _arrM[i][j].stringValue = [self getStringByValue: _containerModel.cellModels[i][j].value];
                        if(_containerModel.cellModels[i][j].value != -1){
                            _arrM[i][j].backgroundColor = [NSColor whiteColor];
                            _arrM[i][j].textColor = [self getColorByValue:_containerModel.cellModels[i][j].value];
                        }else{
                            _arrM[i][j].backgroundColor = [self getColorByValue:_containerModel.cellModels[i][j].value];
                        }
                        break;
                    case 0:
                        _arrM[i][j].stringValue = @"";
                        _arrM[i][j].backgroundColor = [NSColor grayColor];
                    default:
                        break;
                }
            }
        }
}

- (NSString *)getStringByValue:(int)value{
    if (value == -1) {
        return @"💣";
    }
    else if (value == 0){
        return @"";
    }
    else{
        return [NSString stringWithFormat:@"%d", value];
    }
}

- (NSColor *)getColorByValue:(int)value{
    NSArray *arr = @[@"#e54d42", //嫣红
                     @"#0081ff", //海蓝
                     @"#0081ff", //海蓝
                     @"#9c26b0", //木槿
                     @"#e54d42", //嫣红
                     @"#e03997", //桃粉
                     @"#a5673f", // 棕褐
                     @"#8dc63f", //橄榄绿
                     @"#fbbd08", //明黄
                     @"#f37b1d", //橙
                     @"#1cbbb4", //天青
                     @"#39b54a", //森绿
                     ];
    
    
    return [self hexStrToColor:arr[value+1]];
}

- (NSColor *)hexStrToColor:(NSString *)str{
    CGFloat rFloat = strtoul([str substringWithRange:NSMakeRange(1, 2)].UTF8String, 0, 16)/255.0;
    CGFloat gFloat = strtoul([str substringWithRange:NSMakeRange(3, 2)].UTF8String, 0, 16)/255.0;
    CGFloat bFloat = strtoul([str substringWithRange:NSMakeRange(5, 2)].UTF8String, 0, 16)/255.0;
    
    NSColor *color = [NSColor colorWithRed:rFloat green:gFloat blue:bFloat alpha:1.0];
    return color;
    
}


- (void)actionResponseX:(float)x y:(float)y{
    [self translateToPoint:x y:y isRight:NO];
}

- (void)rightActionResponseX:(float)x y:(float)y{
    [self translateToPoint:x y:y isRight:YES];
}


- (void)translateToPoint:(float)x y:(float)y isRight:(BOOL) isRight{
    if (_containerModel.isOver) {
        return;
    }
    int xI = (int)x / _cellSize;
    int yI = (int)y / _cellSize;
    if (isRight) {
        [_containerModel rightClickWithX:yI y:xI];
    } else {
        [_containerModel leftClickWithX:yI y:xI isFirst:YES];
    }
    
    [self refreshUI];
    
    if (_containerModel.isOver) {
        [_containerModel boomModel];
        [self refreshUI];
//        NSAlert *alert = [[NSAlert alloc]init];
//        alert.informativeText = @"BOOM!";
//        [alert runModal];
        return;
    }
    
    if ([_containerModel isWinner]) {
//        NSAlert *alert = [[NSAlert alloc]init];
//        alert.informativeText = @"You win!";
//        [alert runModal];
    }
}


@end

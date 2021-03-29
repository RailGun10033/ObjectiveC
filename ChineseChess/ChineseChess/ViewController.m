//
//  ViewController.m
//  ChineseChess
//
//  Created by Luder on 2021/3/25.
//  Copyright © 2021年 Luder. All rights reserved.
//

#import "ViewController.h"
#import "ChessGameView.h"
@interface ViewController()
@property(nonatomic, strong)ChessGameView *chessGameView;
@property(nonatomic, assign)int cellSize;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSButton *btn = [[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 40, 40)];
    [self.view addSubview:btn];
    btn.title = @"reset";
    
    [btn setAction:@selector(loadData)];
    
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)loadData{
    if (_chessGameView != nil) {
        [_chessGameView removeFromSuperview];
        _chessGameView = nil;
    }
    _cellSize = 40;
    _chessGameView = [[ChessGameView alloc] init];
    
    [_chessGameView setFrame:NSMakeRect(_cellSize, _cellSize, _cellSize * 9, _cellSize * 10)];
    [self.view addSubview:_chessGameView];
    
    
    [_chessGameView setUpListener];
}
- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end

//
//  ViewController.m
//  MineSweeper
//
//  Created by Luder on 2021/3/23.
//  Copyright © 2021年 Luder. All rights reserved.
//

#import "ViewController.h"

#import "ContainerView.h"

@interface ViewController()
@property(nonatomic, strong)NSView *ctrlView;
@property(nonatomic, assign)int rows;
@property(nonatomic, assign)int cols;
@property(nonatomic, assign)float cellsize;
@property(nonatomic, assign)int gLevel;
@property(nonatomic, assign)int minesCount;
@property(nonatomic, strong)ContainerView *containerView;
@property(nonatomic, strong)NSTextField *timeTf;
@property(nonatomic, strong)NSTextField *flagTf;
@property(nonatomic, strong)NSButton *resetBtn;

@property(nonatomic, strong)NSTimer *timer;
@property(nonatomic, strong)NSDate *startDate;
@property(nonatomic, assign)BOOL isBegin;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    
    [self setUpUI];
    
    [self setupTimer];
}

- (void)setupData{
    _gLevel = 1;
    _rows = 10;
    _cols = 10;
    _cellsize = 40;
    _minesCount = 10;
    _containerView = [[ContainerView alloc] init];
    _containerView.containerModel = [[ContainerModel alloc] initWithSize:_rows cols:_cols mineCount:_minesCount];
    _isBegin = NO;
    
    
}

- (void)setUpUI{
    [_containerView setFrame:NSMakeRect(0, 0, _cols * _cellsize, _rows * _cellsize)];
    [self.view addSubview:_containerView];
    [_containerView setUPUI];
    
    
    _ctrlView = [[NSView alloc] initWithFrame: NSMakeRect(0, _cols * _cellsize + 1, _cols * _cellsize, 199)];
    [self.view addSubview:_ctrlView];
    
    _resetBtn = [[NSButton alloc] initWithFrame:NSMakeRect(_cols * _cellsize / 2 - 25, 25, 80, 50)];
    [_ctrlView addSubview:_resetBtn];
    [_resetBtn setAction:@selector(reload)];
    _resetBtn.title = @"😵";
    _resetBtn.font = [NSFont systemFontOfSize:48];
    _resetBtn.bordered = NO;
    
    _timeTf = [[NSTextField alloc] initWithFrame: NSMakeRect(20, 25, 100, 40)];
    _timeTf.stringValue = @"0.0⏲";
    _timeTf.font = [NSFont systemFontOfSize:24];
    _timeTf.alignment = NSTextAlignmentRight;
    _timeTf.editable = NO;
    _timeTf.bordered = NO;
    _timeTf.backgroundColor = [NSColor clearColor];
    
    [_ctrlView addSubview:_timeTf];
    
    _flagTf = [[NSTextField alloc] initWithFrame: NSMakeRect(280, 25, 100, 40)];
    _flagTf.stringValue = @"0🚩";
    _flagTf.font = [NSFont systemFontOfSize:24];
    _flagTf.alignment = NSTextAlignmentRight;
    _flagTf.editable = NO;
    _flagTf.bordered = NO;
    _flagTf.backgroundColor = [NSColor clearColor];
    
    [_ctrlView addSubview:_flagTf];
}

- (void)reload{
    _isBegin = NO;
    _containerView.containerModel = [[ContainerModel alloc] initWithSize:_rows cols:_cols mineCount:_minesCount];
    [_containerView refreshUI];
    _resetBtn.title = @"😵";
}

- (void)setupTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void)endTimer{
    [_timer invalidate];
    _timer = nil;
}

- (void)timerAction{
    if (!_isBegin && _containerView.containerModel.isBegin) {
        _isBegin = YES;
        _startDate = [NSDate date];
        _resetBtn.title = @"⛑";
    }
    
    if (_containerView.containerModel.isOver){
        _resetBtn.title = @"☹️";
    }
    else if ([_containerView.containerModel isWinner]) {
        _resetBtn.title = @"😀";
    }else{
        if(_isBegin){
            NSTimeInterval f = -1 * [_startDate timeIntervalSinceNow];
            _timeTf.stringValue = [NSString stringWithFormat:@"%.1f⏲", f];
        }else{
            _timeTf.stringValue = @"0.0⏲";
        }
    }
    
    _flagTf.stringValue = [NSString stringWithFormat:@"%d🚩", _containerView.containerModel.flagCount];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end

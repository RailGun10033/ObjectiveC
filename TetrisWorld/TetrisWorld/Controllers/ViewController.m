//
//  ViewController.m
//  TetrisWorld
//
//  Created by Luder on 2021/3/18.
//  Copyright © 2021年 KM. All rights reserved.
//

#import "ViewController.h"
#import "ContainerView.h"

@interface ViewController()

@property(nonatomic, strong) ContainerView *containerView;
@property(nonatomic, strong)NSView *buttonsView;
@property(nonatomic, strong) NSButton *startOrPauseButton;
@property(nonatomic, strong) NSButton *resetButton;

@property(nonatomic, strong) NSButton *upButton;
@property(nonatomic, strong) NSButton *downButton;
@property(nonatomic, strong) NSButton *leftButton;
@property(nonatomic, strong) NSButton *rightButton;

@property(nonatomic, assign) BOOL isPlaying;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isPlaying = NO;

    [self setupUI];
    // Do any additional setup after loading the view.
    
    [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyDown handler:^NSEvent * _Nullable(NSEvent * _Nonnull aEvent) {
        if (aEvent.keyCode == 126 || aEvent.keyCode == 13) {
            [self upAction];
        }
        else if (aEvent.keyCode == 125 || aEvent.keyCode == 1){
            [self downAction];
        }else if (aEvent.keyCode == 123 || aEvent.keyCode == 0){
            [self leftAction];
        }else if (aEvent.keyCode == 124 || aEvent.keyCode == 2){
            [self rightAction];
        }else if (aEvent.keyCode == 49){
            [self starOrPausetAction];
        }
        return aEvent;
    }];
}
- (void)awakeFromNib{
    
}

- (void)setupUI{
    _containerView = [[ContainerView alloc] initWithFrame: NSMakeRect(10, 10, CELLSIZE * (CONW +6), CELLSIZE * CONH+1)];
    [self.view addSubview:_containerView];
    
    [_containerView setupModel];
    [_containerView refreshUI];
    
    [self addButtons];
}

- (void)addButtons{
    _buttonsView = [[NSView alloc] initWithFrame:NSMakeRect(CELLSIZE *(CONW+1), CELLSIZE*3, CELLSIZE*5, CELLSIZE*6)];
    [self.view addSubview:_buttonsView];
    _buttonsView.wantsLayer = YES;
    _buttonsView.layer.borderWidth = 1.0;
    
    _upButton = [self addBtnWith:CELLSIZE * 2.0 y:CELLSIZE * 4.0 name:@"arrowUp"];
    _downButton = [self addBtnWith:CELLSIZE * 2.0 y:CELLSIZE * 2.0 name:@"arrowDown"];
    _leftButton = [self addBtnWith:CELLSIZE * 1.0 y:CELLSIZE * 3.0 name:@"arrowLeft"];
    _rightButton = [self addBtnWith:CELLSIZE * 3.0 y:CELLSIZE * 3.0 name:@"arrowRight"];
    [_upButton setAction:@selector(upAction)];
    [_downButton setAction:@selector(downAction)];
    [_leftButton setAction:@selector(leftAction)];
    [_rightButton setAction:@selector(rightAction)];
    
    _startOrPauseButton = [self addBtnWith:CELLSIZE * 1.0 y:CELLSIZE * 0.5 name:@"start"];
    _resetButton = [self addBtnWith:CELLSIZE * 3.0 y:CELLSIZE * 0.5 name:@"reset"];

    [_startOrPauseButton setAction: @selector(startButton:)];
    [_resetButton setAction: @selector(resetAction)];

}

- (IBAction)startButton:(id)sender{
    [self starOrPausetAction];
}


- (void)starOrPausetAction{
    if(self.isPlaying)
    {
      [_containerView stopTimer];
    
    }else{
        [_containerView setupTimer];
    }
    
    self.isPlaying = !self.isPlaying;

}

- (void)upAction{
    if (self.isPlaying) {
        [self.containerView.containerModel rorateV];
    }else{
        [self gameNotPlaying];
    }
    
}

- (void)downAction{
    if (self.isPlaying) {
        [self.containerView.containerModel moveV];
    }else{
        [self gameNotPlaying];
    }
}

- (void)leftAction{
    if (self.isPlaying) {
        [self.containerView.containerModel moveH:-1];
    }else{
        [self gameNotPlaying];
    }
    
}

- (void)rightAction{
    if (self.isPlaying) {
        [self.containerView.containerModel moveH:1];
    }else{
        [self gameNotPlaying];
    }
    
}

- (void)gameNotPlaying{
    NSAlert *alert = [[NSAlert alloc] init];
    alert.informativeText = @"Game not ready!";
    [alert runModal];
}


- (void)resetAction{
    
    [_containerView stopTimer];
    
    [_containerView clearUI];
    [_containerView setupModel];
    [_containerView refreshUI];
    [_containerView setupTimer];
    self.isPlaying = YES;
}

- (void)setIsPlaying:(BOOL)isPlaying{
    _isPlaying = isPlaying;
    NSImage *imgPlay;
    if (isPlaying) {
        imgPlay = [NSImage imageNamed:@"pause"];
        
    }else{
        imgPlay = [NSImage imageNamed:@"start"];
        
    }
    [imgPlay setSize:_startOrPauseButton.frame.size];
    [_startOrPauseButton setImage:imgPlay];
}

- (NSButton *)addBtnWith:(CGFloat)x y:(CGFloat)y name:(NSString *)name{
    NSButton *btn = [[NSButton alloc] initWithFrame:NSMakeRect(x, y, CELLSIZE*1.0 , CELLSIZE*1.0)];
    btn.bordered = NO;
    [_buttonsView addSubview:btn];
    NSImage *imgReset = [NSImage imageNamed:name];
    [imgReset setSize:btn.frame.size];
    [btn setImage:imgReset];
    return btn;
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}




@end

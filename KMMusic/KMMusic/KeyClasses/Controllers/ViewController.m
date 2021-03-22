//
//  ViewController.m
//  KMMusic
//
//  Created by Luder on 2021/3/11.
//  Copyright © 2021年 KM. All rights reserved.
//

#import "ViewController.h"
#import "KMLyricParser.h"
#import "KMLyricView.h"
#import "KMLyricModel.h"
#import "KMControlView.h"
#import "KMMusicModel.h"
#import "KMMusicManager.h"
@interface ViewController()

@property(nonatomic, strong)NSArray <KMLyricModel *> * lyricModels;
@property(nonatomic, strong)NSArray <KMMusicModel *> *modelArray;
@property(nonatomic, strong)KMLyricView *lyricView;
@property(nonatomic, strong)KMControlView *controlView;

@property(nonatomic, strong)KMMusicManager *mMgr;
@property(nonatomic, assign)BOOL isPlaying;

@property(nonatomic, assign)NSInteger musicIndex;
@property(nonatomic, assign)NSInteger lyricIndex;

@property(nonatomic, strong)NSTimer *timer;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSButton *button = [[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 100, 100)];
//
//    [button setAction:@selector(btnClick)];
    self.mMgr = [KMMusicManager sharedManager];
    self.isPlaying = NO;
    [self setUpUI];
    [self loadData];
    [self setupData];
    [self setupAction];
    
    // Do any additional setup after loading the view.
//    [self.view addSubview:button];
    

    
//    self.view.wantsLayer = YES;
//    self.view.layer.backgroundColor = [NSColor yellowColor].CGColor;

}
CGFloat i = 0;
int j = 0;
- (void)btnClick{
    self.lyricView.currentIndex = j;
    if(i < 1.0){
        i += 0.1;
    }
    else{
        i = 0.1;
        j += 1;
        self.lyricView.currentIndex = j;
    }
    self.lyricView.labelArrM[j].progress = i;
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)setUpUI{
    //NSView怎么添加模糊背景呢？
    _controlView = [[KMControlView alloc] initWithFrame: NSMakeRect(0, 0, self.view.bounds.size.width, 100)];
    
    [_controlView setControls];
    _controlView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:_controlView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_controlView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];

    self.lyricView = [[KMLyricView alloc] initWithFrame:NSMakeRect(0, 100, self.view.frame.size.width, 2000.0)];
    
//    self.lyricView = [[KMLyricView alloc] init];
    
    [self.view addSubview:self.lyricView];
    
    self.lyricView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"v0": self.lyricView};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[v0]-0-|" options:0 metrics:nil views:views]];//歌词视图 水平约束：0
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[v0]-100-|" options:0 metrics:nil views:views]];//歌词视图 下约束：100

    
}

-(void)awakeFromNib{
    
}

- (void)loadData{

    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"mlist.plist" ofType:nil];
    NSArray *dataArr = [NSArray arrayWithContentsOfFile:plistPath];
    NSMutableArray <KMMusicModel *>*tmpArr = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in dataArr) {
        [tmpArr addObject: [[KMMusicModel alloc] initWithDic:dic]];
    }
    
    self.modelArray = [NSArray arrayWithArray:tmpArr];
    
    self.musicIndex = 0;
    self.timer = [[NSTimer alloc] init];
}

- (void)setupData{
    self.lyricIndex = 0;
    self.lyricModels = [KMLyricParser parseLyricByFileName:self.modelArray[self.musicIndex].lrc];
    self.lyricView.currentIndex = 0;
    self.lyricView.lyricModels = self.lyricModels;
}

- (void)setupAction{
    [self.controlView.previousBtn setAction:@selector(previousAction:)];
    [self.controlView.playBtn setAction:@selector(playAction:)];
    [self.controlView.nextBtn setAction:@selector(nextAction:)];
    [self.controlView.progressSlider setAction:@selector(sliderAction:)];
    self.controlView.progressSlider.continuous = YES;
}

- (IBAction)previousAction:(id)sender{
    [self.timer invalidate];
    if (self.musicIndex == 0) {
        self.musicIndex = self.modelArray.count-1;
    }else{
        self.musicIndex--;
    }
    
    [self setupData];
    self.isPlaying = NO;
    [self playAction:sender];
}
- (IBAction)playAction:(id)sender{
    if (self.isPlaying) {
        [self.mMgr pause];
        [self.timer invalidate];
    } else {
        [self.mMgr playMusicWithFileName:self.modelArray[self.musicIndex].mp3];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTimerAction) userInfo:nil repeats:YES];
    }
    self.isPlaying = !self.isPlaying;
    self.controlView.isPlaying = self.isPlaying;
    
}

- (IBAction)nextAction:(id)sender{
    [self.timer invalidate];
    if (self.musicIndex == self.modelArray.count-1) {
        self.musicIndex = 0;
    }else{
        self.musicIndex++;
    }
    
    [self setupData];
    self.isPlaying = NO;
    [self playAction:sender];
}

- (IBAction)sliderAction:(id)sender{
    self.mMgr.currentTime = self.mMgr.duration * self.controlView.progressSlider.floatValue;
}

- (void)updateTimerAction{
//    NSLog(@"%f, %f", self.mMgr.currentTime, self.mMgr.duration);
    if (self.mMgr.currentTime >= self.mMgr.duration-0.1) {
        if (self.musicIndex == self.modelArray.count-1) {
            self.musicIndex = 0;
        }else{
            self.musicIndex++;
        }
        [self setupData];
        self.isPlaying = NO;
        
        [self.mMgr playMusicWithFileName:self.modelArray[self.musicIndex].mp3];
        self.isPlaying = !self.isPlaying;
        self.controlView.isPlaying = self.isPlaying;
        
    }
    self.controlView.progressSlider.floatValue = self.mMgr.currentTime/self.mMgr.duration;
    self.controlView.currentTimeLabel.stringValue = [self timeToString:self.mMgr.currentTime];
    self.controlView.durationTimeLabel.stringValue = [self timeToString:self.mMgr.duration];
    
    [self updateLyric];
}

- (void)updateLyric{
    NSTimeInterval time = self.mMgr.currentTime;
    for (int i=0; i<self.lyricModels.count; i++) {
        if(time < self.lyricModels[i].initalTime){
            continue;
        }
        if (i == self.lyricModels.count-1){
            if(time <= self.mMgr.duration){
                self.lyricIndex = i;
                break;
            }
        }else{
            if(time < self.lyricModels[i+1].initalTime){
                self.lyricIndex = i;
                break;
            }
        }
        
    }
    self.lyricView.currentIndex = self.lyricIndex;
    
    CGFloat f;
    KMLyricModel *currentModel = self.lyricModels[self.lyricIndex];
    KMLyricModel *nextModel = [[KMLyricModel alloc] init];
    if (self.lyricIndex < self.lyricModels.count-1) {
        nextModel = self.lyricModels[self.lyricIndex + 1];
    }else{
        nextModel.initalTime = self.mMgr.duration;
    }

    f = (self.mMgr.currentTime - currentModel.initalTime)/(nextModel.initalTime - currentModel.initalTime);
    self.lyricView.labelArrM[self.lyricIndex].progress = f;
}



- (NSString *)timeToString:(NSTimeInterval)time{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    return [fmt stringFromDate:date];
}

- (void)viewDidLayout{
//    if (self.lyricView != nil) {
//        [self.lyricView setFrameSize: NSMakeSize(self.view.bounds.size.width, self.view.bounds.size.height-100.0)];
//    }
//    NSLog(@"%f", self.view.bounds.size.height);
//    NSLog(@"%f", self.lyricView.bounds.size.height);
}
@end

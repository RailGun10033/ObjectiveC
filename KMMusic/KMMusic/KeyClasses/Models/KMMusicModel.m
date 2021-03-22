//
//  KMMusicModel.m
//  KMMusic
//
//  Created by Luder on 2021/3/13.
//  Copyright © 2021年 KM. All rights reserved.
//

#import "KMMusicModel.h"

@implementation KMMusicModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.singer = dic[@"singer"];
        self.name = dic[@"name"];
        self.lrc = dic[@"lrc"];
        self.mp3 = dic[@"mp3"];
        
        self.image = dic[@"image"];
        self.singer = dic[@"singer"];
//        self.type = KMMusicTypeLocal;
        self.album = dic[@"album"];
        
        
    }
    
    return self;
}
@end

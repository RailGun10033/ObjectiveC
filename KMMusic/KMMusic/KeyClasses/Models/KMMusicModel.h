//
//  KMMusicModel.h
//  KMMusic
//
//  Created by Luder on 2021/3/13.
//  Copyright © 2021年 KM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum{
    KMMusicTypeLocal,
    KMMusicTypeRemote,
}KMMusicType;

@interface KMMusicModel : NSObject
//歌手
@property(nonatomic, copy)NSString *singer;

//歌名
@property(nonatomic, copy)NSString *name;
//歌词
@property(nonatomic, copy)NSString *lrc;
//音频
@property(nonatomic, copy)NSString *mp3;
//专辑名
@property(nonatomic, copy)NSString *album;
//歌手图片
@property(nonatomic, copy)NSString *image;

//资源类型
@property(nonatomic, assign)KMMusicType *type;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END

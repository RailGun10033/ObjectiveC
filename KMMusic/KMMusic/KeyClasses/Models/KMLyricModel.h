//
//  KMLyricModel.h
//  KMMusic
//
//  Created by Luder on 2021/3/11.
//  Copyright © 2021年 KM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KMLyricModel : NSObject

@property(nonatomic, copy) NSString * lyricContent;
@property(nonatomic, assign)NSTimeInterval initalTime;

@end

NS_ASSUME_NONNULL_END

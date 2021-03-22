//
//  KMLyricParser.h
//  KMMusic
//
//  Created by Luder on 2021/3/11.
//  Copyright © 2021年 KM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KMLyricModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface KMLyricParser : NSObject
+(NSArray <KMLyricModel *>*)parseLyricByFileName:(NSString *)filename;
@end

NS_ASSUME_NONNULL_END

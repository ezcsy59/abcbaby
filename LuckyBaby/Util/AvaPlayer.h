//
//  AvaPlayer.h
//  WDMVProducter
//
//  Created by 黄嘉宏 on 15-4-23.
//  Copyright (c) 2015年 wuhuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AvaPlayer : NSObject
+ (AvaPlayer *)sharedManager;
-(void)playWithUrl:(NSString *)url;
@end

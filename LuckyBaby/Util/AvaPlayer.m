//
//  AvaPlayer.m
//  WDMVProducter
//
//  Created by 黄嘉宏 on 15-4-23.
//  Copyright (c) 2015年 wuhuan. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "AvaPlayer.h"

@interface AvaPlayer ()
@property(nonatomic,strong)AVAudioPlayer *player;
@end

@implementation AvaPlayer
+ (AvaPlayer *)sharedManager
{
    static AvaPlayer *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

-(void)playWithUrl:(NSString *)url{
    if (self.player) {
        [self.player stop];
        self.player = nil;
    }
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:url] error:nil];
    BOOL yes = [self.player prepareToPlay];
    [self.player play];
}
@end

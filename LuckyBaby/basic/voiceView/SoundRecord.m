//
//  SoundRecord.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-14.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "SoundRecord.h"
#import "SoundTouchClient.h"
@interface SoundRecord ()<AVAudioPlayerDelegate, SoundTouchClientDelegate>
{
    SoundTouchClient *soundTouchClient;
}

@end

@implementation SoundRecord

-(instancetype)init{
    if (self = [super init]) {
        audioDataArray= [[NSMutableArray alloc] init];
        
        
        soundTouchClient = [[SoundTouchClient alloc] init];
        soundTouchClient.delegate = self;
        
        _soundTouchObj = [[SoundTouchObj alloc] init];
        [_soundTouchObj setDelegate:self];
        
        tempoChangeNum = 0;
        pitchSemiTonesNum= 0;
        rateChangeNum = 0;
        
        timeManager = [DotimeManage DefaultManage];
        [timeManager setDelegate:self];
    }
    return self;
}
- (void)buttonSayBegin
{
    [timeManager setTimeValue:30];
    [timeManager startTime];
    
    [soundTouchClient start];
}

- (void)buttonSayEnd
{
    [timeManager stopTimer];
    
    [soundTouchClient stop];
    
    [audioDataArray addObjectsFromArray:[soundTouchClient getAudioData]];
}

- (void)playWave
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:@"soundtouch.wav"];
    
    if (audioPalyer) {
        audioPalyer = nil;
    }
    
    NSURL *url = [NSURL URLWithString:filePath];
    audioPalyer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    audioPalyer.delegate = self;
    [audioPalyer prepareToPlay];
    [audioPalyer play];
}


- (void)buttonPlay
{
    
    //[sender setEnabled:NO];
    
    NSLog(@"播放音效");
    
    _soundTouchObj.dataArr = audioDataArray;
    [_soundTouchObj updataAudioSampleRate:8000 tempoChangeValue:tempoChangeNum pitchSemiTones:pitchSemiTonesNum rateChange:rateChangeNum];
    
}

- (void)didSaveAndPlay
{
    [self playWave];
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [playBtn setEnabled:YES];
    NSLog(@"回复音效按钮");
    
}

- (void)saveFileSuccess
{
}
@end

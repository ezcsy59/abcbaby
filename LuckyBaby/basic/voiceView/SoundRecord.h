//
//  SoundRecord.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-14.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "SoundTouchObj.h"
#import "DotimeManage.h"

@interface SoundRecord : NSObject<SoundTouchObjDelegate,DotimeManageDelegate>
{
    UIButton *sayBeginBtn;
    UIButton *sayEndBtn;
    UIButton *playBtn;
    
    AVAudioPlayer *audioPalyer;
    
    NSMutableArray *audioDataArray;
    SoundTouchObj *_soundTouchObj;
    
    /*
     * 初始值 均为0
     */
    int tempoChangeNum;
    int pitchSemiTonesNum;
    int rateChangeNum;
    DotimeManage *timeManager;
}


- (void)buttonSayBegin;
- (void)buttonSayEnd;
- (void)buttonPlay;
@end

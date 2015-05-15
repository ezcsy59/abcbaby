//
//  playViewController.h
//  VideoTest
//
//  Created by huang on 8/26/14.
//  Copyright (c) 2014 lkk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJHMySliderView.h"
@protocol playViewDelegate <NSObject>
-(void)startSpin;
-(void)stopSpin;
@end

@class ASIHTTPRequest;
@interface playViewController : UIViewController<sliderViewDelegate>{
    unsigned long long Recordull;
    //在想通过网络是否停止
    BOOL isPlay;
    //手动停止
    BOOL canPlay;
    //判定是否本地播放
    BOOL isLocationPlay;
}

@property(nonatomic,weak)ASIHTTPRequest *videoRequest;
@property(nonatomic,weak)id <playViewDelegate> delegate;
@end

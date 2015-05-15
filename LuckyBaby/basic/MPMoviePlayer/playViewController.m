//
//  playViewController.m
//  VideoTest
//
//  Created by huang on 8/26/14.
//  Copyright (c) 2014 lkk. All rights reserved.
//
#import "playViewController.h"
#import "ASIHTTPRequest.h"
#import <MediaPlayer/MediaPlayer.h>

@interface playViewController (){
    float loadingRate;
}
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UIImageView *headerImageView;
@property(nonatomic,strong)UIImageView *footImageView;
@property(nonatomic,strong)MPMoviePlayerViewController *playerViewController;
@property(nonatomic,strong)HJHMySliderView *mySliderView;
@property(nonatomic,strong)HJHMySliderView *voiceSlider;
@property(nonatomic,strong)NSTimer *getCurrentPlayBackTimer;
@property(nonatomic,strong)UIButton *playBtn;
@property(nonatomic,strong)UIButton *nextPlayBtn;
@property(nonatomic,strong)UIButton *lastPlayBtn;
@end

@implementation playViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //视频播放结束通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoFinished) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoStateChange) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    canPlay = YES;
    
    [self setMainView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self videoPlay];
    
    if (!isLocationPlay) {
        loadingRate = 0;
    }else{
        loadingRate = 1;
    }
    // Do any additional setup after loading the view.
}

-(void)setMainView{
    self.bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 568, 320)];
    self.bgImageView.clipsToBounds = YES;
    self.bgImageView.backgroundColor = [UIColor clearColor];
    self.bgImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(BgImageViewTap)];
    [self.bgImageView addGestureRecognizer:tap];
    [self.view addSubview:self.bgImageView];
    
    [self setHeaderView];
    [self setFootView];
    [self setVoiceView];
}

-(void)setHeaderView{
    self.headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 568, 50)];
    self.headerImageView.backgroundColor = [UIColor grayColor];
    self.headerImageView.userInteractionEnabled = YES;
    self.headerImageView.alpha = .7;
    self.headerImageView.clipsToBounds = YES;
    [self.bgImageView addSubview:self.headerImageView];
    
    
    //停止按钮
    UIButton *stopBtn = [[UIButton alloc]init];
    stopBtn.frame = CGRectMake(15, 10, 60, 30);
    [stopBtn setTitle:@"Done" forState:UIControlStateNormal];
    stopBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [stopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(stopBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headerImageView addSubview:stopBtn];
    
    //进度条
    self.mySliderView = [[HJHMySliderView alloc]initWithFrame:CGRectMake(568/2 - 250/2, 0, 300, 50)];
    self.mySliderView.delegate = self;
    self.mySliderView.tag = 1000;
    [self.headerImageView addSubview:self.mySliderView];
}

-(void)setFootView{
    self.footImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 270, 568, 50)];
    self.footImageView.backgroundColor = [UIColor grayColor];
    self.footImageView.alpha = .7;
    self.footImageView.userInteractionEnabled = YES;
    [self.bgImageView addSubview:self.footImageView];
    
    self.playBtn = [[UIButton alloc]init];
    self.playBtn.frame = CGRectMake(568/2 - 30/2, 10, 30, 30);
    [self.playBtn setImage:[UIImage imageNamed:@"play-lan_play.png"] forState:UIControlStateNormal];
    [self.playBtn addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.footImageView addSubview:self.playBtn];
    
    self.nextPlayBtn = [[UIButton alloc]init];
    self.nextPlayBtn.frame = CGRectMake(568/2 + 90/2, 10, 30, 30);
    [self.nextPlayBtn setImage:[UIImage imageNamed:@"play-lan_next2.png"] forState:UIControlStateNormal];
    [self.nextPlayBtn addTarget:self action:@selector(nextPlayBtnClicke) forControlEvents:UIControlEventTouchUpInside];
    [self.footImageView addSubview:self.nextPlayBtn];
    
    self.lastPlayBtn = [[UIButton alloc]init];
    self.lastPlayBtn.frame = CGRectMake(568/2 - 150/2, 10, 30, 30);
    [self.lastPlayBtn setImage:[UIImage imageNamed:@"play-lan_next1.png"] forState:UIControlStateNormal];
    [self.lastPlayBtn addTarget:self action:@selector(lastPlayBtnClicke) forControlEvents:UIControlEventTouchUpInside];
    [self.footImageView addSubview:self.lastPlayBtn];
}

-(void)setVoiceView{
    //进度条
    self.voiceSlider = [[HJHMySliderView alloc]initWithFrame:CGRectMake(-80, 140, 200, 50)];
    self.voiceSlider.isHorizontal = NO;
    [self.voiceSlider setPlayingJinDuImageViewAndPlayBtnImageView:0.3];
    self.voiceSlider.transform = CGAffineTransformRotate(self.voiceSlider.transform, 3.14/2);
    self.voiceSlider.delegate = self;
    self.voiceSlider.tag = 1001;
    [self.bgImageView addSubview:self.voiceSlider];
    [self.voiceSlider setPlayingJinDuImageViewAndPlayBtnImageView:[MPMusicPlayerController applicationMusicPlayer].volume];
    [self.voiceSlider setBgImageViewImage:[UIImage imageNamed:@"scrubsilider_on.png"]];
    [self.voiceSlider setPlayingImageViewImage:[UIImage imageNamed:@"scrubsilider_off.png"]];
    [self.voiceSlider setLoadingImageViewImage:[UIImage imageNamed:@""]];
}

//点击播放按钮
-(void)playBtnClick{
    if (isPlay) {
        [self.playBtn setImage:[UIImage imageNamed:@"play-lan_play.png"] forState:UIControlStateNormal];
        canPlay = NO;
        [self.playerViewController.moviePlayer pause];
        //销毁timer
        [self.getCurrentPlayBackTimer invalidate];
        self.getCurrentPlayBackTimer = nil;
    }else{
        [self.playBtn setImage:[UIImage imageNamed:@"play-lan_stop.png"] forState:UIControlStateNormal];
        canPlay = YES;
        //开启timer
        [self currentPlayBackTimer];
        [self.playerViewController.moviePlayer play];
    }
    isPlay = !isPlay;
}

-(void)stopBtnClick{
    if ([self.playerViewController.moviePlayer isPreparedToPlay]) {
        [self.playerViewController.moviePlayer stop];
    }else{
        [self videoFinished];
    }
    [self.playBtn setImage:[UIImage imageNamed:@"play-lan_play.png"] forState:UIControlStateNormal];
}

-(void)locationPlayVideo:(NSString *)cachePath{
    isLocationPlay = YES;
    self.playerViewController = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"vedio.mp4"]]]];
    [self playerViewControllerSetting:self.playerViewController];
}

- (void)playVideo{
    isLocationPlay = NO;
    self.playerViewController =[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:@"http://127.0.0.1:12345/vedio.mp4"]];
    [self playerViewControllerSetting:self.playerViewController];
}

-(void)playerViewControllerSetting:(MPMoviePlayerViewController*)playerViewController{
    playerViewController.moviePlayer.controlStyle = MPMovieControlStyleNone;
    [self addChildViewController:playerViewController];
    playerViewController.view.frame = self.view.bounds;
    [self.view addSubview:playerViewController.view];
    [self.view sendSubviewToBack:playerViewController.view];
    //开启timer
    [self currentPlayBackTimer];
    
    [self.playBtn setImage:[UIImage imageNamed:@"play-lan_stop.png"] forState:UIControlStateNormal];
}

-(void)videoPlay{
    NSString *webPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Private Documents/Temp"];
    NSString *cachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Private Documents/Cache"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:cachePath])
    {
        [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if ([fileManager fileExistsAtPath:[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"vedio.mp4"]]]) {
        [self locationPlayVideo:cachePath];
        isPlay = YES;
        self.videoRequest = nil;
    }else{
        ASIHTTPRequest *request=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"]];
        //下载完存储目录
        [request setDownloadDestinationPath:[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"vedio.mp4"]]];
        //临时存储目录
        [request setTemporaryFileDownloadPath:[webPath stringByAppendingPathComponent:[NSString stringWithFormat:@"vedio.mp4"]]];
        [request setBytesReceivedBlock:^(unsigned long long size, unsigned long long total) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setDouble:total forKey:@"file_length"];
            Recordull += size;//Recordull全局变量，记录已下载的文件的大小
            if (Recordull > 10000) {
                if (canPlay) {
                    isPlay = !isPlay;
                    if (!self.playerViewController) {
                        [self playVideo];
                    }else{
                        [self.playerViewController.moviePlayer play];
                        [self.playBtn setImage:[UIImage imageNamed:@"play-lan_stop.png"] forState:UIControlStateNormal];
                    }
                }
            }
            NSString *totalString = [NSString stringWithFormat:@"%0.1lluG",total];
            NSString *RecordullString = [NSString stringWithFormat:@"%0.1lluG",Recordull];
            CGFloat f = [RecordullString floatValue]/[totalString floatValue];
            loadingRate = f;
            [self.mySliderView setLoadingImageView:loadingRate];
            //NSLog(@"+hellos++++%f",f);
        }];
        //断点续载
        [request setAllowResumeForFileDownloads:YES];
        [request startAsynchronous];
        self.videoRequest = request;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//横屏操作
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

-(BOOL)shouldAutorotate
{
    return YES;
}

#pragma mark -返回通知
-(void)videoFinished{
    //销毁timer
    [self.getCurrentPlayBackTimer invalidate];
    self.getCurrentPlayBackTimer = nil;
    self.playerViewController = nil;
    [self.videoRequest clearDelegatesAndCancel];
    
    if (self.videoRequest) {
        isPlay = !isPlay;
        self.videoRequest = nil;
    }
    [self dismissModalViewControllerAnimated:YES];
}

-(void)videoStateChange{
    
}

-(void)videoPlayingJinDu{
    if (isPlay) {
        CGFloat f = self.playerViewController.moviePlayer.currentPlaybackTime;
        CFTimeInterval k = self.playerViewController.moviePlayer.duration;
        //NSLog(@"%f",k);
        if (self.mySliderView) {
            //NSLog(@"zhengTai %f",f);
            [NSObject cancelPreviousPerformRequestsWithTarget:self.mySliderView selector:@selector(setPlayingJinDuImageViewAndPlayBtnImageView:) object:nil];
            [self.mySliderView setPlayingJinDuImageViewAndPlayBtnImageView:f/k];
        }
        //NSLog(@"hello,%f",f);
    }else{
        //销毁timer
        [self.getCurrentPlayBackTimer invalidate];
        self.getCurrentPlayBackTimer = nil;
    }
}

-(void)currentPlayBackTimer{
    self.getCurrentPlayBackTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(videoPlayingJinDu) userInfo:nil repeats:YES];
}


#pragma mark - sliderViewDelegate
-(void)currentJinDu:(CGFloat)jinDu tag:(NSInteger)tag{
    if (tag == 1000) {
        [self.playBtn setImage:[UIImage imageNamed:@"play-lan_play.png"] forState:UIControlStateNormal];
        [self.playerViewController.moviePlayer pause];
        //销毁timer
        [self.getCurrentPlayBackTimer invalidate];
        self.getCurrentPlayBackTimer = nil;
        isPlay = NO;
        canPlay = NO;
        if (jinDu < loadingRate) {
            [self.playerViewController.moviePlayer setCurrentPlaybackTime:self.playerViewController.moviePlayer.duration*jinDu];
            NSLog(@"fuTai %f",self.playerViewController.moviePlayer.duration*jinDu);
        }
        self.mySliderView.canChangeFrame = YES;
    }
    if (tag == 1001) {
        NSLog(@"%f",jinDu);
        if (jinDu > 0.99) {
            jinDu = 1;
        }
        [[MPMusicPlayerController applicationMusicPlayer] setVolume:jinDu];
    }
}

-(void)drapJinDuBtnUpInsideWithTag:(NSInteger)tag{
    if (tag == 1000) {
        isPlay = YES;
        canPlay = YES;
        [self currentPlayBackTimer];
        [self.playerViewController.moviePlayer play];
        [self.playBtn setImage:[UIImage imageNamed:@"play-lan_stop.png"] forState:UIControlStateNormal];
    }
    if (tag == 1001) {
        
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)BgImageViewTap{
    if (self.headerImageView.hidden == YES) {
        [self.headerImageView setHidden:NO];
        [self.footImageView setHidden:NO];
        [self.voiceSlider setHidden:NO];
    }else{
        [self.headerImageView setHidden:YES];
        [self.footImageView setHidden:YES];
        [self.voiceSlider setHidden:YES];
    }
    
}

-(void)nextPlayBtnClicke{
    NSLog(@"没有下一曲");
}

-(void)lastPlayBtnClicke{
    NSLog(@"没有上一曲");
}

-(void)dealloc{
    
}

@end

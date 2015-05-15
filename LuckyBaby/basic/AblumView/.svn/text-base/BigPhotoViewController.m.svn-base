//
//  BigPhotoViewController.m
//  xiaozhan
//
//  Created by huang on 3/24/14.
//  Copyright (c) 2014 Kugou. All rights reserved.
//

#import "BigPhotoViewController.h"
#import "CustomImage.h"
#import "PostDataBean.h"
#import "ColorEx.h"
#import "KGTipView.h"

@interface BigPhotoViewController ()
@property(nonatomic,assign)BOOL canShowBar;
@property(nonatomic,strong)UIScrollView *bgImageView;
@property(nonatomic,strong)HJHMyImageView *footBar;
@property(nonatomic,strong)HJHMyButton* editeNoteButton;
@property(nonatomic,assign)NSInteger photoEditNumber;
@property(nonatomic,strong)HJHMyButton *completeBtn;
@end

@implementation BigPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithGroupData:(NSMutableArray *)groupData{
    if (self = [super init]) {
        self.photoArray = groupData;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    //扩展到不透明的区域
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.footBar.hidden = NO;
    self.canShowBar = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popBackWithSwap) name:@"panRecognizerStateBegan" object:nil];
    [self setBgImgView2];
    //[self addBiggerAnimation];
    [self addTapGesture];
    [self setFootBar];
    [self setLeftBtn];
    [self setRightBtn];
    self.photoEditNumber = 0;
	// Do any additional setup after loading the view.
}

-(void)setLeftBtn{
    self.view.backgroundColor = [UIColor blueColor];
    HJHMyButton *editeNoteButton = [HJHMyButton buttonWithType:UIButtonTypeCustom];
    editeNoteButton.frame = CGRectMake(0, 0, 41.5, 21.5);
    [editeNoteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    editeNoteButton.titleLabel.font = [UIFont systemFontOfSize:18];
    //[editeNoteButton setImage:[UIImage imageNamed:@"popBack.png"] forState:UIControlStateNormal];
    [editeNoteButton setTitle:@"返回" forState:UIControlStateNormal];
    //[editeNoteButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 37)];
    [editeNoteButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editeNoteButton];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

-(void)setRightBtn{
    self.view.backgroundColor = [UIColor blueColor];
    self.editeNoteButton = [HJHMyButton buttonWithType:UIButtonTypeCustom];
    self.editeNoteButton.frame = CGRectMake(0, 0, 21.5, 21.5);
    [self.editeNoteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.editeNoteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.editeNoteButton setImage:[UIImage imageNamed:@"weixuan.png"] forState:UIControlStateNormal];
    self.editeNoteButton.selected = YES;
    [self.editeNoteButton setImage:[UIImage imageNamed:@"xuanzhongde.png"] forState:UIControlStateSelected];
    //[editeNoteButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 37)];
    [self.editeNoteButton addTarget:self action:@selector(didSelected:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self. editeNoteButton];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

-(void)setBgImgView2{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.clipsToBounds = YES;
    if (iPhone5) {
        self.bgImageView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    }else{
        self.bgImageView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    }
    self.bgImageView.showsHorizontalScrollIndicator = NO;
    self.bgImageView.showsVerticalScrollIndicator = NO;
    self.bgImageView.delegate = self;
    if (iPhone5) {
        [self.bgImageView setContentSize:CGSizeMake(self.photoArray.count*320, 568)];
    }else{
       [self.bgImageView setContentSize:CGSizeMake(self.photoArray.count*320, 480)];
    }
    
    for (int i = 0; i<self.photoArray.count; i++) {
        UIImageView *imageView;
        if (iPhone5) {
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*320, 0, 320, 568)];
        }else{
            imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*320, 0, 320, 480)];
        }
        
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = ((PostDataBean*)[self.photoArray objectAtIndex:i]).photo;
        [self.bgImageView addSubview:imageView];
    }
    self.bgImageView.pagingEnabled = YES;
    self.bgImageView.backgroundColor = [UIColor whiteColor];
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.bgImageView];
}

-(void)setFootBar{
    self.footBar = [[HJHMyImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 46, 320, 46)];
//    self.footBar.backgroundColor = [UIColor colorWithHexString:@"#1eb6b6"];
    self.footBar.backgroundColor = [UIColor colorWithHexString:@"#282828"];
    [self.view addSubview:self.footBar];
    self.completeBtn = [[HJHMyButton alloc]initWithFrame:CGRectMake(241, 11, 65, 29)];
    self.completeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.completeBtn setBackgroundImage:[UIImage imageNamed:@"completeAbleBtn.png"] forState:UIControlStateNormal];
    [self.completeBtn setBackgroundImage:[UIImage imageNamed:@"Album_btn_selected.png"] forState:UIControlStateHighlighted];
    [self.completeBtn setBackgroundImage:[UIImage imageNamed:@"completeEnableBtn@2x.png"] forState:UIControlStateDisabled];
    [self.completeBtn addTarget:self action:@selector(completePopBack) forControlEvents:UIControlEventTouchUpInside];
    [self.footBar addSubview:self.completeBtn];
}

-(void)popBack{
    NSMutableArray *popBackArray = [NSMutableArray array];
    for (PostDataBean*bean in self.photoArray) {
        if (bean.isSelectedPhoto == NO) {
            [popBackArray addObject:bean];
        }
    }
    [self.delegate resetGetPhotoView:self.assests grounArray:popBackArray groundStringArray:self.groundStringArray];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)popBackWithSwap{
    NSMutableArray *popBackArray = [NSMutableArray array];
    for (PostDataBean*bean in self.photoArray) {
        if (bean.isSelectedPhoto == NO) {
            [popBackArray addObject:bean];
        }
    }
    [self.delegate resetGetPhotoView:self.assests grounArray:popBackArray groundStringArray:self.groundStringArray];
}

-(void)completePopBack{
    NSMutableArray *popBackArray = [NSMutableArray array];
    for (PostDataBean*bean in self.photoArray) {
        if (bean.isSelectedPhoto == NO) {
            [popBackArray addObject:bean];
        }
    }
    
    if ((self.photoNumber + self.photoArray.count > 10 + self.photoEditNumber) && self.style == 1) {
        NSString *tipString = [NSString stringWithFormat:@"你最多只能选择%ld张照片",10 - self.photoNumber];
        KGTipView *tipView = [[KGTipView alloc]initWithTitle:nil context:tipString cancelButtonTitle:@"我知道了" otherCancelButton:nil lockType:LockTypeSelf delegate:self userInfo:nil];
        [tipView setBackgroundColor:[UIColor whiteColor]];
//        [tipView defaultStyle];
        [tipView show];
    }else{
        if ([self.delegate2 respondsToSelector:@selector(getPhotoDataArray:)]) {
            if (popBackArray.count == 0) {
                
            }else{
                [self.delegate2 getPhotoDataArray:popBackArray];
            }
        }
        if ([self.delegate2 respondsToSelector:@selector(reloadTableView)]) {
            if (popBackArray.count == 0) {
                
            }else{
                [self.delegate2 reloadTableView];
            }
            
        }
        if (popBackArray.count == 0) {
            
        }else{
            if (self.navigationController.viewControllers.count >= 4) {
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 4] animated:YES];
            }
        }
    }
    
}

-(void)didSelected:(HJHMyButton*)btn{
    if (btn.selected == YES) {
        btn.selected = NO;
        NSInteger number = self.bgImageView.contentOffset.x/320;
        PostDataBean *bean = [self.photoArray objectAtIndex:number];
        CustomImage *image = [self.assests objectAtIndex:bean.photoNumber];
        image.isSelected = NO;
        bean.isSelectedPhoto = YES;
        NSMutableArray *groundArray = [NSMutableArray array];
        for (NSString *groundString in self.groundStringArray) {
            if ([groundString isEqualToString:image.groundDataString]) {
            }else{
                [groundArray addObject:groundString];
            }
        }
        self.groundStringArray = groundArray;
        //用于判断是否超过图片数
        self.photoEditNumber ++;
    }else{
        btn.selected = YES;
        NSInteger number = self.bgImageView.contentOffset.x/320;
        PostDataBean *bean = [self.photoArray objectAtIndex:number];
        CustomImage *image = [self.assests objectAtIndex:bean.photoNumber];
        image.isSelected = YES;
        bean.isSelectedPhoto = NO;
        [self.groundStringArray addObject:image.groundDataString];
        //用于判断是否超过图片数
        self.photoEditNumber --;
    }
    
    if (self.photoArray.count - self.photoEditNumber == 0) {
        self.completeBtn.enabled = NO;
    }else{
        self.completeBtn.enabled = YES;
    }
}

//-(void)addBiggerAnimation{
//    self.bgImageView.alpha = 0.1;
//    self.view.backgroundColor = [UIColor clearColor];
//    self.view.frame = self.viewFrame;
//    NSLog(@"%f,%f",self.view.frame.origin.y ,self.view.frame.size.height);
//    [UIView beginAnimations:@"" context:nil];
//    [UIView setAnimationDuration:0.25];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    CGRect r = self.view.frame;
//    r = CGRectMake(0, 0, 320, 568);
//    self.view.frame = r;
//    [UIView commitAnimations];
//    
//    
//    [UIView beginAnimations:@"" context:nil];
//    [UIView setAnimationDuration:1];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    self.bgImageView.alpha = 1;
//    [UIView commitAnimations];
//}

-(void)addTapGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBar)];
    [self.view addGestureRecognizer:tap];
}

-(void)showBar{
    if (self.canShowBar == NO) {
        self.navigationController.navigationBar.hidden = YES;
        self.canShowBar = YES;
        self.footBar.hidden = YES;
    }else{
        self.navigationController.navigationBar.hidden = NO;
        self.footBar.hidden = NO;
        self.canShowBar = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.x);
    NSInteger number = scrollView.contentOffset.x/320;
    PostDataBean *bean = [self.photoArray objectAtIndex:number];
    if (bean.isSelectedPhoto == YES) {
        self.editeNoteButton.selected = NO;
    }else{
        self.editeNoteButton.selected = YES;
    }
}
@end

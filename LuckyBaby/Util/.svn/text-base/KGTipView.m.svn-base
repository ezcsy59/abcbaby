//
//  KGTipView.m
//  5Sing
//
//  Created by NickyWan on 14-1-16.
//  Copyright (c) 2014年 hjh. All rights reserved.
//

#import "KGTipView.h"
#import "AppDelegate.h"
#import "stringChange.h"

#define TipFont [UIFont systemFontOfSize:TipFontSize]
#define TipFontSize 16
#define TipTittleFont [UIFont systemFontOfSize:TipTitleFontSize]
#define TipTitleFontSize 18
#define DefaultSize CGSizeMake(270, 100)
#define BtnHeight 44
#define BtnFontSize 17

#define contextMAXSize (_btnArray.count>0? 200 :130)
#define contextMINSize (_btnArray.count>0? 130 :110)
#define tipMINSize (_btnArray.count>0? 230 :150)
#define tipMAXSize 270
#define tipMAXHeight 250

/*
 文本大小最大不超过 200
 tipView大小最小不超过 230 最大不超过270
 */

@implementation UIImage (KGActionSheetImage)
+ (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end

@interface KGTipView(){
    CGRect rect;
}
@property(nonatomic,strong)UIView *bg;
@property(nonatomic,strong)UIView *tipView;
@property(nonatomic,strong)UIActivityIndicatorView *indicator;
@property(nonatomic,assign)KGTipViewLockType lock;
@property(nonatomic,assign)KGTipViewType type;
@property(nonatomic,strong)UIButton *ensureBtn;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)NSMutableArray *btnArray;
@property(nonatomic,strong)UIView *btnView;
@property(nonatomic,assign)UIActivityIndicatorViewStyle indicatorStyle;
@property(nonatomic,strong)id userInfo;

@property(nonatomic,strong)UIScrollView *scroll;
@end

@implementation KGTipView

////////////////////////////////////////////////
- (id)initWithTitle:(NSString*)title context:(NSString*)context cancelButtonTitle:(NSString*)cancelTitle otherCancelButton:(NSArray*)titles lockType:(KGTipViewLockType)lock delegate:(id)delegate userInfo:(id)userInfo
{
    self = [super init];
    if (self) {
        
        self.duration = 1;
        self.alpha = 0;
        
        self.delegate = delegate;
        self.userInfo = userInfo;
        self.userInteractionEnabled = YES;
        
        //  默认锁全局
        if (lock) {
            self.lock = lock;
        }else{
            self.lock = LockTypeGlobal;
        }
        //  蒙层
        self.backgroundColor = [UIColor clearColor];
        self.bg = [[UIView alloc] init];
        self.bg.backgroundColor = [UIColor blackColor];
        self.bg.alpha = .5;
        [self addSubview:self.bg];
        [self sendSubviewToBack:_bg];
        
        rect = [[[UIApplication sharedApplication] delegate] window].bounds;
        
        //  蒙层
        if (self.lock==LockTypeSelf) {
            self.frame = [(UIViewController*)self.delegate view].bounds;
            _bg.frame = self.bounds;
            _bg.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAciont)];
            [_bg addGestureRecognizer:tap];
        }
        if (lock==LockTypeGlobal) {
            self.frame = rect;
            _bg.frame = rect;
        }
        self.clipsToBounds = YES;
        
        //  加载文本
        [self createTypeText:title context:context];
        
        //  加载按钮
        if (cancelTitle) {
            [self initCancelBtn:cancelTitle otherTitles:titles];
        }
        
        [self setTipViewColor:blackColor];
        if (cancelTitle) {
            [self setTipViewColor:whiteColor];
        }
    }
    return self;
}
/////////////////////////////
- (void)initCancelBtn:(NSString*)title otherTitles:(NSArray*)titles{
    self.btnView = [[UIView alloc] init];
    [_tipView addSubview:_btnView];
    self.type = TypeButton;
    self.btnArray = [NSMutableArray array];
    
    for (int i=0; i<titles.count+1; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_btnView addSubview:btn];
        
        if (i==0) {
            [btn setTitle:title forState:UIControlStateNormal];
        }else{
            [btn setTitle:[titles objectAtIndex:i-1] forState:UIControlStateNormal];
        }
                btn.tag = i;
        [_btnArray addObject:btn];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

//////////////////////////////
- (void)createTypeText:(NSString*)title context:(NSString*)context{
    
    //  窗口
    self.tipView = [[UIView alloc] initWithFrame:CGRectZero];
    _tipView.backgroundColor = [UIColor whiteColor];
    _tipView.alpha = .2;
    _tipView.frame = CGRectMake(20, 20, DefaultSize.width, DefaultSize.height);
    _tipView.layer.cornerRadius = 8;
    _tipView.clipsToBounds = YES;
    _tipView.userInteractionEnabled = YES;
    [self addSubview:_tipView];
    
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self.tipView addSubview:self.scroll];
    
    //  标题
    if (title) {
        self.title = [[UILabel alloc] initWithFrame:CGRectZero];
        [_tipView addSubview:_title];
        _title.text = title;
        _title.backgroundColor = [UIColor clearColor];
        _title.textColor = [UIColor blackColor];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = TipTittleFont;
    }
    //  内容
    self.context = [[UILabel alloc] initWithFrame:CGRectZero];
    [_scroll addSubview:_context];
    _context.text = context;
    _context.numberOfLines = 0;
    _context.textAlignment = NSTextAlignmentCenter;
    _context.backgroundColor = [UIColor clearColor];
    _context.textColor = [UIColor blackColor];
    _context.font = TipFont;
    
}

- (void)createTypeLoading{
    if (!_indicator) {
        self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.indicatorStyle];
        [_tipView addSubview:_indicator];
    }
    [_indicator startAnimating];
}

#pragma mark - ========== Show & Hide ==========
- (void)show{
    
    [self setViewsPositsion];
    CGAffineTransform Transform =
    CGAffineTransformScale(_tipView.transform, _btnArray.count>0? 1.5:1, _btnArray.count>0? 1.5:1);
    [_tipView setTransform:Transform];
    
    if (_lock==LockTypeGlobal) {
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
    }else {
        [[(UIViewController*)self.delegate view] addSubview:self];
    }
    /*
    [UIView animateWithDuration:.15 animations:^{
        self.alpha = 1;
        self.tipView.alpha = 1;
        CGAffineTransform newTransform =
        CGAffineTransformConcat(_tipView.transform, CGAffineTransformInvert(_tipView.transform));
        [_tipView setTransform:newTransform];
    } completion:^(BOOL finished) {
        if (_type==TypeText) {
            [self hideWithDelay:self.duration];
        }
    }];
    */
    self.hidden = NO;
    self.alpha = 1;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:(_btnArray.count>0? 0.25 : 0.1)];
    
    self.tipView.alpha = ([_tipView.backgroundColor isEqual:[UIColor whiteColor]]? .9 : .85);
    CGAffineTransform newTransform =
    CGAffineTransformConcat(_tipView.transform, CGAffineTransformInvert(_tipView.transform));
    [_tipView setTransform:newTransform];
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDidStopSelector:@selector(showAnimationFinished)];
    [UIView commitAnimations];
}

- (void)showAnimationFinished{
    if (_type==TypeText) {
        [self hideWithDelay:self.duration];
    }
}

- (void)showWithLoading{
    [self createTypeLoading];
    self.type = TypeLoading;
    self.indicatorPosition = PositionTop;
    [self show];
}

- (void)hideWithDelay:(NSTimeInterval)delay{
    /*
    [UIView animateKeyframesWithDuration:.1 delay:delay options:0 animations:^{
        self.alpha = 0;
        CGAffineTransform newTransform =
        CGAffineTransformScale(_tipView.transform, .6, .6);
        [_tipView setTransform:newTransform];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
     */
    [NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(hideAnimationFinished:) userInfo:nil repeats:NO];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:2];
    [UIView setAnimationDelay:delay];
    CGAffineTransform newTransform =
    CGAffineTransformScale(_tipView.transform, ((_btnArray&&_btnArray.count>0)? .6 : 1), ((_btnArray&&_btnArray.count>0)? .6 : 1));
    [_tipView setTransform:newTransform];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

- (void)hideAnimationFinished:(NSTimer*)timer{
    [self removeFromSuperview];
    self.alpha = 0;
    [timer invalidate];
}

- (void)stopLoadingAnimationWithTitle:(NSString *)title context:(NSString *)context duration:(NSTimeInterval)duration{
    [self.indicator stopAnimating];
    [_indicator removeFromSuperview];self.indicator = nil;
    if (title) {
        self.title.text = title;
    }
    if (context) {
        self.context.text = context;
        self.type = TypeText;
        [self setViewsPositsion];
    }
    
    [self hideWithDelay:duration];
}

#pragma mark - ============ 布局 ============
- (void)setViewsPositsion{
    /*
     文本大小最大不超过 200
     tipView大小最小不超过 230 最大不超过270
     */
    
    //  调整文本大小
    _context.frame = CGRectMake(0, 0, 0, TipFontSize);
    [_context sizeToFit];
    
    if (_context.frame.size.width>contextMAXSize) {
        _context.frame = CGRectMake(0, 0, contextMAXSize, 0);
        [_context sizeToFit];
   }
    //  调整tipView大小啊
    if (_context.frame.size.width<contextMINSize) {
        _tipView.frame = CGRectMake(0, 0, tipMINSize, 100);
        _scroll.frame = _tipView.bounds;
        _context.center = CGPointMake(_tipView.frame.size.width/2.0, _tipView.frame.size.height/2.0);
    } else{
        _tipView.frame = CGRectMake(0, 0, _context.frame.size.width+50, _context.frame.size.height+40);
        if (_tipView.frame.size.height<100) {
            _tipView.frame = CGRectMake(0, 0, _tipView.frame.size.width, 100);
            _context.center = CGPointMake(_tipView.frame.size.width/2.0, _tipView.frame.size.height/2.0);
        } else if(_tipView.frame.size.height>tipMAXHeight) {
            _tipView.frame = CGRectMake(0, 0, _tipView.frame.size.width, tipMAXHeight);
            _context.frame = CGRectMake(25, 20, _context.frame.size.width, _context.frame.size.height);
            _scroll.contentSize = CGSizeMake(_tipView.frame.size.width, _context.frame.origin.y+_context.frame.size.height+20);
        } else {
            _context.center = CGPointMake(_tipView.frame.size.width/2.0, _tipView.frame.size.height/2.0);
        }
        _scroll.frame = _tipView.bounds;
    }
    
    CGSize tipSize = _tipView.frame.size;

    if (_btnArray && _btnArray.count>0) {
        if (_tipView.frame.size.height<DefaultSize.height) {
            tipSize.width = _tipView.frame.size.width;
            tipSize.height = DefaultSize.height;
            _tipView.frame = CGRectMake(0, 0, tipSize.width, tipSize.height);
        }
//        _context.center = CGPointMake(_tipView.frame.size.width/2.0, _tipView.frame.size.height/2.0);

    }
    
    
    
    if (_title) {
        _title.frame = CGRectMake(0, 25, tipSize.width, TipTitleFontSize);
        CGRect scrollRect = _scroll.frame;
        scrollRect.origin.y = _title.frame.origin.y+_title.frame.size.height+10;
        _scroll.frame = scrollRect;
        _context.center = CGPointMake(_context.center.x, _context.center.y-20);
        _scroll.contentSize = CGSizeMake(_scroll.contentSize.width, _scroll.contentSize.height-20);
        _tipView.frame = CGRectMake(0, 0, tipSize.width, tipSize.height+_title.frame.size.height+10+25);
        tipSize = _tipView.frame.size;
    }
    
    if (_type==TypeLoading) {
        switch (_indicatorPosition) {
            case PositionLeft:
                if (_indicator) {
                    tipSize.width += 70;
                    if (tipSize.width>270) {
                        _context.frame = CGRectMake(0, 0, 180, 0);
                        [_context sizeToFit];
                    }
                    _indicator.center = CGPointMake(35, tipSize.height/2.0);
                    _context.center = CGPointMake(tipSize.width/2.0, tipSize.height/2.0+65);
                    _tipView.frame = CGRectMake(0, 0, tipSize.width, _context.frame.size.height+40);
                }
                break;
            case PositionTop:
                tipSize.height += 25;
                _tipView.frame = CGRectMake(0, 0, tipSize.width, tipSize.height);
                _scroll.frame = _tipView.bounds;
                _context.center = CGPointMake(_context.center.x, _context.center.y+20);
                _indicator.center = CGPointMake(tipSize.width/2.0, _context.frame.origin.y-15);
                break;
            case PositionButtom:
                
                break;
            case PositionRight:
                
                break;
        }
    }
    
    if (_btnArray && _btnArray.count>0) {
        if (_btnArray.count>3) {
            
        } else {
            for (int i=0; i<_btnArray.count; i++) {
                UIView *btn = [_btnArray objectAtIndex:i];
                btn.frame = CGRectMake(((tipSize.width-.3*(_btnArray.count-1))/_btnArray.count+.5)*i, 0.5, (tipSize.width-.3*(_btnArray.count-1))/_btnArray.count, BtnHeight);
            }
            _btnView.frame = CGRectMake(0, tipSize.height, tipSize.width, BtnHeight+.5);
            _tipView.frame = CGRectMake(0, 0, tipSize.width, tipSize.height+BtnHeight+.5);
        }
    }
    
    
    switch (_lock) {
        case LockTypeNone:
            self.frame = _tipView.frame;
            self.center = CGPointMake(rect.size.width/2.0, rect.size.height/2.0-20);
            _tipView.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
            break;
        case LockTypeSelf:
            _tipView.center = CGPointMake(rect.size.width/2.0, rect.size.height/2.0-70);
            break;
        case LockTypeGlobal:
            _tipView.center = CGPointMake(rect.size.width/2.0, rect.size.height/2.0-50);
            break;
    }
    
    if (_btnArray && _btnArray.count>0) {
        _tipView.center = CGPointMake(rect.size.width/2.0, rect.size.height/2.0);
    }
}

#pragma mark - ========== Delegate ===========
- (void)btnAction:(UIButton*)btn{
    if ([_delegate respondsToSelector:@selector(KGTipVIew:buttonOfIndex:userInfo:)]) {
        [self.delegate KGTipVIew:self buttonOfIndex:btn.tag userInfo:self.userInfo];
    }
    [self hideWithDelay:0];
}
#pragma mark - ========== 设置属性 ===========

- (void)setCoverColor:(UIColor*)color alpha:(float)alpha{
    self.bg.backgroundColor = color;
    self.bg.alpha = alpha;
}

- (void)setButtonTittle:(NSString *)title ofIndex:(NSInteger)index{
    
    [[_btnArray objectAtIndex:index] setTitle:title forState:UIControlStateNormal];
    
}

- (void)setTipViewColor:(KGTipViewColor)color{
    switch (color) {
        case whiteColor:
            self.tipView.backgroundColor = [UIColor whiteColor];
            self.title.textColor = [UIColor blackColor];
            self.context.textColor = [UIColor blackColor];
            for (int i=0; i<_btnArray.count; i++) {
                UIButton *btn = [_btnArray objectAtIndex:i];
                [btn setTitleColor:[UIColor colorWithHexString:@"#007aff"]forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"#fafafa"]] forState:UIControlStateHighlighted];
            }
            self.btnView.backgroundColor = [UIColor colorWithHexString:@"#dadadb"];
            self.indicatorStyle = UIActivityIndicatorViewStyleGray;
            self.bg.backgroundColor = [UIColor blackColor];
            self.bg.alpha = .5;
            break;
        default:
            self.tipView.backgroundColor = [UIColor blackColor];
            self.title.textColor = [UIColor whiteColor];
            self.context.textColor = [UIColor whiteColor];
            for (int i=0; i<_btnArray.count; i++) {
                UIButton *btn = [_btnArray objectAtIndex:i];
                
                [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            self.btnView.backgroundColor = [UIColor whiteColor];
            self.indicatorStyle = UIActivityIndicatorViewStyleWhite;
            self.bg.backgroundColor = [UIColor clearColor];
            break;
    }
}

- (void)setAlignment:(NSTextAlignment)textAlignment{
    _context.textAlignment = textAlignment;
}

- (void)tapAciont{
    
}



@end

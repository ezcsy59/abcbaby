//
//  KGActionSheet.m
//  5Sing
//
//  Created by NickyWan on 14-1-15.
//  Copyright (c) 2014年 Kugou. All rights reserved.
//

#import "KGActionSheet.h"
#import "AppDelegate.h"
#define SheetFontSize 13
#define SheetBGColor [UIColor clearColor]
#define SheetBtnColor [UIColor whiteColor]
#define SheetBtn
#define SheetBtnSize CGSizeMake(300, 48)

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

@interface KGActionSheet(){
    UIView *bg;
    CALayer *titleBG;
}
@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UILabel *tittle;
@property (nonatomic,strong)NSMutableArray *btns;


@end

@implementation KGActionSheet

- (id)initWithCancelTittle:(NSString*)cancelTitle ButtonTittles:(NSArray*)titles delegate:(id<KGActionSheetDelegate>)delegate;
{
    self = [super init];
    if (self) {
        self.btns = [NSMutableArray array];
        self.frame = [[[UIApplication sharedApplication] delegate] window].bounds;
        bg = [[UIView alloc] initWithFrame:self.bounds];
        bg.backgroundColor = [UIColor blackColor];
        bg.alpha = 0;
        [self addSubview:bg];
        self.delegate = delegate;
        
        [self initSheet];
        [self initCancelBtn:cancelTitle];
        [self initBtns:titles];

        
    }
    return self;
}



- (void)initSheet{
    self.sheet = [[UIView alloc] initWithFrame:CGRectZero];
    //////////////////
    _sheet.frame = CGRectMake(0, self.bounds.size.height, 320, 320);
    _sheet.clipsToBounds = NO;
    [self addSubview:_sheet];
    
    _sheet.backgroundColor = [UIColor clearColor];
}

- (void)initTitle{
    
    self.tittle = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:_tittle];
    
}

- (void)defaultStyle
{
    UIImage *image = [UIImage imageNamed:@"register-kuan.png"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    UIImage *image4 = [UIImage imageNamed:@"jubao.png"];
    image4 = [image4 stretchableImageWithLeftCapWidth:image4.size.width/2 topCapHeight:image4.size.height/2];
    UIImage *image2 = [UIImage imageNamed:@"shangbian_btn.png"];
    image2 = [image2 stretchableImageWithLeftCapWidth:image2.size.width/2 topCapHeight:image2.size.height/2];
    UIImage *image3 = [UIImage imageNamed:@"xiabian_btn.png"];
    image3 = [image3 stretchableImageWithLeftCapWidth:image3.size.width/2 topCapHeight:image3.size.height/2];
    
    UIImage *image5 = [UIImage imageNamed:@"sheet_h.png"];
    image5 = [image5 stretchableImageWithLeftCapWidth:image3.size.width/2 topCapHeight:image3.size.height/2];
    UIImage *image6 = [UIImage imageNamed:@"bottom-green.png"];
    image6 = [image6 stretchableImageWithLeftCapWidth:image3.size.width/2 topCapHeight:image3.size.height/2];
    UIImage *image7 = [UIImage imageNamed:@"top-green.png"];
    image7 = [image7 stretchableImageWithLeftCapWidth:image3.size.width/2 topCapHeight:image3.size.height/2];
    
    
    [self setCancelButtonImage:image forState:UIControlStateNormal];
    [self setCancelButtonImage:image5 forState:UIControlStateHighlighted];
    [self setFontWithColor:[UIColor colorWithString:@"#23b5b5"] font:[UIFont systemFontOfSize:16]];
    [self setFontWithColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16] state:UIControlStateHighlighted];
    [self setCancelFontWithColor:[UIColor colorWithString:@"#23b5b5"] font:[UIFont systemFontOfSize:16]];
    [self setCancelFontWithColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16] state:UIControlStateHighlighted];
    
    if (self.btns.count == 1) {
        [self setOtherButtonImage:image forState:UIControlStateNormal btnNumber:0];
        [self setOtherButtonImage:image5 forState:UIControlStateHighlighted btnNumber:0];
    }
    else{
        for (int i = 1; i < self.btns.count - 1; i++) {
            [self setOtherButtonImage:image4 forState:UIControlStateNormal btnNumber:i];
            [self setOtherButtonColor:[UIColor colorWithRed:44/255.0 green:180/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateHighlighted btnNumber:i];
        }
        [self setOtherButtonImage:image2 forState:UIControlStateNormal btnNumber:[self.btns count]-1];
        [self setOtherButtonImage:image7 forState:UIControlStateHighlighted btnNumber:[self.btns count]-1];
        [self setOtherButtonImage:image3 forState:UIControlStateNormal btnNumber:0];
        [self setOtherButtonImage:image6 forState:UIControlStateHighlighted btnNumber:0];
    }
}

//  取消按钮
- (void)initCancelBtn:(NSString*)tittle{
    self.cancelBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    _cancelBtn.tag = 0;
    [_cancelBtn setTitle:tittle forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_sheet addSubview:_cancelBtn];
    NSLog(@"%@",self);
    NSLog(@"%@",_sheet);
    _cancelBtn.frame = CGRectMake(10, _sheet.frame.size.height-SheetBtnSize.height-10, SheetBtnSize.width, SheetBtnSize.height);
    _cancelBtn.adjustsImageWhenHighlighted = YES;
    
    //  按钮颜色
    [_cancelBtn setBackgroundColor:[UIColor whiteColor]];
    //  字体
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:SheetFontSize];
}

//  其他按钮
- (void)initBtns:(NSArray*)titles{
    for (int i=0; i<(titles.count>0? titles.count : 2); i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
        btn.tag = i+1;
        if (titles) {
            [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.btns addObject:btn];
        [_sheet addSubview:btn];
        
        _sheet.clipsToBounds = YES;
        btn.frame = CGRectMake(10, _sheet.frame.size.height-68-(i+1)*48, SheetBtnSize.width, SheetBtnSize.height);
        
        //  字体
        btn.titleLabel.font = [UIFont systemFontOfSize:SheetFontSize];
        //  颜色
        [btn setBackgroundColor:[UIColor lightGrayColor]];

    }
}

- (void)buttonAction:(UIButton*)btn{
    BOOL flag = YES;
    if ([_delegate respondsToSelector:@selector(KGActionSheet:willDissmissWithButtonIndex:)]) {
        flag = [self.delegate KGActionSheet:self willDissmissWithButtonIndex:btn.tag];
    }
    if (flag) {
        [self hide];
    }
}

- (void)setSheetBackgroundColor:(UIColor*)color{
    _sheet.backgroundColor = color;
}

- (void)setOtherButtonColor:(UIColor*)color forState:(UIControlState)state{
    for (int i=0; i<_btns.count; i++) {
        UIButton *btn = [_btns objectAtIndex:i];
        [btn setBackgroundImage:[UIImage createImageWithColor:color] forState:state];
    }
    [_cancelBtn setBackgroundImage:[UIImage createImageWithColor:color] forState:state];
}

- (void)setCancelButtonColor:(UIColor*)color forState:(UIControlState)state{
    [_cancelBtn setBackgroundImage:[UIImage createImageWithColor:color] forState:state];
    [_cancelBtn setBackgroundColor:[UIColor clearColor]];
}

- (void)setOtherButtonColor:(UIColor*)color forState:(UIControlState)state btnNumber:(int)i{
    UIButton *btn = [_btns objectAtIndex:i];
    [btn setBackgroundImage:[UIImage createImageWithColor:color] forState:state];
}

- (void)setOtherButtonImage:(UIImage*)image forState:(UIControlState)state{
    for (int i=0; i<_btns.count; i++) {
        UIButton *btn = [_btns objectAtIndex:i];
        [btn setBackgroundImage:image forState:state];
        [btn setBackgroundColor:[UIColor clearColor]];
    }
    [_cancelBtn setBackgroundImage:image forState:state];
}

- (void)setOtherButtonImage:(UIImage*)image forState:(UIControlState)state btnNumber:(NSInteger)i{
    UIButton *btn = [_btns objectAtIndex:i];
    [btn setBackgroundImage:image forState:state];
    [btn setBackgroundColor:[UIColor clearColor]];
}

- (void)setCancelButtonImage:(UIImage*)image forState:(UIControlState)state{
    [_cancelBtn setBackgroundImage:image forState:state];
    _cancelBtn.backgroundColor = [UIColor clearColor];
}

- (void)setFontWithColor:(UIColor *)color font:(UIFont *)font{
    for (int i=0; i<_btns.count; i++) {
        UIButton *btn = [_btns objectAtIndex:i];
        [btn setTitleColor:color forState:UIControlStateNormal];
        btn.titleLabel.font = font;
    }
}

- (void)setFontWithColor:(UIColor *)color font:(UIFont *)font state:(UIControlState)state{
    for (int i=0; i<_btns.count; i++) {
        UIButton *btn = [_btns objectAtIndex:i];
        [btn setTitleColor:color forState:state];
        btn.titleLabel.font = font;
    }
}

- (void)setFontWithColor:(UIColor *)color font:(UIFont *)font btnNumber:(NSInteger)i{
    UIButton *btn = [_btns objectAtIndex:i];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = font;
}

- (void)setEnableClickWihtBtnNumber:(NSInteger)i{
    UIButton *btn = [_btns objectAtIndex:i];
    btn.userInteractionEnabled = NO;
}

- (void)setCancelFontWithColor:(UIColor *)color font:(UIFont *)font{
    [_cancelBtn setTitleColor:color forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = font;
}

- (void)setCancelFontWithColor:(UIColor *)color font:(UIFont *)font state:(UIControlState)state{
    [_cancelBtn setTitleColor:color forState:state];
    _cancelBtn.titleLabel.font = font;
}

- (void)setTitle:(NSString*)title titleColor:(UIColor*)color font:(UIFont*)font{
    if (!_tittle) {
        self.tittle = [[UILabel alloc] initWithFrame:CGRectMake(10, -50, 300, 50)];
        _tittle.textColor = color;
        _tittle.backgroundColor = [UIColor clearColor];
        [_sheet addSubview:_tittle];
    }
    _tittle.text = title;
    if (title) {
        _tittle.textColor = color;
    }
    if (font) {
        _tittle.font = font;
    }
}

- (void)setTitleBackground:(UIColor*)color height:(float)height{
    if (!titleBG) {
        titleBG = [CALayer layer];
        [_sheet.layer addSublayer:titleBG];
        [_sheet bringSubviewToFront:_tittle];
    }
    if (color) {
        titleBG.backgroundColor = color.CGColor;
    }
    
    
    titleBG.frame = CGRectMake(0, -height, 320, height);
    _tittle.center = CGPointMake(titleBG.frame.size.width/2.0, -titleBG.frame.size.height/2.0);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
}

- (void)show{
    [[[[UIApplication sharedApplication]delegate] window] addSubview:self];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:0.25];
    _sheet.frame = CGRectMake(0, self.bounds.size.height-320, 320, 320);
    [UIView setAnimationDelegate:self];
    self.hidden = NO;
    bg.alpha = 0.4;
    [UIView setAnimationDidStopSelector:@selector(showAnimationFinished)];
    [UIView commitAnimations];
}

- (void)showAnimationFinished{
    
}

- (void)hide{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:0.25];
    _sheet.frame =  CGRectMake(0, self.bounds.size.height, self.frame.size.width,0);
    bg.alpha = 0.0;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(hideAnimationFinished)];
    [UIView commitAnimations];
}

- (void)hideAnimationFinished{
    [self removeFromSuperview];
}
@end

//
//  KGTipsView.h
//  5Sing
//
//  Created by NickyWan on 14-1-16.
//  Copyright (c) 2014年 hjh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, KGTipViewType) {
    TypeText= 0,
    TypeLoading,
    TypeButton,
    TypeLoadingAndButton
};
typedef NS_ENUM(NSInteger, KGTipViewLockType) {
    LockTypeGlobal= 0,      //  default is global
    LockTypeSelf,
    LockTypeNone
    
};
typedef NS_ENUM(NSInteger, KGTipViewColor) {
    whiteColor = 0,     //  default is white
    blackColor
};

typedef NS_ENUM(NSInteger, KGIndicatorPosition) {
    PositionLeft = 0,     //  default is left
    PositionTop,
    PositionButtom, 
    PositionRight
};

@protocol KGTipViewDelegate;

@interface KGTipView : UIView
@property(nonatomic,weak)id<KGTipViewDelegate> delegate;

@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UILabel *context;
@property(nonatomic,assign)NSTimeInterval duration;
@property(nonatomic,assign)KGIndicatorPosition indicatorPosition;

//  tittle可以为nil， lockType默认为Global - 全屏， delegate不能为空， userInfo可以在 KGTipViewDelegate 中取出来用

- (id)initWithTitle:(NSString*)title context:(NSString*)context cancelButtonTitle:(NSString*)cancelTitle otherCancelButton:(NSArray*)titles lockType:(KGTipViewLockType)lock delegate:(id)delegate userInfo:(id)userInfo;
 
- (void)setTipViewColor:(KGTipViewColor) color;
- (void)stopLoadingAnimationWithTitle:(NSString*)title context:(NSString*)context duration:(NSTimeInterval)duration;
- (void)setButtonTittle:(NSString*)title ofIndex:(NSInteger)index;
- (void)setAlignment:(NSTextAlignment)textAlignment;
- (void)setGap;
- (void)show;
- (void)showWithLoading;

- (void)setCoverColor:(UIColor*)color alpha:(float)alpha;
@end

@protocol KGTipViewDelegate <NSObject>
@optional
- (void)KGTipVIew:(KGTipView*)tipView buttonOfIndex:(NSInteger)index userInfo:(id)userInfo;
@end


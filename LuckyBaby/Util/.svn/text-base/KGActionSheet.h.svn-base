//
//  KGActionSheet.h
//  5Sing
//
//  Created by NickyWan on 14-1-15.
//  Copyright (c) 2014年 Kugou. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KGActionSheetDelegate;
@interface KGActionSheet : UIView
@property (nonatomic,strong)UIView *sheet;
@property (nonatomic, weak)id<KGActionSheetDelegate> delegate;

- (id)initWithCancelTittle:(NSString*)cancelTitle ButtonTittles:(NSArray*)titles delegate:(id<KGActionSheetDelegate>)delegate;

- (void)setSheetBackgroundColor:(UIColor*)color;
- (void)setOtherButtonColor:(UIColor*)color forState:(UIControlState)state;
- (void)setCancelButtonColor:(UIColor*)color forState:(UIControlState)state;
- (void)setOtherButtonColor:(UIColor*)color forState:(UIControlState)state btnNumber:(int)i;
- (void)setOtherButtonImage:(UIImage*)image forState:(UIControlState)state;
- (void)setOtherButtonImage:(UIImage*)image forState:(UIControlState)state btnNumber:(NSInteger)i;
- (void)setCancelButtonImage:(UIImage*)image forState:(UIControlState)state;
- (void)setFontWithColor:(UIColor*)color font:(UIFont*)font;
- (void)setCancelFontWithColor:(UIColor*)color font:(UIFont*)font;
- (void)setFontWithColor:(UIColor *)color font:(UIFont *)font btnNumber:(NSInteger)i;
- (void)setTitle:(NSString*)title titleColor:(UIColor*)color font:(UIFont*)font;
- (void)setTitleBackground:(UIColor*)color height:(float)height;
- (void)setEnableClickWihtBtnNumber:(NSInteger)i;
- (void)defaultStyle;
- (void)show;

//.R
- (void)setFontWithColor:(UIColor *)color font:(UIFont *)font state:(UIControlState)stat;
- (void)setCancelFontWithColor:(UIColor *)color font:(UIFont *)font state:(UIControlState)state;
@end

@protocol KGActionSheetDelegate <NSObject>
@optional

- (CGRect)rectForButtonsAtIndex:(NSInteger)index;
//- (UIFont*)fontOfButtonAtIndex:(NSInteger)index;
//- (UIColor*)fontColorOfButtonAtIndex:(NSInteger)index;

- (void)KGActionSheetCancel:(KGActionSheet *)actionSheet;
- (BOOL)KGActionSheet:(KGActionSheet*)sheet willDissmissWithButtonIndex:(NSInteger)index;
@end


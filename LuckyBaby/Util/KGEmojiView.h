//
//  KGEmojiView.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-13.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KGEmojiViewDelegate <NSObject>

-(void)hideView;

-(void)addEmoji:(NSString *)emoji;

-(void)addFirstEmoji:(NSString*)emoji isFirst:(BOOL)isFirst;
@end

@interface KGEmojiView : UIImageView
@property(nonatomic,assign)id<KGEmojiViewDelegate> delegate2;

-(instancetype)initWithEmoji;

-(instancetype)initWithFirstEmoji;
@end

//
//  KGSelectView.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-3-30.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KGSelectViewDelegate <NSObject>

-(void)selectBtnClick:(int)tag;

-(void)cancalSelectClicked;

@end

@interface KGSelectView : UIView
-(id)initWithDictionary:(NSMutableArray*)arr title:(NSString*)title cancelBtn:(NSString*)cancelBtn;

//只允许选择
-(id)initWithDictionary:(NSMutableArray*)arr;

-(id)initWithDictionary:(NSMutableArray*)arr withTitile:(NSString*)title;

@property(nonatomic,assign)id<KGSelectViewDelegate>delegate2;
@end

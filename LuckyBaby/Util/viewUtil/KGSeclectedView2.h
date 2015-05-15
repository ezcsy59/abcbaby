//
//  KGSeclectedView2.h
//  WDMVProducter
//
//  Created by 黄嘉宏 on 15-4-24.
//  Copyright (c) 2015年 wuhuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol KGSelectView2Delegate <NSObject>

-(void)selectBtnClick:(NSArray *)btnArray;

@end

@interface KGSeclectedView2 : UIView
-(id)initWithDictionary:(NSMutableArray*)arr withTitile:(NSString*)title andSelectedTagArray:(NSArray*)SelectedtagArray;

@property(nonatomic,assign)id<KGSelectView2Delegate>delegate2;
@end

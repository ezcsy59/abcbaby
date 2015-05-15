//
//  showBigPhotoViewController.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-5.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface showBigPhotoViewController : UIViewController
-(instancetype)initWithPhotoA:(NSArray*)photoA andTab:(NSInteger)tag isLocationPhoto:(BOOL)isLocationPhoto isClassShow:(BOOL)isClassShow;
@end

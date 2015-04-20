//
//  qinListTableViewCell.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-4.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol qinListTableViewCellDelegate <NSObject>


-(void)leftBtnClick:(BOOL)haveMan recId:(NSString*)recId nickName:(NSString*)nickName;

-(void)rightBtnClick:(BOOL)haveMan recId:(NSString*)recId nickName:(NSString*)nickName;

@end

@interface qinListTableViewCell : UITableViewCell
@property(nonatomic,strong)HJHMyImageView *bgImagaView;
@property(nonatomic,strong)HJHMyImageView *leftImageView;
@property(nonatomic,strong)HJHMyLabel *leftLabel1;
@property(nonatomic,strong)HJHMyLabel *leftLabel2;
@property(nonatomic,strong)HJHMyLabel *leftLabel3;
@property(nonatomic,strong)HJHMyLabel *rightLabel1;
@property(nonatomic,strong)HJHMyLabel *rightLabel2;
@property(nonatomic,strong)HJHMyLabel *rightLabel3;
@property(nonatomic,strong)HJHMyImageView *rightImage;
@property(nonatomic,strong)HJHMyImageView *footImage;

@property(nonatomic,strong)NSString *leftRec;
@property(nonatomic,strong)NSString *RightRec;

@property(nonatomic,strong)HJHMyButton *leftBtn;
@property(nonatomic,strong)HJHMyButton *rightBtn;

@property(nonatomic,assign)id<qinListTableViewCellDelegate>delegate2;

-(void)setDefualt;
@end

//
//  HJHMainCell.h
//  weixinDemo
//
//  Created by huang on 4/21/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MainCellDelegate2 <NSObject>
-(void)likeBtnClick:(int)row and:(int)section;
-(void)photoClick:(UIButton*)btn and:(int)row and:(int)section;
-(void)deleteBtnClick:(int)row and:(int)section;
-(void)commentBtnClick:(int)row and:(int)section;
@end

@interface HJHMainCell : UITableViewCell
@property(nonatomic,strong)HJHMyImageView *bgImagaView;
@end

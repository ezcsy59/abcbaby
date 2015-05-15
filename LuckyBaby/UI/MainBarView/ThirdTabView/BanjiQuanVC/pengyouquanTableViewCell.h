//
//  pengyouquanTableViewCell.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-12.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol pengyouquanTableViewCell <NSObject>

-(void)pingLunBtnClickWithNumberIndexRow:(NSString*)numberIndexRow;
-(void)loveBtnClickWithNumberIndexRow:(NSString*)numberIndexRow;

@end

@interface pengyouquanTableViewCell : UITableViewCell

@property(nonatomic,assign)id<pengyouquanTableViewCell> delegate2;
@property(nonatomic,strong)NSString *numberIndexRow;


-(void)resetViewView:(NSDictionary *)dic;

-(float)getCellHeight:(NSDictionary *)dic;

@end

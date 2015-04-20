//
//  HJHMessageTableViewCell.h
//  liaotian2
//
//  Created by huang on 7/2/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJHMessageTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *userImageView;
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UILabel *messageLabel;
@property(nonatomic,strong)UILabel *messageName;
@property(nonatomic,assign)BOOL isMyMessage;
@end

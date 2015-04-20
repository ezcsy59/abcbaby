//
//  HJHMessageTableViewController.h
//  liaotian2
//
//  Created by huang on 7/2/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJHMessageTableViewCell.h"
@interface HJHMessageTableViewController : UITableViewController
@property(nonatomic,strong)NSMutableArray *messageArray;
@property(nonatomic,strong)UIImage *talkingToImage;
@property(nonatomic,strong)NSString *talkingToName;
@end

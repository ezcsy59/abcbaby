//
//  HJHTalkingViewController.h
//  liaotian2
//
//  Created by huang on 7/2/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDeviceManager.h"
#import "HJHMessageTableViewController.h"
#import "UIInputToolbarViewController2.h"
@interface HJHTalkingViewController : FatherNavViewController<IChatManagerDelegate,IDeviceManagerDelegate,sendMessage>{
    UIInputToolbarViewController2 *InputToolbarView;
}
@property (strong, nonatomic) UIInputToolbarViewController2 *InputToolbarView;
@property (strong, nonatomic) NSString *talkingToName;
@property (strong ,nonatomic) UIImage *taklingToImage;
@property (assign, nonatomic) BOOL isGroup;
@end

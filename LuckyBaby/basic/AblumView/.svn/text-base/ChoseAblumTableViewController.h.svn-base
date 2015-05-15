//
//  ChoseAblumTableViewController.h
//  xiaozhan
//
//  Created by huang on 7/10/14.
//  Copyright (c) 2014 Kugou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "GetPhotoViewController.h"

@protocol ChoseAblumDelegate <NSObject>
@optional
-(void)getPhotoDataArray:(NSMutableArray*)array;
-(void)reloadTableView;
@end

@interface ChoseAblumTableViewController : UITableViewController<getPhotoViewDelegate>

@property(weak,nonatomic)id<ChoseAblumDelegate> delegate2;
@property(nonatomic,assign)int maxPhotoChose;
@property(nonatomic,assign)int maxPhotoChose2;
@property(retain,nonatomic)ALAssetsLibrary* library;

@property(nonatomic,assign)int sendPhotoStyle;
@end

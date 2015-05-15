//
//  GetPhotoViewController.h
//  xiaozhan
//
//  Created by huang on 11/27/13.
//  Copyright (c) 2013 Kugou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "BigPhotoViewController.h"

@protocol getPhotoViewDelegate <NSObject>
@optional
-(void)getPhotoDataArray:(NSMutableArray*)array;
-(void)reloadTableView;
@end

@interface GetPhotoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,BigPhotoViewDelegate>{
    UITableView* collectionTable;
    UITableView* groupTable;
    
    NSMutableArray* assets;
    NSMutableArray* seleteddata;
}
@property(nonatomic,assign)NSInteger photoNumber;

@property (nonatomic,retain) NSMutableArray *_dataArray;
@property(retain,nonatomic)ALAssetsGroup* group;
@property(retain,nonatomic)ALAssetsLibrary* library;
@property(retain,nonatomic)NSMutableArray* groupData;
@property(strong,nonatomic)NSString *ablumName;
@property(weak,nonatomic)id<getPhotoViewDelegate> delegate2;

@property(nonatomic,assign)int sendPhotoStyle;
//支持单张图片和多张图片选取（0为单张选取，1为多张选取）
-(id)initWithStyle:(NSInteger)style;
//公开的返回方法
-(void)popBack;
//做几个供外部调整ui的方法
//最多能选多少张图片
-(void)maxPhotoCanChose:(int)photoNumber;
//优先级更高的最多能选图片
-(void)maxPhotoCanChose2:(int)photoNumber;
@end

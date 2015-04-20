//
//  BigPhotoViewController.h
//  xiaozhan
//
//  Created by huang on 3/24/14.
//  Copyright (c) 2014 Kugou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJHMyImageView.h"
@protocol BigPhotoViewDelegate <NSObject>
@optional
-(void)popBack;
-(void)resetGetPhotoView:(NSMutableArray *)array grounArray:(NSMutableArray*)grounArray groundStringArray:(NSMutableArray*)groundStringArray;
@end

@protocol BigPhotoViewDelegate2 <NSObject>
@optional
-(void)getPhotoDataArray:(NSMutableArray*)array;
-(void)reloadTableView;
@end

@interface BigPhotoViewController : UIViewController<UIScrollViewDelegate>
@property(nonatomic,strong)HJHMyImageView *photoImageView;
@property(nonatomic,strong)NSMutableArray *photoArray;
@property(nonatomic,assign)CGRect viewFrame;
@property(nonatomic,assign)NSInteger style;
//用于操作返回的后的相册页
@property(nonatomic,strong)NSMutableArray *assests;
@property(nonatomic,strong)NSMutableArray *groundStringArray;
@property(nonatomic,strong)id<BigPhotoViewDelegate> delegate;
@property(nonatomic,strong)id<BigPhotoViewDelegate2> delegate2;

@property(nonatomic,assign)NSInteger photoNumber;
-(id)initWithGroupData:(NSMutableArray *)groupData;
//-(void)addBiggerAnimation;
@end

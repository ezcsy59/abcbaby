//
//  VedioCustomImage.h
//  ALAssetDemo
//
//  Created by Kingsley on 13-6-25.
//  Copyright (c) 2013年 kingsley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface VedioCustomImage : UIImage
{
    ALAsset* asset;
    BOOL isSelected;
}
@property(strong,nonatomic)ALAsset* asset;
@property(strong,nonatomic)NSURL *photoUrl;
@property(strong,nonatomic)NSString *groundDataString;
@property BOOL isSelected;
@end

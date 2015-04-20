//
//  VedioAssetCollectionCell.h
//  ALAssetDemo
//
//  Created by Kingsley on 13-6-25.
//  Copyright (c) 2013年 kingsley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VedioAssetCollectionCell : UITableViewCell
{
    NSInteger num4Row;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier numForRow:(NSInteger)num;
@end

//
//  HJHMyTextField.h
//  shuoshuo
//
//  Created by huang on 2/28/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJHMyTextField : UITextField
@property(nonatomic,assign)CGFloat fromRight;
- (id)initWithFrame:(CGRect)frame andFromRight:(CGFloat)fromRight;
@end

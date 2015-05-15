//
//  HJHMyButton.m
//  shuoshuo
//
//  Created by huang on 2/28/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "HJHMyButton.h"

@implementation HJHMyButton
-(id)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.exclusiveTouch = YES;
    }
    return self;
}

-(id)init{
    if (self == [super init]) {
        self.exclusiveTouch = YES;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super initWithCoder:aDecoder]) {
        self.exclusiveTouch = YES;
    }
    return self;
}


//按钮文字图片垂直
//-(void)layoutSubviews {
//    [super layoutSubviews];
//    
//    // Center image
//    CGPoint center = self.imageView.center;
//    center.x = self.frame.size.width/2;
//    center.y = self.imageView.frame.size.height/2;
//    self.imageView.center = center;
//    
//    //Center text
//    CGRect newFrame = [self titleLabel].frame;
//    newFrame.origin.x = 0;
//    newFrame.origin.y = self.imageView.frame.size.height + 5;
//    newFrame.size.width = self.frame.size.width;
//    
//    self.titleLabel.frame = newFrame;
//    self.titleLabel.textAlignment = UITextAlignmentCenter;
//}
@end

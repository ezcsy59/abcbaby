//
//  HJHMyTextField.m
//  shuoshuo
//
//  Created by huang on 2/28/14.
//  Copyright (c) 2014 huang. All rights reserved.
//

#import "HJHMyTextField.h"

@interface HJHMyTextField ()

@end

@implementation HJHMyTextField
-(CGRect)placeholderRectForBounds:(CGRect)bounds{
    return CGRectMake(bounds.origin.x + self.fromRight, bounds.origin.y, bounds.size.width - self.fromRight, bounds.size.height);
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectMake(bounds.origin.x + self.fromRight, bounds.origin.y, bounds.size.width - self.fromRight-17, bounds.size.height);
}

-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectMake(bounds.origin.x + self.fromRight, bounds.origin.y, bounds.size.width - self.fromRight, bounds.size.height);
}

- (id)initWithFrame:(CGRect)frame andFromRight:(CGFloat)fromRight
{
    self = [super initWithFrame:frame];
    if (self)
	{
        self.backgroundColor = [UIColor whiteColor];
        self.fromRight = fromRight;
    }
    return self;
}
@end

//
//  HJHKeyBoardViewChange.m
//  youziyuan
//
//  Created by Dickson on 14-4-13.
//  Copyright (c) 2014年 huang. All rights reserved.
//

#import "HJHKeyBoardViewChange.h"

@implementation HJHKeyBoardViewChange
+(void)keybaordShowChange:(UIView*)view{
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationCurve:7];
    [UIView setAnimationDuration:0.25];
    if (iPhone5) {
        CGRect r = view.frame;
        r.origin.y -= 216;
        view.frame = r;
    }else{
        CGRect r = view.frame;
        r.origin.y -= 183;
        view.frame = r;
    }
    
    [UIView commitAnimations];
}
+(void)keybaordHideChange:(UIView*)view{
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationCurve:7];
    [UIView setAnimationDuration:0.25];
    if (iPhone5) {
        CGRect r = view.frame;
        r.origin.y += 216;
        view.frame = r;
    }else{
        CGRect r = view.frame;
        r.origin.y += 183;
        view.frame = r;
    }
    
    [UIView commitAnimations];
}
@end

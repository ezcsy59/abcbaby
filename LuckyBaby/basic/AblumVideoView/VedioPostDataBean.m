//
//  VedioPostDataBean.m
//  xiaozhan
//
//  Created by huang on 12/3/13.
//  Copyright (c) 2013 Kugou. All rights reserved.
//

#import "VedioPostDataBean.h"

@implementation VedioPostDataBean
-(id)init{
    if (self = [super init]) {
        self.photoArray = [NSMutableArray array];
        self.style = 0;
        self.photo = nil;
        self.text = @"";
    }
    return self;
}
@end

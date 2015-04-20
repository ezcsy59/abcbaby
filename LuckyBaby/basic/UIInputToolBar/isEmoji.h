//
//  isEmoji.h
//  TalkBar
//
//  Created by huang on 11/17/13.
//  Copyright (c) 2013 dengyilei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface isEmoji : NSObject

+(BOOL)isContainsEmoji:(NSString *)string;
+ (BOOL)supportEmoji;
+ (void)valueControl:(BOOL)open;

@end

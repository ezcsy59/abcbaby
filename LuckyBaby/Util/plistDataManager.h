//
//  plistDataManager.h
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-1.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface plistDataManager : NSObject
+(void)writeData:(NSDictionary*)dic withKey:(NSString*)key;
+(NSDictionary *)getDataWithKey:(NSString*)key;
@end

//
//  DictionaryStringTool.h
//  huang
//
//  Created by AA on 14-1-9.
//  Copyright (c) 2014年 huang. All rights reserved.
//  字典解析类

#import <Foundation/Foundation.h>

@interface DictionaryStringTool : NSDictionary

+ (id)stringFromDictionary:(NSDictionary *)dic forKey:(NSString *)key;


+(NSMutableDictionary*)changeDictionaryTyle:(NSDictionary*)dic;
@end

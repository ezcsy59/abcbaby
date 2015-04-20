//
//  stringChange.h
//  TalkBar
//
//  Created by huang on 11/7/13.
//  Copyright (c) 2013 huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface stringChange : NSObject
+(CGFloat)makeStringWedth:(NSString*)str andSize:(CGFloat)size andLenth:(float)oldwedth;

+(CGFloat)makeStringHeight:(NSString*)str andSize:(CGFloat)size andLenth:(float)oldwedth;

+(CGFloat)makeStringMaxWidth:(NSString*)str andSize:(CGFloat)size andLenth:(float)lenth;

+(int)makeStringLine:(NSString*)str andSize:(CGFloat)size andwedth:(float)oldwedth;

+(NSMutableArray*)subStringToArray:(NSString*)stringH :(NSString*)stringE;
@end

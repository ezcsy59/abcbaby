//
//  groupOfArray.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-1.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "groupOfArray.h"

@implementation groupOfArray
+(NSArray *)getRelationArray{
    NSArray *relationA = @[@"妈妈",@"爸爸",@"外婆",@"外公",@"奶奶",@"爷爷",@"姥姥",@"姥爷",@"伯母",@"伯父",@"姑妈",@"姑父",@"姨妈",@"姨父",@"舅妈",@"舅舅",@"婶婶",@"干妈",@"干爸",@"哥哥",@"姐姐",@"弟弟",@"妹妹"];
    return relationA;
}

+(NSArray *)bloodArray{
    NSArray *relationA = @[@"A",@"B",@"O",@"AB"];
    return relationA;
}
@end

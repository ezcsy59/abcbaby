//
//  isEmoji.m
//  TalkBar
//
//  Created by huang on 11/17/13.
//  Copyright (c) 2013 dengyilei. All rights reserved.
//

#import "isEmoji.h"

@implementation isEmoji
+(BOOL)isContainsEmoji:(NSString *)string {
    
    NSString *str = @"➋➌➍➎➏➐➑➒";
    if ([str rangeOfString:string].length > 0) {
        return NO;
    }
    
    __block BOOL isEomji = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop){
         
         
         
         const unichar hs = [substring characterAtIndex:0];
         
         // surrogate pair
         
         if (0xd800 <= hs && hs <= 0xdbff) {
             
             if (substring.length > 1) {
                 
                 const unichar ls = [substring characterAtIndex:1];
                 
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     
                     isEomji = YES;
                     
                 }
                 
             }
             
         } else if (substring.length > 1) {
             
             const unichar ls = [substring characterAtIndex:1];
             
             if (ls == 0x20e3) {
                 
                 isEomji = YES;
                 
             }
             
             
             
         } else {
             
             // non surrogate
             
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 
                 isEomji = YES;
                 
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 
                 isEomji = YES;
                 
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 
                 isEomji = YES;
                 
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 
                 isEomji = YES;
                 
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 
                 isEomji = YES;
                 
             }
             
         }
         
     }];
    
    
    
    return isEomji;
    
}


+ (BOOL)supportEmoji
{
    BOOL hasEmoji = NO;
#define kPreferencesPlistPath @"/private/var/mobile/Library/Preferences/com.apple.Preferences.plist"
    NSDictionary *plistDict = [[NSDictionary alloc] initWithContentsOfFile:kPreferencesPlistPath];
    NSNumber *emojiValue = [plistDict objectForKey:@"KeyboardEmojiEverywhere"];
    if (emojiValue)     //value might not exist yet
        hasEmoji = YES;
    else
        hasEmoji = NO;
    return hasEmoji;
}

+ (void)valueControl:(BOOL)open
{
    
#define kPreferencesPlistPath @"/private/var/mobile/Library/Preferences/com.apple.Preferences.plist"
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:kPreferencesPlistPath];
    [plistDict setValue:[NSNumber numberWithBool:open] forKey:@"KeyboardEmojiEverywhere"];
    [plistDict writeToFile:kPreferencesPlistPath atomically:NO];
}
@end

//
//  emojiStringChange.m
//  LuckyBaby
//
//  Created by 黄嘉宏 on 15-4-12.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "emojiStringChange.h"

@implementation emojiStringChange
+(NSString *)emojiStringChange:(NSString*)string{
    if ([string containsString:@"[呲牙]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[呲牙]" withString:@"[p0]"];
    }
    if ([string containsString:@"[调皮]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[调皮]" withString:@"[p1]"];
    }
    if ([string containsString:@"[流汗]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[流汗]" withString:@"[p2]"];
    }
    if ([string containsString:@"[偷笑]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[偷笑]" withString:@"[p3]"];
    }
    if ([string containsString:@"[再见]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[再见]" withString:@"[p4]"];
    }
    if ([string containsString:@"[敲打]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[敲打]" withString:@"[p5]"];
    }
    if ([string containsString:@"[擦汗]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[擦汗]" withString:@"[p6]"];
    }
    if ([string containsString:@"[猪头]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[猪头]" withString:@"[p7]"];
    }
    if ([string containsString:@"[玫瑰]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[玫瑰]" withString:@"[p8]"];
    }
    if ([string containsString:@"[流泪]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[流泪]" withString:@"[p9]"];
    }
    if ([string containsString:@"[大哭]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[大哭]" withString:@"[p10]"];
    }
    if ([string containsString:@"[嘘]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[嘘]" withString:@"[p11]"];
    }
    if ([string containsString:@"[酷]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[酷]" withString:@"[p12]"];
    }
    if ([string containsString:@"[抓狂]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[抓狂]" withString:@"[p13]"];
    }
    if ([string containsString:@"[委屈]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[委屈]" withString:@"[p14]"];
    }
    if ([string containsString:@"[便便]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[便便]" withString:@"[p15]"];
    }
    if ([string containsString:@"[炸弹]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[炸弹]" withString:@"[p16]"];
    }
    if ([string containsString:@"[菜刀]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[菜刀]" withString:@"[p17]"];
    }
    if ([string containsString:@"[可爱]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[可爱]" withString:@"[p18]"];
    }
    if ([string containsString:@"[色]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[色]" withString:@"[p19]"];
    }
    if ([string containsString:@"[害羞]"]) {
        [string stringByReplacingOccurrencesOfString:@"[害羞]" withString:@"[p20]"];
    }
    if ([string containsString:@"[得意]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[得意]" withString:@"[p21]"];
    }
    if ([string containsString:@"[吐]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[吐]" withString:@"[p22]"];
    }
    if ([string containsString:@"[微笑]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[微笑]" withString:@"[p23]"];
    }
    if ([string containsString:@"[发怒]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[发怒]" withString:@"[p24]"];
    }
    if ([string containsString:@"[尴尬]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[尴尬]" withString:@"[p25]"];
    }
    if ([string containsString:@"[惊恐]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[惊恐]" withString:@"[p26]"];
    }
    if ([string containsString:@"[冷汗]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[冷汗]" withString:@"[p27]"];
    }
    if ([string containsString:@"[爱心]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[爱心]" withString:@"[p28]"];
    }
    if ([string containsString:@"[示爱]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[示爱]" withString:@"[p29]"];
    }
    if ([string containsString:@"[白眼]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[白眼]" withString:@"[p30]"];
    }
    if ([string containsString:@"[傲慢]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[傲慢]" withString:@"[p31]"];
    }
    if ([string containsString:@"[难过]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[难过]" withString:@"[p32]"];
    }
    if ([string containsString:@"[惊讶]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[惊讶]" withString:@"[p33]"];
    }
    if ([string containsString:@"[疑问]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[疑问]" withString:@"[p107]"];
    }
    if ([string containsString:@"[睡]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[睡]" withString:@"[p35]"];
    }
    if ([string containsString:@"[亲亲]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[亲亲]" withString:@"[p36]"];
    }
    if ([string containsString:@"[憨笑]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[憨笑]" withString:@"[p37]"];
    }
    if ([string containsString:@"[爱情]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[爱情]" withString:@"[p38]"];
    }
    if ([string containsString:@"[衰]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[衰]" withString:@"[p39]"];
    }
    if ([string containsString:@"[撇嘴]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[撇嘴]" withString:@"[p40]"];
    }
    if ([string containsString:@"[阴险]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[阴险]" withString:@"[p41]"];
    }
    if ([string containsString:@"[奋斗]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[奋斗]" withString:@"[p42]"];
    }
    if ([string containsString:@"[发呆]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[发呆]" withString:@"[p43]"];
    }
    if ([string containsString:@"[右哼哼]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[右哼哼]" withString:@"[p44]"];
    }
    if ([string containsString:@"[拥抱]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[拥抱]" withString:@"[p45]"];
    }
    if ([string containsString:@"[坏笑]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[坏笑]" withString:@"[p46]"];
    }
    if ([string containsString:@"[飞吻]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[飞吻]" withString:@"[p47]"];
    }
    if ([string containsString:@"[鄙视]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[鄙视]" withString:@"[p48]"];
    }
    if ([string containsString:@"[晕]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[晕]" withString:@"[p49]"];
    }
    if ([string containsString:@"[大兵]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[大兵]" withString:@"[p50]"];
    }
    if ([string containsString:@"[可怜]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[可怜]" withString:@"[p51]"];
    }
    if ([string containsString:@"[强]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[强]" withString:@"[p52]"];
    }
    if ([string containsString:@"[弱]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[弱]" withString:@"[p53]"];
    }
    if ([string containsString:@"[握手]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[握手]" withString:@"[p54]"];
    }
    if ([string containsString:@"[胜利]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[胜利]" withString:@"[p55]"];
    }
    if ([string containsString:@"[抱拳]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[抱拳]" withString:@"[p56]"];
    }
    if ([string containsString:@"[凋谢]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[凋谢]" withString:@"[p57]"];
    }
    if ([string containsString:@"[饭]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[饭]" withString:@"[p58]"];
    }
    if ([string containsString:@"[蛋糕]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[蛋糕]" withString:@"[p59]"];
    }
    if ([string containsString:@"[西瓜]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[西瓜]" withString:@"[p60]"];
    }
    if ([string containsString:@"[啤酒]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[啤酒]" withString:@"[p61]"];
    }
    if ([string containsString:@"[飘虫]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[飘虫]" withString:@"[p62]"];
    }
    if ([string containsString:@"[勾引]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[勾引]" withString:@"[p63]"];
    }
    if ([string containsString:@"[OK]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[OK]" withString:@"[p64]"];
    }
    if ([string containsString:@"[爱你]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[爱你]" withString:@"[p65]"];
    }
    if ([string containsString:@"[咖啡]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[咖啡]" withString:@"[p66]"];
    }
    if ([string containsString:@"[钱]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[钱]" withString:@"[p67]"];
    }
    if ([string containsString:@"[月亮]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[月亮]" withString:@"[p68]"];
    }
    if ([string containsString:@"[美女]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[美女]" withString:@"[p108]"];
    }
    if ([string containsString:@"[刀]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[刀]" withString:@"[p70]"];
    }
    if ([string containsString:@"[发抖]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[发抖]" withString:@"[p71]"];
    }
    if ([string containsString:@"[差劲]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[差劲]" withString:@"[p72]"];
    }
    if ([string containsString:@"[拳头]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[拳头]" withString:@"[p73]"];
    }
    if ([string containsString:@"[心碎]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[心碎]" withString:@"[p74]"];
    }
    if ([string containsString:@"[太阳]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[太阳]" withString:@"[p75]"];
    }
    if ([string containsString:@"[礼物]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[礼物]" withString:@"[p76]"];
    }
    if ([string containsString:@"[足球]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[足球]" withString:@"[p77]"];
    }
    if ([string containsString:@"[骷髅]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[骷髅]" withString:@"[p78]"];
    }
    if ([string containsString:@"[挥手]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[挥手]" withString:@"[p79]"];
    }
    if ([string containsString:@"[闪电]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[闪电]" withString:@"[p80]"];
    }
    if ([string containsString:@"[饥饿]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[饥饿]" withString:@"[p81]"];
    }
    if ([string containsString:@"[困]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[困]" withString:@"[p82]"];
    }
    if ([string containsString:@"[咒骂]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[咒骂]" withString:@"[p83]"];
    }
    if ([string containsString:@"[折磨]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[折磨]" withString:@"[p84]"];
    }
    if ([string containsString:@"[抠鼻]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[抠鼻]" withString:@"[p85]"];
    }
    if ([string containsString:@"[鼓掌]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[鼓掌]" withString:@"[p86]"];
    }
    if ([string containsString:@"[糗大了]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[糗大了]" withString:@"[p87]"];
    }
    if ([string containsString:@"[左哼哼]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[左哼哼]" withString:@"[p88]"];
    }
    if ([string containsString:@"[哈欠]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[哈欠]" withString:@"[p89]"];
    }
    if ([string containsString:@"[快哭了]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[快哭了]" withString:@"[p90]"];
    }
    if ([string containsString:@"[吓]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[吓]" withString:@"[p91]"];
    }
    if ([string containsString:@"[篮球]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[篮球]" withString:@"[p92]"];
    }
    if ([string containsString:@"[乒乓球]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[乒乓球]" withString:@"[p93]"];
    }
    if ([string containsString:@"[NO]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[NO]" withString:@"[p94]"];
    }
    if ([string containsString:@"[跳跳]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[跳跳]" withString:@"[p95]"];
    }
    if ([string containsString:@"[怄火]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[怄火]" withString:@"[p96]"];
    }
    if ([string containsString:@"[转圈]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[转圈]" withString:@"[p97]"];
    }
    if ([string containsString:@"[磕头]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[磕头]" withString:@"[p98]"];
    }
    if ([string containsString:@"[回头]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[回头]" withString:@"[p99]"];
    }
    if ([string containsString:@"[跳绳]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[跳绳]" withString:@"[p100]"];
    }
    if ([string containsString:@"[激动]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[激动]" withString:@"[p101]"];
    }
    if ([string containsString:@"[街舞]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[街舞]" withString:@"[p102]"];
    }
    if ([string containsString:@"[献吻]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[献吻]" withString:@"[p103]"];
    }
    if ([string containsString:@"[左太极]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[左太极]" withString:@"[p109]"];
    }
    if ([string containsString:@"[右太极]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[右太极]" withString:@"[p105]"];
    }
    if ([string containsString:@"[闭嘴]"]) {
       string = [string stringByReplacingOccurrencesOfString:@"[闭嘴]" withString:@"[p106]"];
    }
    
    return string;
}


+(NSString *)emojiStringChange2:(NSString*)string{
    if ([string containsString:@"[p0]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p0]" withString:@"[呲牙]"];
    }
    if ([string containsString:@"[p1]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p1]" withString:@"[调皮]"];
    }
    if ([string containsString:@"[p2]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p2]" withString:@"[流汗]"];
    }
    if ([string containsString:@"[p3]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p3]" withString:@"[偷笑]"];
    }
    if ([string containsString:@"[p4]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p4]" withString:@"[再见]"];
    }
    if ([string containsString:@"[p5]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p5]" withString:@"[敲打]"];
    }
    if ([string containsString:@"[p6]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p6]" withString:@"[擦汗]"];
    }
    if ([string containsString:@"[p7]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p7]" withString:@"[猪头]"];
    }
    if ([string containsString:@"[p8]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p8]" withString:@"[玫瑰]"];
    }
    if ([string containsString:@"[p9]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p9]" withString:@"[流泪]"];
    }
    if ([string containsString:@"[p10]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p10]" withString:@"[大哭]"];
    }
    if ([string containsString:@"[p11]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p11]" withString:@"[嘘]"];
    }
    if ([string containsString:@"[p12]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p12]" withString:@"[酷]"];
    }
    if ([string containsString:@"[p13]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p13]" withString:@"[抓狂]"];
    }
    if ([string containsString:@"[p14]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p14]" withString:@"[委屈]"];
    }
    if ([string containsString:@"[p15]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p15]" withString:@"[便便]"];
    }
    if ([string containsString:@"[p16]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p16]" withString:@"[炸弹]"];
    }
    if ([string containsString:@"[p17]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p17]" withString:@"[菜刀]"];
    }
    if ([string containsString:@"[p18]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p18]" withString:@"[可爱]"];
    }
    if ([string containsString:@"[p19]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p19]" withString:@"[色]"];
    }
    if ([string containsString:@"[p20]"]) {
        [string stringByReplacingOccurrencesOfString:@"[p20]" withString:@"[害羞]"];
    }
    if ([string containsString:@"[p21]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p21]" withString:@"[得意]"];
    }
    if ([string containsString:@"[p22]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p22]" withString:@"[吐]"];
    }
    if ([string containsString:@"[p23]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p23]" withString:@"[微笑]"];
    }
    if ([string containsString:@"[p24]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p24]" withString:@"[发怒]"];
    }
    if ([string containsString:@"[p25]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p25]" withString:@"[尴尬]"];
    }
    if ([string containsString:@"[p26]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p26]" withString:@"[惊恐]"];
    }
    if ([string containsString:@"[p27]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p27]" withString:@"[冷汗]"];
    }
    if ([string containsString:@"[p28]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p28]" withString:@"[爱心]"];
    }
    if ([string containsString:@"[p29]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p29]" withString:@"[示爱]"];
    }
    if ([string containsString:@"[p30]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p30]" withString:@"[白眼]"];
    }
    if ([string containsString:@"[p31]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p31]" withString:@"[傲慢]"];
    }
    if ([string containsString:@"[p32]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p32]" withString:@"[难过]"];
    }
    if ([string containsString:@"[p33]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p33]" withString:@"[惊讶]"];
    }
    if ([string containsString:@"[p107]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p107]" withString:@"[疑问]"];
    }
    if ([string containsString:@"[p35]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p35]" withString:@"[睡]"];
    }
    if ([string containsString:@"[p36]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p36]" withString:@"[亲亲]"];
    }
    if ([string containsString:@"[p37]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p37]" withString:@"[憨笑]"];
    }
    if ([string containsString:@"[p38]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p38]" withString:@"[爱情]"];
    }
    if ([string containsString:@"[p39]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p39]" withString:@"[衰]"];
    }
    if ([string containsString:@"[p40]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p40]" withString:@"[撇嘴]"];
    }
    if ([string containsString:@"[p41]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p41]" withString:@"[阴险]"];
    }
    if ([string containsString:@"[p42]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p42]" withString:@"[奋斗]"];
    }
    if ([string containsString:@"[p43]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p43]" withString:@"[发呆]"];
    }
    if ([string containsString:@"[p44]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p44]" withString:@"[右哼哼]"];
    }
    if ([string containsString:@"[p45]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p45]" withString:@"[拥抱]"];
    }
    if ([string containsString:@"[p46]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p46]" withString:@"[坏笑]"];
    }
    if ([string containsString:@"[p47]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p47]" withString:@"[飞吻]"];
    }
    if ([string containsString:@"[p48]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p48]" withString:@"[鄙视]"];
    }
    if ([string containsString:@"[p49]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p49]" withString:@"[晕]"];
    }
    if ([string containsString:@"[p50]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p50]" withString:@"[大兵]"];
    }
    if ([string containsString:@"[p51]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p51]" withString:@"[可怜]"];
    }
    if ([string containsString:@"[p52]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p52]" withString:@"[强]"];
    }
    if ([string containsString:@"[p53]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p53]" withString:@"[弱]"];
    }
    if ([string containsString:@"[p54]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p54]" withString:@"[握手]"];
    }
    if ([string containsString:@"[p55]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p55]" withString:@"[胜利]"];
    }
    if ([string containsString:@"[p56]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p56]" withString:@"[抱拳]"];
    }
    if ([string containsString:@"[p57]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p57]" withString:@"[凋谢]"];
    }
    if ([string containsString:@"[p58]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p58]" withString:@"[饭]"];
    }
    if ([string containsString:@"[p59]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p59]" withString:@"[蛋糕]"];
    }
    if ([string containsString:@"[p60]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p60]" withString:@"[西瓜]"];
    }
    if ([string containsString:@"[p61]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p61]" withString:@"[啤酒]"];
    }
    if ([string containsString:@"[p62]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p62]" withString:@"[飘虫]"];
    }
    if ([string containsString:@"[p63]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p63]" withString:@"[勾引]"];
    }
    if ([string containsString:@"[p64]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p64]" withString:@"[OK]"];
    }
    if ([string containsString:@"[p65]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p65]" withString:@"[爱你]"];
    }
    if ([string containsString:@"[p66]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p66]" withString:@"[咖啡]"];
    }
    if ([string containsString:@"[p67]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p67]" withString:@"[钱]"];
    }
    if ([string containsString:@"[p68]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p68]" withString:@"[月亮]"];
    }
    if ([string containsString:@"[p108]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p108]" withString:@"[美女]"];
    }
    if ([string containsString:@"[p70]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p70]" withString:@"[刀]"];
    }
    if ([string containsString:@"[p71]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p71]" withString:@"[发抖]"];
    }
    if ([string containsString:@"[p72]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p72]" withString:@"[差劲]"];
    }
    if ([string containsString:@"[p73]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p73]" withString:@"[拳头]"];
    }
    if ([string containsString:@"[p74]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p74]" withString:@"[心碎]"];
    }
    if ([string containsString:@"[p75]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p75]" withString:@"[太阳]"];
    }
    if ([string containsString:@"[p76]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p76]" withString:@"[礼物]"];
    }
    if ([string containsString:@"[p77]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p77]" withString:@"[足球]"];
    }
    if ([string containsString:@"[p78]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p78]" withString:@"[骷髅]"];
    }
    if ([string containsString:@"[p79]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p79]" withString:@"[挥手]"];
    }
    if ([string containsString:@"[p80]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p80]" withString:@"[闪电]"];
    }
    if ([string containsString:@"[p81]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p81]" withString:@"[饥饿]"];
    }
    if ([string containsString:@"[p82]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p82]" withString:@"[困]"];
    }
    if ([string containsString:@"[p83]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p83]" withString:@"[咒骂]"];
    }
    if ([string containsString:@"[p84]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p84]" withString:@"[折磨]"];
    }
    if ([string containsString:@"[p85]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p85]" withString:@"[抠鼻]"];
    }
    if ([string containsString:@"[p86]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p86]" withString:@"[鼓掌]"];
    }
    if ([string containsString:@"[p87]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p87]" withString:@"[糗大了]"];
    }
    if ([string containsString:@"[p88]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p88]" withString:@"[左哼哼]"];
    }
    if ([string containsString:@"[p89]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p89]" withString:@"[哈欠]"];
    }
    if ([string containsString:@"[p90]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p90]" withString:@"[快哭了]"];
    }
    if ([string containsString:@"[p91]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p91]" withString:@"[吓]"];
    }
    if ([string containsString:@"[p92]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p92]" withString:@"[篮球]"];
    }
    if ([string containsString:@"[p93]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p93]" withString:@"[乒乓球]"];
    }
    if ([string containsString:@"[p94]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p94]" withString:@"[NO]"];
    }
    if ([string containsString:@"[p95]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p95]" withString:@"[跳跳]"];
    }
    if ([string containsString:@"[p96]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p96]" withString:@"[怄火]"];
    }
    if ([string containsString:@"[p97]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p97]" withString:@"[转圈]"];
    }
    if ([string containsString:@"[p98]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p98]" withString:@"[磕头]"];
    }
    if ([string containsString:@"[p99]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p99]" withString:@"[回头]"];
    }
    if ([string containsString:@"[p100]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p100]" withString:@"[跳绳]"];
    }
    if ([string containsString:@"[p101]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p101]" withString:@"[激动]"];
    }
    if ([string containsString:@"[p102]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p102]" withString:@"[街舞]"];
    }
    if ([string containsString:@"[p103]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p103]" withString:@"[献吻]"];
    }
    if ([string containsString:@"[p109]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p109]" withString:@"[左太极]"];
    }
    if ([string containsString:@"[p105]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p105]" withString:@"[右太极]"];
    }
    if ([string containsString:@"[p106]"]) {
        string = [string stringByReplacingOccurrencesOfString:@"[p106]" withString:@"[闭嘴]"];
    }
    
    return string;
}

@end

//
//  CommonUtil.m
//  TalkBar
//
//  Created by huang on 13-8-2.
//  Copyright (c) 2013年 huang. All rights reserved.
//

#import "CommonUtil.h"
#import "ISO8601DateFormatter.h"
//#import <QuartzCore/QuartzCore.h>
#import "ColorEx.h"
//#import <AVFoundation/AVFoundation.h>
@implementation CommonUtil


// 计算从1970到现在的时间
+(long long)getTimeSince1970
{
    //    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //    NSInteger interval = [zone secondsFromGMTForDate:[NSDate date]];
    //
    //    //nslog(@"%d", interval);
    //    NSDate *localDate = [[NSDate date]dateByAddingTimeInterval:interval];
    
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSince1970];
    
    return timeInterval;
}



+(NSString *)convertDateFormate:(long long)date{
    
   
    NSString* result;
    long long curr = (long long)[[NSDate date]timeIntervalSince1970];
    NSString* dateDay = [CommonUtil stringWithDateFormat:SimpleDay FromDate:[NSDate dateWithTimeIntervalSince1970:date]];
    NSString* currDay = [CommonUtil stringWithDateFormat:SimpleDay FromDate:[NSDate dateWithTimeIntervalSince1970:curr]];
    NSTimeInterval now = date-curr;
    NSTimeInterval offset = now*-1;
    
    if (offset<0) {
        return result=Justnow;
    }
    if ((long)offset<aHour) {
        if (![dateDay isEqualToString:currDay]) {
            result = Yesterday;
        }else if ((long)(offset/aMinute)<1) {
            result = Justnow;
        }else{
            result = MinuteFormate((long)(offset/aMinute));
        }
    }else if((long)offset<aDay){
        if (![dateDay isEqualToString:currDay]) {
            result = Yesterday;
        }else if ((long)(offset/aHour)<=1) {
            result = HourFormate((long)1);
        }else result = HourFormate((long)(offset/aHour));
    }else if((long)offset<aMonth){
//        if ((long)(offset/aDay)>=1&&(long)(offset/aDay)<2) {
//            result = Yesterday;
//        }
       // else result = DayFormate((long)(offset/aDay)-1);
        
        NSDate* server = [CommonUtil dateWithStringFormat:SimpleDateToDay FromDate:[CommonUtil stringWithDateFormat:SimpleDateToDay FromDate:[NSDate dateWithTimeIntervalSince1970:date]]];
       // NSLog(@"server:%f",[server timeIntervalSince1970]);
        NSDate* now = [CommonUtil dateWithStringFormat:SimpleDateToDay FromDate:[CommonUtil stringWithDateFormat:SimpleDateToDay FromDate:[NSDate dateWithTimeIntervalSince1970:curr]]];
        //NSLog(@"now:%@",now);
        NSTimeInterval now1 = (long long)[server timeIntervalSince1970]-(long long)[now timeIntervalSince1970];
        NSTimeInterval offset = now1*-1;
        if ((long)(offset/aDay)>=1&&(long)(offset/aDay)<2) {
            result = Yesterday;
        }else if((long)(offset/aDay)>=2&&(long)(offset/aDay)<3){
            result = BeforeDay;
        }else result = DayFormate((long)(offset/aDay));
        
    }else{
        result = [CommonUtil stringWithDateFormat:SimpleDateToDay FromDate:[NSDate dateWithTimeIntervalSince1970:date]];
    }
   // NSLog(@"offset:%ld,%@,%lld",(long)offset,result,date);
    return result;
}

+(NSString*)stringWithDateFormat:(NSString*)dateFormat FromDate:(NSDate*)date{
    
    
    //设置时区 locale 确保能在真机上显示
    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    NSDateFormatter* formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:dateFormat];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    [formatter setTimeZone:localzone];
    //时区修复
   // NSTimeInterval timeZoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMT];
   // NSDate* newDate = [date dateByAddingTimeInterval:-timeZoneOffset];
    
    NSString* formattedString = [formatter stringFromDate:date];


    return formattedString;
}

+(NSDate*)dateWithStringFormat:(NSString*)dateFormat FromDate:(NSString*)date{
    //设置时区 locale 确保能在真机上显示
    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    NSDateFormatter* formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:dateFormat];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    [formatter setTimeZone:localzone];
    //时区修复
    NSTimeInterval timeZoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMT];
   
    NSDate* newDate = [[formatter dateFromString:date] dateByAddingTimeInterval:timeZoneOffset];
   // NSString* formattedString = [formatter stringFromDate:newDate];
    
    
    return newDate;
}

//计算iSO标准时间

+(NSInteger)convertTime:(NSString*)timeString
{
    ISO8601DateFormatter *isoFormatter = [[ISO8601DateFormatter alloc] init];
    NSDate* andTime = [isoFormatter dateFromString:timeString];
    int time = [andTime timeIntervalSince1970];
    return time;
    
}

+(NSString *)convertTimeDate:(NSString *)timeString{

    ISO8601DateFormatter *isoFormatter = [[ISO8601DateFormatter alloc] init];
    NSDate* andTime = [isoFormatter dateFromString:timeString];
    long long timeNum = [andTime timeIntervalSince1970];
    
    return [CommonUtil convertDateFormate:timeNum];
}

////计算内嵌时间
//+(NSInteger)conVertInternalTime:(NSString*)internalTimeStirng
//{
//    NSDateFormatter* df=[[NSDateFormatter alloc] init];
//    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss ‘CST’"];
////    NSLocale *locale=[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
////    [df setLocale:locale];
//    NSDate *date=[df dateFromString:internalTimeStirng];
//    return [date timeIntervalSince1970];
//}

+(void)navigationPushWithAnimation:(UIViewController*)vc
{
//    RootViewController* root = (RootViewController*)getCurrentRootController;
//    //[self doNavigationPushAnimation:root.rootNav];
//    [root.rootNav pushViewController:vc animated:YES];
}

+(void)doNavigationPushAnimation:(UINavigationController*)nav
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.30;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.removedOnCompletion = YES;
    [nav.view.layer addAnimation:transition forKey:@"pushright"];
    //[nav popViewControllerAnimated:NO];
}

+(void)doNavigationPopAnimation:(UINavigationController*)nav
{
    
    CATransition* transition = [CATransition animation];
    transition.duration = .3;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    transition.removedOnCompletion = YES;
    [nav.view.layer addAnimation:transition forKey:@"popLeft"];
    //[nav popViewControllerAnimated:NO];
}

//导航栏向上弹出动画
+(void)navigationPushTopWithAnimation:(UIViewController*)vc
{
//    RootViewController* root = (RootViewController*)getCurrentRootController;
//    [self doNavigationPushTopAnimation:root.rootNav];
//    [root.rootNav pushViewController:vc animated:NO];
}

+(void)doNavigationPushTopAnimation:(UINavigationController*)nav
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.30;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    transition.removedOnCompletion = YES;
    [nav.view.layer addAnimation:transition forKey:@""];
    //[nav popViewControllerAnimated:NO];
}

//导航栏向下弹出动画
+(void)navigationPushDownWithAnimation:(UIViewController*)vc
{
//    RootViewController* root = (RootViewController*)getCurrentRootController;
//    [self doNavigationPushDownAnimation:root.rootNav];
//    [root.rootNav popViewControllerAnimated:NO];
}

+(void)doNavigationPushDownAnimation:(UINavigationController*)nav
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.30;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    transition.removedOnCompletion = YES;
    [nav.view.layer addAnimation:transition forKey:@""];
    //[nav popViewControllerAnimated:NO];
}

//+(UITextField *)getTextField:(CGRect)thisframe andTextFieldKeyBordType:(TextFieldType)KeyBordType andTextFieldReturnKeyType:(TextFieldType)ReturnKeyType
//{
//    UITextField *tempTextField = [[UITextField alloc] init];
//    tempTextField.frame = thisframe;
//    tempTextField.borderStyle = UITextBorderStyleNone;
//    
//    tempTextField.clipsToBounds = YES;
//    tempTextField.autocorrectionType = UITextAutocorrectionTypeYes;//启用自动提示更正功能
//    tempTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    tempTextField.font = [UIFont KGFontWithSize:13.f];
//    tempTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    [tempTextField setTextColor:[UIColor colorWithHexString:@"#7d7d7d"]];
//    
//    //键盘类型
//    if (KeyBordType == TextFieldKeyType_UIKeyboardTypeNumberPad)
//    {
//        tempTextField.keyboardType = UIKeyboardTypeNumberPad;
//    }
//    
//    if (KeyBordType == TextFieldKeyType_UIKeyboardTypeDefault)
//    {
//        tempTextField.keyboardType = UIKeyboardTypeDefault;
//    }
//    
//    if (KeyBordType == TextFieldType_UIKeyboardTypeEmailAddress)
//    {
//        tempTextField.keyboardType = UIKeyboardTypeDefault;
//        tempTextField.font = [UIFont KGFontWithSize:13.0f];
//    }
//    
//    if (KeyBordType == TextFieldType_UIKeyboardTypePhonePad)
//    {
//        tempTextField.keyboardType = UIKeyboardTypePhonePad;
//        tempTextField.font = [UIFont KGFontWithSize:13.0f];
//    }
//    
//    //返回键类型
//    if (ReturnKeyType == TextFieldKeyType_UIReturnKeyNext)
//    {
//        tempTextField.returnKeyType = UIReturnKeyNext;//设置键盘完成按钮，相应的还有“Return”"Gｏ""Google"等
//    }
//    if (ReturnKeyType == TextFieldKeyType_UIReturnKeyDone)
//    {
//        tempTextField.returnKeyType = UIReturnKeyDone;//设置键盘完成按钮，相应的还有“Return”"Gｏ""Google"等
//    }
//    
//    return tempTextField;
//}
//
//#pragma mark 生成button
//+(UIButton *)getUIButtonWithFrame:(CGRect)thisFrame andTitle:(NSString *)title andBtnType:(BtnType)Type
//{
//    UIButton *tempBtn = [[UIButton alloc] initWithFrame:thisFrame];
//    [tempBtn setTitle:title forState:UIControlStateNormal];
//    [tempBtn setTitle:title forState:UIControlStateHighlighted];
//    if (Type == BtnType_LoginView_Registe)
//    {
//        [tempBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    }
//    else
//    {
//        [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    }
//    tempBtn.titleLabel.font = [UIFont KGFontWithSize:13];
//    return tempBtn;
//}
//

//AuthError
//用户登录验证失败	-1004
//AccountExist
//帐号已经存在(登录时用)	-1005
//CodeError
//验证码错误(登录时用)	-1006
//SendCodeError
//发送验证码失败(登录时用)	-1007
//PasswordError	登录时的密码不对(登录时用)	-1008
+(NSString *)getErroStringForErroCode:(int )erroCode
{
    switch (erroCode)
    {
        case -1001:
            //
            return @"该帐号未注册";
            break;
        case -1004:
            //
            return @"用户登录验证失败";
            break;
        case -1005:
            //
            return @"该帐号已存在";
            break;
        case -1006:
            //
            return @"验证码错误";
            break;
        case -1007:
            //
            return @"发送验证码失败";
            break;
        case -1008:
            //
            return @"登录密码错误";
            break;
        default:
            return @"请求错误";
            break;
    }
}


//# 动态图片缩略图分辨率
//(180, 120), (320, 213), (480, 320),
//# 头像缩略图分辨率
//(48, 48), (72, 72), (144, 144), (250, 250), (400, 400)

////根据用户keypath获取图片路径
//+(NSURL *)getImagePath:(NSString *)keyPath
//{
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/image/%@/144x144",serverFileAddress,keyPath]];
//    return url;
//}

//获取设备状态，是否插入耳机，如果插入耳机，则返回“YES" BY Leisure
+ (BOOL)isHeadphone
{
//    UInt32 propertySize = sizeof(CFStringRef);
//    CFStringRef state = nil;
//    AudioSessionGetProperty(kAudioSessionProperty_AudioRoute
//                            ,&propertySize,&state);
//    NSString* stateString =(NSString*)CFBridgingRelease(state);
    //return @"Headphone" or @"Speaker" and so on.
    //根据状态判断是否为耳机状态
//    if ([stateString isEqualToString:@"Headphone"] ||[stateString isEqualToString:@"HeadsetInOut"])
//    {
//        return YES;
//    }
//    else {
//        return NO;
//    }
    return NO;
}

@end

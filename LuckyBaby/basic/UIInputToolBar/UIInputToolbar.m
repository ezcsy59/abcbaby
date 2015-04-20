/*
 *  UIInputToolbar.m
 *
 *  Created by Brandon Hamilton on 2011/05/03.
 *  Copyright 2011 Brandon Hamilton.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 */

#import "UIInputToolbar.h"
#import "isEmoji.h"
#import "stringChange.h"

@implementation UIInputToolbar

@synthesize textView;
@synthesize inputButton;
@synthesize delegate2;


-(void)inputButtonPressed
{
    NSString* headerData= self.textView.text;
    headerData =[headerData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\x20" withString:@""];
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    self.textView.text = headerData;
    
    if ([delegate2 respondsToSelector:@selector(inputButtonPressed:)])
        {
            if (!([headerData isEqualToString:@""] && headerData.length < 2)) {
            [delegate2 inputButtonPressed:self.textView.text];
            }else{
                self.button.enabled = NO;
                [[NSNotificationCenter defaultCenter]postNotificationName:@"commentRequestErrorTipShow" object:nil];
            }
    }
    if ([delegate2 respondsToSelector:@selector(sendMessage:)])
    {
        if (!([headerData isEqualToString:@""] && headerData.length <2)) {
            [delegate2 sendMessage:self.textView.text];
        }else{
            self.button.enabled = NO;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"commentRequestErrorTipShow" object:nil];
        }
    }
    
    if ([delegate2 respondsToSelector:@selector(cancelButtonPressed)]) {
        [delegate2 cancelButtonPressed];
    }
    /* Remove the keyboard and clear the text */
    //[self.textView resignFirstResponder];
    [self.textView clearText];
}

-(void)clearText{
    self.messageRemember = self.textView.text;
    [self.textView clearText];
}

-(void)cancelButtonPressed
{
    if (self.cancelBtn.selected == YES) {
        self.cancelBtn.selected = NO;
    }else{
        self.cancelBtn.selected = YES;
    }
//    if ([delegate2 respondsToSelector:@selector(cancelButtonPressed)]) {
//        [delegate2 cancelButtonPressed];
//    }
    if (self.textView.internalTextView.isFirstResponder) {
        if (self.textView.internalTextView.emoticonsKeyboard) [self.textView.internalTextView switchToDefaultKeyboard];
        else [self.textView.internalTextView switchToEmoticonsKeyboard:[WUDemoKeyboardBuilder sharedEmoticonsKeyboard]];
    }else{
        [self.textView.internalTextView switchToEmoticonsKeyboard:[WUDemoKeyboardBuilder sharedEmoticonsKeyboard]];
        [self.textView.internalTextView becomeFirstResponder];
    }
}

//增添了一个传递文字初始化的字段
-(void)setupToolbar:(NSString *)buttonLabel andTextViewStr:(NSString*)str
{
    //self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    self.tintColor = [UIColor lightGrayColor];
    /* Create custom send button*/
    UIImage *buttonImage = [UIImage imageNamed:@"inputBar_sendBtn.png"];
    buttonImage  = [buttonImage stretchableImageWithLeftCapWidth:floorf(buttonImage.size.width/2) topCapHeight:floorf(buttonImage.size.height/2)];
    self.button = [[[UIButton alloc]init]autorelease];
    self.button.enabled = NO;
    self.button.frame = CGRectMake(265, 5, 49, 30);
    [self.button setTitle:@"发送" forState:UIControlStateNormal];
    self.button.titleLabel.font = [UIFont systemFontOfSize:15];
//    button.contentStretch          = CGRectMake(0.5, 0.5, 0, 0);
//    button.contentMode             = UIViewContentModeScaleToFill;
    [self.button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
//    [self.button setBackgroundImage:[UIImage imageNamed:@"inputBar_enterBtn.png"] forState:UIControlStateHighlighted];
//    [self.button setBackgroundImage:[UIImage imageNamed:@"Send_btn_Unreaction.png"] forState:UIControlStateDisabled];
    
//    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 6, 21, 18)];
//    [imageView setImage:[UIImage imageNamed:@"Save-fails.png"]];
//    [button addSubview:imageView];
    
    [self.button addTarget:self action:@selector(inputButtonPressed) forControlEvents:UIControlEventTouchDown];
    [self.button addTarget:self action:@selector(changeImage) forControlEvents:UIControlEventTouchDown];
    self.button.enabled = NO;
    //[self.button sizeToFit];
    
//    self.inputButton = [[UIBarButtonItem alloc] initWithCustomView:self.button];
    [self addSubview:self.button];
    //self.inputButton.customView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    /* Disable button initially */
    
    /* Create UIExpandingTextView input */
    self.textView = [[[UIExpandingTextView alloc] initWithFrame:CGRectMake(47, 7, 210, 50)]autorelease];
    //[self.textView setBackgroundColor:[UIColor redColor]];
    self.textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(4.0f, 0.0f, 5.0f, 0.0f);
    self.textView.delegate = self;
//    self.textView.returnKeyType = UIReturnKeyNext;
    //self.textView.placeholder = @"发表评论";
    [self addSubview:self.textView];
    
    /*Create cancel button*/
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBtn setFrame:CGRectMake(0, 7, 47, 27)];
    [self.cancelBtn setBackgroundColor:[UIColor clearColor]];
    [self.cancelBtn setImage:[UIImage imageNamed:@"smile.png"] forState:UIControlStateNormal];
    [self.cancelBtn setImage:[UIImage imageNamed:@"keyboard.png"] forState:UIControlStateSelected];
    [self.cancelBtn addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.cancelBtn];
    
//    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    //cancel.customView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    /* Right align the toolbar button */
//    UIBarButtonItem *flexItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
//    NSArray *items = [NSArray arrayWithObjects: cancel,flexItem, self.inputButton, nil];
//    [self setItems:items animated:NO];
    self.firstText = str;
}

-(id)initWithFrame:(CGRect)frame andTextViewStr:(NSString *)str
{
    if ((self = [super initWithFrame:frame])) {
        [self setupToolbar:@"Send" andTextViewStr:str];
    }
    return self;
}

-(id)initWithTextViewStr:(NSString*)str
{
    if ((self = [super init])) {
        [self setupToolbar:@"Send" andTextViewStr:str];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    /* Draw custon toolbar background */
    UIImage *backgroundImage = [UIImage imageNamed:@"inputBar_bgImg.jpg"];
    backgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:backgroundImage.size.width/2 topCapHeight:backgroundImage.size.height/2];
    [backgroundImage drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    //    CGRect i = self.inputButton.customView.frame;
    //    i.origin.y = self.frame.size.height - i.size.height - 7;
    //    self.inputButton.customView.frame = i;
}

- (void)dealloc
{
    [textView release];
    //[inputButton release];
    [super dealloc];
}


#pragma mark -
#pragma mark UIExpandingTextView delegate
-(BOOL)expandingTextView:(UIExpandingTextView *)expandingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    /* Enable/Disable the button */
    NSString* headerData= expandingTextView.text;
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *expandingText = headerData;
//    if (headerData.length != expandingTextView.text.length) {
//        expandingTextView.text = headerData;
//    }
    headerData =[headerData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\x20" withString:@""];
    NSLog(@"{%@},{%@},%d",headerData,expandingTextView.text,headerData.length);
    //用于处理屏蔽siri导致的sendBtn发送空字符窜
    NSLog(@"%d,%d",text.length,headerData.length);
    if ((headerData.length == 1 || [self getToInt:expandingText].length > [delegate2 maxLabelCount]|| headerData == nil) && text.length == 0) {
        self.button.enabled = NO;
    }else{
        self.button.enabled = YES;
    }
    return YES;
}

-(void)expandingTextView:(UIExpandingTextView *)expandingTextView willChangeHeight:(float)height
{
    /* Adjust the height of the toolbar when the input component expands */
    float diff = (textView.frame.size.height - height);
    [delegate2 changeLabelHeight:diff];
}

-(void)expandingTextViewDidChange:(UIExpandingTextView *)expandingTextView
{
    //针对IOS7屏蔽enmoji的方法
    NSLog(@"%d",expandingTextView.text.length);
    NSString *expandTextStr = expandingTextView.text;
    if (self.historyStr.length > 0 && expandTextStr.length > 0) {
        NSMutableArray *array = [stringChange subStringToArray:self.historyStr :expandTextStr];
        if ([array objectAtIndex:1]) {
            if ([isEmoji isContainsEmoji:[array objectAtIndex:1]])
            {
                expandTextStr = [NSString stringWithFormat:@"%@%@",[array objectAtIndex:0],[array objectAtIndex:2]];
            }else{
                expandTextStr = [NSString stringWithFormat:@"%@%@",[array objectAtIndex:0],[array objectAtIndex:1]];
            }
        }
    }
    if (![expandTextStr isEqualToString:expandingTextView.text]) {
        expandingTextView.text = expandTextStr;
    }
    self.historyStr = [NSString stringWithFormat:@"%@",expandingTextView.text];
    int maxLabelCount = [delegate2 maxLabelCount];
    NSLog(@"%d",[self getToInt:expandingTextView.text].length);
    if ([self getToInt:expandingTextView.text].length > maxLabelCount) {
        NSLog(@"%d",maxLabelCount-[self getToInt:expandingTextView.text].chnCount);
        NSLog(@"%d",expandingTextView.text.length);
        if (!iOS7) {
            expandingTextView.text = [expandingTextView.text substringToIndex:expandingTextView.text.length - 1];
        }
        NSLog(@"%@",expandingTextView.text);
    }
    //[delegate2 changeLabelCount:[self getToInt:expandingTextView.text]];
}

-(NSString *)trimString:(NSString *)target
{
    target = [target stringByReplacingOccurrencesOfString:@" " withString:@""];
    target = [target stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return target;
}

- (StringLength)getToInt:(NSString*)toBeString{
    StringLength strLength;
//    strLength.length = [toBeString length];
//    strLength.chnCount = 0;
//    
//    for (int i=0; i<[toBeString length]; ++i)
//    {
//        NSRange range = NSMakeRange(i, 1);
//        NSString *subString = [toBeString substringWithRange:range];
//        const char *cString = [subString UTF8String];
//        
//        if (strlen(cString) == 3)
//        {
//            strLength.length += 1;
//            strLength.chnCount++;
//        }
//    }
//    return strLength;
    strLength.length = toBeString.length;
    strLength.chnCount = 0;
    return strLength;
}
//-(void)expandingTextViewDidEndEditing:(UIExpandingTextView *)expandingTextView{
//    
//}

-(BOOL)expandingTextViewShouldBeginEditing:(UIExpandingTextView *)expandingTextView{
    //添加初始化字段
    //self.textView.text = self.firstText;
    return YES;
}

-(BOOL)expandingTextViewShouldReturn:(UIExpandingTextView *)expandingTextView{
    NSString* headerData= expandingTextView.text;
    headerData =[headerData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\x20" withString:@""];
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    expandingTextView.text = headerData;
    
    if (expandingTextView.text.length == 0) {
        return NO;
    }
    [self inputButtonPressed];
    return YES;
}

-(void)changeImage{
    [imageView setImage:[UIImage imageNamed:@"Save-Press.png"]];
}
@end

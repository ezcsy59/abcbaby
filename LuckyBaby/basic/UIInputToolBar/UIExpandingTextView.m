/*
 *  UIExpandingTextView.m
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

/*
 *  This class is based on growingTextView by Hans Pickaers
 *  http://www.hanspinckaers.com/multi-line-uitextview-similar-to-sms
 */

#import "UIExpandingTextView.h"
#import "isEmoji.h"

#define kTextInsetX 0
#define kTextInsetY 4
#define kTextInsetBottom 5

@implementation UIExpandingTextView

@synthesize internalTextView;
@synthesize delegate;

@synthesize text;
@synthesize font;
@synthesize textColor;
@synthesize textAlignment;
@synthesize selectedRange;
@synthesize editable;
@synthesize dataDetectorTypes;
@synthesize animateHeightChange;
@synthesize returnKeyType;
@synthesize textViewBackgroundImage;
@synthesize placeholder;
@synthesize cancelBtn;

- (void)setPlaceholder:(NSString *)placeholders
{
    placeholder = placeholders;
    placeholderLabel.text = placeholders;
}

- (int)minimumNumberOfLines
{
    return minimumNumberOfLines;
}

- (int)maximumNumberOfLines
{
    return maximumNumberOfLines;
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        forceSizeUpdate = NO;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		CGRect backgroundFrame = frame;
        backgroundFrame.origin.y = 0;
		backgroundFrame.origin.x = 0;
        
        CGRect textViewFrame = CGRectInset(backgroundFrame, kTextInsetX, kTextInsetY);
        
        /* Internal Text View component */
		internalTextView = [[UIExpandingTextViewInternal alloc] initWithFrame:textViewFrame];
        internalTextView.clipsToBounds   = YES;
		internalTextView.delegate        = self;
        internalTextView.delegate2       = self;
		internalTextView.font            = [UIFont systemFontOfSize:15.0];
		internalTextView.contentInset    = UIEdgeInsetsMake(-4,0,-4,0);
        internalTextView.text            = @"-";
		internalTextView.scrollEnabled   = NO;
        internalTextView.opaque          = NO;
        internalTextView.backgroundColor = [UIColor clearColor];
        internalTextView.showsHorizontalScrollIndicator = NO;
        [internalTextView sizeToFit];
        internalTextView.returnKeyType = UIReturnKeyDone;
        internalTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        /* set placeholder */
        placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,internalTextView.frame.size.height/2 -self.bounds.size.height/2,self.bounds.size.width - 20,self.bounds.size.height-5)];
        placeholderLabel.text = placeholder;
        placeholderLabel.font = internalTextView.font;
        placeholderLabel.backgroundColor = [UIColor clearColor];
        //placeholderLabel.lineBreakMode = NSLineBreakByCharWrapping;
        placeholderLabel.textColor = [UIColor grayColor];
        [internalTextView addSubview:placeholderLabel];
        
        /* Custom Background image */
        UIImage *image = [UIImage imageNamed:@"inputBar_enterBtn.png"];
        image = [image stretchableImageWithLeftCapWidth:25 topCapHeight:15];
        NSLog(@"%f,%f",image.size.width/4,image.size.height/4);
        textViewBackgroundImage = [[UIImageView alloc] initWithFrame:backgroundFrame];
        //[textViewBackgroundImage setBackgroundColor:[UIColor redColor]];
        textViewBackgroundImage.backgroundColor = [UIColor clearColor];
        //textViewBackgroundImage.contentMode = UIViewContentModeScaleAspectFit;
        //textViewBackgroundImage.contentStretch = CGRectMake(0.5, 0.5, 0, 0);
        [textViewBackgroundImage setImage:image];
        
        [self addSubview:textViewBackgroundImage];
        [self addSubview:internalTextView];
        
        /* Calculate the text view height */
		UIView *internal = (UIView*)[[internalTextView subviews] objectAtIndex:0];
		minimumHeight = internal.frame.size.height;
		[self setMinimumNumberOfLines:1];
		animateHeightChange = YES;
		internalTextView.text = @"";
		[self setMaximumNumberOfLines:2];
        [self sizeToFit];
        
//        //增加cancelBtn
//        cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(175, 6, 19, 19)];
//        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"cancle.png"] forState:UIControlStateNormal];
//        [self addSubview:cancelBtn];
    }
    return self;
}

-(void)sizeToFit
{
    CGRect r = self.frame;
    if ([self.text length] > 0)
    {
        /* No need to resize is text is not empty */
        return;
    }
    r.size.height = minimumHeight + kTextInsetBottom;
    r.origin.y = r.origin.y - kTextInsetBottom/2;
    self.frame = r;
}

-(void)setFrame:(CGRect)aframe
{
    CGRect backgroundFrame   = aframe;
    backgroundFrame.origin.y = 0;
    backgroundFrame.origin.x = 0;
    CGRect textViewFrame = CGRectInset(backgroundFrame, kTextInsetX, kTextInsetY);
	internalTextView.frame   = textViewFrame;
    backgroundFrame.size.height  -= 8;
    textViewBackgroundImage.frame = backgroundFrame;
    forceSizeUpdate = YES;
	[super setFrame:aframe];
}

-(void)clearText
{
    self.text = @"";
    [self textViewDidChange:self.internalTextView];
}

-(void)setMaximumNumberOfLines:(int)n
{
    BOOL didChange            = NO;
    NSString *saveText        = internalTextView.text;
    NSString *newText         = @"-";
    internalTextView.hidden   = YES;
    internalTextView.delegate = nil;
    for (int i = 2; i < n; ++i)
    {
        newText = [newText stringByAppendingString:@"\n|W|"];
    }
    internalTextView.text     = newText;
    didChange = (maximumHeight != internalTextView.contentSize.height);
    maximumHeight             = internalTextView.contentSize.height;
    maximumNumberOfLines      = n;
    internalTextView.text     = saveText;
    internalTextView.hidden   = NO;
    internalTextView.delegate = self;
    if (didChange) {
        forceSizeUpdate = YES;
        [self textViewDidChange:self.internalTextView];
    }
}

-(void)setMinimumNumberOfLines:(int)m
{
    NSString *saveText        = internalTextView.text;
    NSString *newText         = @"-";
    internalTextView.hidden   = YES;
    internalTextView.delegate = nil;
    for (int i = 2; i < m; ++i)
    {
        newText = [newText stringByAppendingString:@"\n|W|"];
    }
    internalTextView.text     = newText;
    minimumHeight             = internalTextView.contentSize.height;
    internalTextView.text     = saveText;
    internalTextView.hidden   = NO;
    internalTextView.delegate = self;
    [self sizeToFit];
    minimumNumberOfLines = m;
}



-(void)growDidStop
{
	if ([delegate respondsToSelector:@selector(expandingTextView:didChangeHeight:)])
    {
		[delegate expandingTextView:self didChangeHeight:self.frame.size.height];
	}
}

-(BOOL)resignFirstResponder
{
	[super resignFirstResponder];
	return [internalTextView resignFirstResponder];
}

- (void)dealloc
{
	[internalTextView release];
    [textViewBackgroundImage release];
    [placeholderLabel release];
    [super dealloc];
}

#pragma mark UITextView properties

-(void)setText:(NSString *)atext
{
	internalTextView.text = atext;
    [self performSelector:@selector(textViewDidChange:) withObject:internalTextView];
}

-(NSString*)text
{
	return internalTextView.text;
}

-(void)setFont:(UIFont *)afont
{
	internalTextView.font= afont;
	[self setMaximumNumberOfLines:maximumNumberOfLines];
	[self setMinimumNumberOfLines:minimumNumberOfLines];
}

-(UIFont *)font
{
	return internalTextView.font;
}

-(void)setTextColor:(UIColor *)color
{
	internalTextView.textColor = color;
}

-(UIColor*)textColor
{
	return internalTextView.textColor;
}

-(void)setTextAlignment:(UITextAlignment)aligment
{
	internalTextView.textAlignment = aligment;
}

-(UITextAlignment)textAlignment
{
	return internalTextView.textAlignment;
}

-(void)setSelectedRange:(NSRange)range
{
	internalTextView.selectedRange = range;
}

-(NSRange)selectedRange
{
	return internalTextView.selectedRange;
}

-(void)setEditable:(BOOL)beditable
{
	internalTextView.editable = beditable;
}

-(BOOL)isEditable
{
	return internalTextView.editable;
}

-(void)setReturnKeyType:(UIReturnKeyType)keyType
{
	internalTextView.returnKeyType = keyType;
}

-(UIReturnKeyType)returnKeyType
{
	return internalTextView.returnKeyType;
}

-(void)setDataDetectorTypes:(UIDataDetectorTypes)datadetector
{
	internalTextView.dataDetectorTypes = datadetector;
}

-(UIDataDetectorTypes)dataDetectorTypes
{
	return internalTextView.dataDetectorTypes;
}

- (BOOL)hasText
{
	return [internalTextView hasText];
}

- (void)scrollRangeToVisible:(NSRange)range
{
	[internalTextView scrollRangeToVisible:range];
}

#pragma mark -
#pragma mark UIExpandingTextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	if ([delegate respondsToSelector:@selector(expandingTextViewShouldBeginEditing:)])
    {
		return [delegate expandingTextViewShouldBeginEditing:self];
	}
    else
    {
		return YES;
	}
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
	if ([delegate respondsToSelector:@selector(expandingTextViewShouldEndEditing:)])
    {
		return [delegate expandingTextViewShouldEndEditing:self];
	}
    else
    {
		return YES;
	}
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
	if ([delegate respondsToSelector:@selector(expandingTextViewDidBeginEditing:)])
    {
		[delegate expandingTextViewDidBeginEditing:self];
	}
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
	if ([delegate respondsToSelector:@selector(expandingTextViewDidEndEditing:)])
    {
		[delegate expandingTextViewDidEndEditing:self];
	}
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)atext
{
    if ([atext isEqualToString:@"Expression_close"]) {
        if (textView.text.length > 0) {
            textView.text = [textView.text substringToIndex:textView.text.length-1];
        }
        return NO;
    }
	if(![textView hasText] && [atext isEqualToString:@""])
    {
        return NO;
	}
    
    if ([isEmoji isContainsEmoji:atext]) {
        return NO;
    }
    
    if ([[[UITextInputMode currentInputMode]primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
    
    //完成键功能
	if ([atext isEqualToString:@"\n"])
    {
        //[delegate inputButtonPressed];
		if ([delegate respondsToSelector:@selector(expandingTextViewShouldReturn:)])
        {
            if (textView.text.length > 0) {
                if (![delegate performSelector:@selector(expandingTextViewShouldReturn:) withObject:self])
                {
                    return YES;
                }else{
                    [textView resignFirstResponder];
                    return NO;
                }
            }
            else
            {
				[textView resignFirstResponder];
				return NO;
			}
		}
	}
    if ([delegate respondsToSelector:@selector(expandingTextView:shouldChangeTextInRange:replacementText:)]) {
        [delegate expandingTextView:(UIExpandingTextView*)textView shouldChangeTextInRange:range replacementText:atext];
    }
	return YES;
}


- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0) {
        
    }
    
    
    if(textView.text.length == 0)
        placeholderLabel.alpha = 1;
    else
        placeholderLabel.alpha = 0;
    
	NSInteger newHeight = internalTextView.contentSize.height;
    
    NSLog(@"&*&**&*&&*,%d",newHeight);
    
	if(newHeight < minimumHeight || !internalTextView.hasText)
    {
        newHeight = minimumHeight;
    }
    
	if (internalTextView.frame.size.height != newHeight + kTextInsetBottom || forceSizeUpdate)
	{
        forceSizeUpdate = NO;
        NSLog(@"%f,%d",internalTextView.frame.size.height,maximumNumberOfLines);
        if (newHeight > maximumHeight+ 15*maximumNumberOfLines + kTextInsetBottom && internalTextView.frame.size.height <= maximumHeight+ 15*maximumNumberOfLines + kTextInsetBottom)
        {
            newHeight = maximumHeight+ 15*maximumNumberOfLines + kTextInsetBottom;
        }
        
        NSLog(@"%d",maximumHeight);
        NSLog(@"%ld",(long)newHeight);
//		if (newHeight <= maximumHeight)
		{
			if(animateHeightChange)
            {
				[UIView beginAnimations:@"" context:nil];
				[UIView setAnimationDelegate:self];
				[UIView setAnimationDidStopSelector:@selector(growDidStop)];
				[UIView setAnimationBeginsFromCurrentState:YES];
			}
			
			if ([delegate respondsToSelector:@selector(expandingTextView:willChangeHeight:)])
            {
				[delegate expandingTextView:self willChangeHeight:(newHeight+kTextInsetBottom)];
			}
			
			/* Resize the frame */
			CGRect r = self.frame;
            NSLog(@"^^^*&&*,%d",newHeight);
			r.size.height = newHeight + kTextInsetBottom;
			self.frame = r;
			r.origin.y = 0;
			r.origin.x = 0;
            internalTextView.frame = CGRectInset(r, kTextInsetX, kTextInsetY);
            r.size.height -= 8;
            textViewBackgroundImage.frame = r;
            
			if(animateHeightChange)
            {
				[UIView commitAnimations];
			}
            else if ([delegate respondsToSelector:@selector(expandingTextView:didChangeHeight:)])
            {
                [delegate expandingTextView:self didChangeHeight:(newHeight+ kTextInsetBottom)];
            }
		}
		
		if (newHeight + kTextInsetBottom >= maximumHeight)
		{
            /* Enable vertical scrolling */
			if(!internalTextView.scrollEnabled)
            {
				internalTextView.scrollEnabled = YES;
				[internalTextView flashScrollIndicators];
			}
		}
        else
        {
            /* Disable vertical scrolling */
			internalTextView.scrollEnabled = NO;
		}
	}
	
	if ([delegate respondsToSelector:@selector(expandingTextViewDidChange:)])
    {
		[delegate expandingTextViewDidChange:self];
	}
}


- (void)textViewDidChangeSelection:(UITextView *)textView
{
	if ([delegate respondsToSelector:@selector(expandingTextViewDidChangeSelection:)])
    {
		[delegate expandingTextViewDidChangeSelection:self];
	}
}

-(void)changeTextView{
    if (iOS7) {
        [self textViewDidChange:internalTextView];
    }
}

@end

//
//  CLMView.m
//  DrawTest
//
//  Created by cocoa on 10-9-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CLMView.h"



#define K_PI 3.1415
#define KDGREED(x) ((x)  * K_PI * 2)


@implementation CLMView
@synthesize spaceHeight, scaleY;
@synthesize titleArr, valueArr, colorArr;


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.backgroundColor = [UIColor clearColor];
		
		spaceHeight = 0;
		scaleY = 1;
		
				
    }
    return self;
}


- (void)drawRect:(CGRect)rect 
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	//cgcontextsets
	
	//抗锯齿
	CGContextSetAllowsAntialiasing(context, TRUE);
	
//	int arr[5] = {20, 15, 35, 85 ,60};
	
	float sum = 0;
	
	
	for(int j=0;j< [valueArr count]; j++)
	{
		sum	 += [[valueArr objectAtIndex:j] floatValue];
	}
	
	
	CGContextMoveToPoint(context, 260, 230);
	
	float currentangel = 0;
	
	//饼图
	CGContextSaveGState(context);
	CGContextScaleCTM(context, 1.0, scaleY);

	currentangel = 0;
	
	for(int i = 0; i< [valueArr count]; i++)
	{

		float startAngle = KDGREED(currentangel);
		
		currentangel += [[valueArr objectAtIndex:i] floatValue] / sum;
		
		float endAngle = KDGREED(currentangel);
		
		
		//绘制上面的扇形
		CGContextMoveToPoint(context, 260, 230);
		
		[[colorArr objectAtIndex:i %  [valueArr count]] setFill];
		
		[[UIColor colorWithWhite:1.0 alpha:0.8] setStroke];
		
		CGContextAddArc(context, 260, 230, 60, startAngle, endAngle, 0);
		
		CGContextClosePath(context);
		CGContextDrawPath(context, kCGPathFill);
		
		
		
		//绘制侧面
		float starx = cos(startAngle) * 60  +260;
		float stary = sin(startAngle) * 60 + 230;
		
		float endx = cos(endAngle) * 60 + 260;
		float endy = sin(endAngle) * 60 + 230;
		
		//float starty1 = stary + spaceHeight;
		float endy1 = endy + spaceHeight;
		
		
		if(endAngle < K_PI)
		{
		}
		
		//只有弧度《 3.14 的才会画前面的厚度
		else if(startAngle < K_PI)
		{
			endAngle = K_PI;
			endx = 10;
			endy1 = 230+spaceHeight;
		}
		
		else
			break;
		 
		
		//CGContextSetBlendMode(context, kCGBlendModeMultiply);
		
		
		//绘制厚度
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathMoveToPoint(path, nil, starx, stary);
		CGPathAddArc(path, nil, 260, 230, 60, startAngle, endAngle, 0);
		CGPathAddLineToPoint(path, nil, endx, endy1);
		
		CGPathAddArc(path, nil, 260, 230 + spaceHeight, 60, endAngle, startAngle, 1);
		CGContextAddPath(context, path);
		
		[[colorArr objectAtIndex:i %  [valueArr count]] setFill];
		[[UIColor colorWithWhite:0.9 alpha:1.0] setStroke];
		
		CGContextDrawPath(context, kCGPathFill);
		
		[[UIColor colorWithWhite:0.1 alpha:0.4] setFill];
		CGContextAddPath(context, path);
		CGContextDrawPath(context, kCGPathFill);


			
		

	}
	
	
	
	//整体渐变
	CGFloat componets [] = {0.0, 0.0, 0.0, 0.5,0.0,0.0,0.0,0.1};
	
	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
	
	CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, componets, nil, 2);
	
	CGContextDrawRadialGradient(context, gradient, CGPointMake(260,230), 0, CGPointMake(260,230), 60, 0 );
	
	CFRelease(colorspace);
	CGGradientRelease(gradient);
	
	
	CGContextRestoreGState(context);
	
	//绘制文字
	
	for(int i = 0; i< [valueArr count]; i++)
	{
		float origionx = 60 ;
		float origiony = i * 30 + 170;
		
		[[colorArr objectAtIndex:i %  [valueArr count]] setFill];
		
		CGContextFillRect(context, CGRectMake(origionx, origiony, 20, 20));
		CGContextDrawPath(context, kCGPathFill);
		
		
		if(i< [titleArr count])
		{
			NSString *title = [ titleArr objectAtIndex:i];
			[title drawAtPoint:CGPointMake(origionx + 50, origiony) withFont:[UIFont systemFontOfSize:16]];
		}
		
	}
	
}


- (void)dealloc {
	[titleArr release];
	[valueArr release];
	[colorArr release];
    [super dealloc];
}


@end

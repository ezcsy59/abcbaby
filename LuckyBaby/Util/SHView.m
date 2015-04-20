//
//  SHView.m
//  SHLineGraphView
//
//  Created by 黄嘉宏 on 15-4-3.
//  Copyright (c) 2015年 grevolution. All rights reserved.
//

#import "SHView.h"
#import "SHLineGraphView.h"
#import "SHPlot.h"

@interface SHView ()
@property(nonatomic,strong)NSArray *xAxisValues;
@property(nonatomic,strong)NSArray *plottingValues;
@property(nonatomic,strong)NSArray *plottingPointsLabels;
@property(nonatomic,strong)NSArray *ageArray;
@property(nonatomic,assign)int style;
@property(nonatomic,assign)int topHeight;
@end

@implementation SHView

-(instancetype)initWithFrame:(CGRect)frame andxAxisValues:(NSMutableArray*)xAxisValues plottingValues:(NSMutableArray*)plottingValues plottingPointsLabels:(NSMutableArray*)plottingPointsLabels ageArray:(NSMutableArray *)ageArray topHeight:(int)topHeight{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        self.style = 0;
        self.xAxisValues = xAxisValues;
        self.plottingValues = plottingValues;
        self.plottingPointsLabels = plottingPointsLabels;
        self.ageArray = ageArray;
        self.topHeight = topHeight;
        [self setMainView];
    }
    return self;
}

-(void)setMainView{
    
    
    SHLineGraphView *_lineGraph = [[SHLineGraphView alloc] initWithFrame:CGRectMake(0, 0, 40 * self.ageArray.count, 400)];
    _lineGraph.userInteractionEnabled = NO;
    //set the main graph area theme attributes
    
    /**
     *  theme attributes dictionary. you can specify graph theme releated attributes in this dictionary. if this property is
     *  nil, then a default theme setting is applied to the graph.
     */
    NSDictionary *_themeAttributes = @{
                                       kXAxisLabelColorKey : [UIColor blackColor],
                                       kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:13],
                                       kYAxisLabelColorKey : [UIColor blackColor],
                                       kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:13],
                                       kYAxisLabelSideMarginsKey : @30,
                                       kPlotBackgroundLineColorKye : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4]
                                       };
    _lineGraph.themeAttributes = _themeAttributes;
    
    //set the line graph attributes
    
    /**
     *  the maximum y-value possible in the graph. make sure that the y-value is not in the plotting points is not greater
     *  then this number. otherwise the graph plotting will show wrong results.
     */
    _lineGraph.yAxisRange = @(self.topHeight);
    
    /**
     *  y-axis values are calculated according to the yAxisRange passed. so you do not have to pass the explicit labels for
     *  y-axis, but if you want to put any suffix to the calculated y-values, you can mention it here (e.g. K, M, Kg ...)
     */
    _lineGraph.yAxisSuffix = @"";
    
    /**
     *  an Array of dictionaries specifying the key/value pair where key is the object which will identify a particular
     *  x point on the x-axis line. and the value is the label which you want to show on x-axis against that point on x-axis.
     *  the keys are important here as when plotting the actual points on the graph, you will have to use the same key to
     *  specify the point value for that x-axis point.
     */
    _lineGraph.xAxisValues = self.ageArray;
    
    //create a new plot object that you want to draw on the `_lineGraph`

    SHPlot *_plot1 = [self addPoint:self.xAxisValues];
    [_lineGraph addPlot:_plot1];
    
    SHPlot *_plot2 = [self addPoint:self.plottingPointsLabels];
    [_lineGraph addPlot:_plot2];
    
    SHPlot *_plot3 = [self addPoint:self.plottingValues];
    [_lineGraph addPlot:_plot3];
    //You can as much `SHPlots` as you can in a `SHLineGraphView`
    
    [_lineGraph setupTheView];
    
    [self addSubview:_lineGraph];
    
    HJHMyImageView *imagev = [[HJHMyImageView alloc]init];
    if(self.topHeight == 140){
        imagev.frame = CGRectMake(62, 21, 0.5, 350);
    }
    else{
        imagev.frame = CGRectMake(54, 21, 0.5, 350);
    }
    imagev.backgroundColor = [UIColor colorWithHexString:@"666666"];
    [self addSubview:imagev];

}

-(SHPlot*)addPoint:(NSArray *)array{
    SHPlot *_plot1 = [[SHPlot alloc] init];
    
    //set the plot attributes
    
    /**
     *  Array of dictionaries, where the key is the same as the one which you specified in the `xAxisValues` in `SHLineGraphView`,
     *  the value is the number which will determine the point location along the y-axis line. make sure the values are not
     *  greater than the `yAxisRange` specified in `SHLineGraphView`.
     */
    _plot1.plottingValues = array;
    
    /**
     *  this is an optional array of `NSString` that specifies the labels to show on the particular points. when user clicks on
     *  a particular points, a popover view is shown and will show the particular label on for that point, that is specified
     *  in this array.
     */
    NSArray *arr = @[@"1", @"2", @"3", @"4", @"5", @"6" , @"7"];
    _plot1.plottingPointsLabels = arr;
    
    //set plot theme attributes
    
    /**
     *  the dictionary which you can use to assing the theme attributes of the plot. if this property is nil, a default theme
     *  is applied selected and the graph is plotted with those default settings.
     */
    NSDictionary *_plotThemeAttributes;
    if (self.style == 0) {
        _plotThemeAttributes = @{
                                   kPlotFillColorKey : [UIColor clearColor],
                                   kPlotStrokeWidthKey : @2,
                                   kPlotStrokeColorKey : [UIColor yellowColor],
                                   kPlotPointFillColorKey : [UIColor clearColor],
                                   kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:8]
                                   };
        self.style++;
    }
    else if (self.style == 1){
        _plotThemeAttributes = @{
                                 kPlotFillColorKey : [UIColor clearColor],
                                 kPlotStrokeWidthKey : @2,
                                 kPlotStrokeColorKey : [UIColor blueColor],
                                 kPlotPointFillColorKey : [UIColor clearColor],
                                 kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:8]
                                 };
        self.style++;
    }
    else if (self.style == 2){
        _plotThemeAttributes = @{
                                 kPlotFillColorKey : [UIColor clearColor],
                                 kPlotStrokeWidthKey : @2,
                                 kPlotStrokeColorKey : [UIColor greenColor],
                                 kPlotPointFillColorKey : [UIColor clearColor],
                                 kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:8]
                                 };
        self.style++;
    }
    
    _plot1.plotThemeAttributes = _plotThemeAttributes;
    
    return _plot1;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

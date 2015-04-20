//
//  baiduViewController.m
//  DemoForTesting
//
//  Created by 黄嘉宏 on 15-3-30.
//  Copyright (c) 2015年 黄嘉宏. All rights reserved.
//

#import "baiduViewController.h"

@interface baiduViewController ()<UIGestureRecognizerDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKMapViewDelegate,BMKPoiSearchDelegate,BMKCloudSearchDelegate,BMKPoiSearchDelegate>{
    BMKLocationService *_locService;
    BMKPointAnnotation *pointAnnotation;
    BMKGeoCodeSearch *_search;
    BMKMapView* _mapView;
    BMKCloudSearch *_cloudSearch;
    BMKPoiSearch *_poiSearch;

}
@property (nonatomic,strong)NSMutableArray *locationMessageArray;
@property (nonatomic,assign)int style;
@property (nonatomic,assign)CLLocationCoordinate2D currentCoor;
@end

@implementation baiduViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headNavView.titleLabel.text = @"周边幼儿园";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    
    [self addLeftReturnBtn];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self performSelector:@selector(beginDingWei) withObject:nil afterDelay:0];
    
//    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, [self getNavHight], 320, 480)];
//    
//    [_mapView setShowsUserLocation:YES];
//    [self.view addSubview:_mapView];
}

-(void)beginDingWei{
    if(!_mapView){
        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, [self getNavHight], 320, 480)];
    }
    [_mapView setShowsUserLocation:YES];
    self.locationMessageArray = [NSMutableArray array];
    
//    if (self.style == 1) {
        [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        //指定最小距离更新(米)，默认：kCLDistanceFilterNone
        [BMKLocationService setLocationDistanceFilter:10.f];
        
        //初始化BMKLocationService
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
        //启动LocationService
        [_locService startUserLocationService];
//    }
//    else{
//        BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
//        citySearchOption.pageIndex = 0;
//        citySearchOption.pageCapacity = 10;
//        citySearchOption.city= @"北京";
//        citySearchOption.keyword = @"故宫博物院";
//        BOOL flag = [_poiSearch poiSearchInCity:citySearchOption];
//        if(flag)
//        {
//            NSLog(@"城市内检索发送成功");
//        }
//        else
//        {
//            NSLog(@"城市内检索发送失败");
//        }
//    }
    [self.view addSubview:_mapView];
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    if (_mapView) {
        _mapView = nil;
    }
    if (_locService) {
        _locService = nil;
    }
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

#pragma mark - BMKMapViewDelegate

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"BMKMapView控件初始化完成" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
//    [alert show];
//    alert = nil;
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: click blank");
}

- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: double click");
}

#pragma mark - 添加自定义的手势（若不自定义手势，不需要下面的代码）

- (void)addCustomGestures {
    /*
     *注意：
     *添加自定义手势时，必须设置UIGestureRecognizer的属性cancelsTouchesInView 和 delaysTouchesEnded 为NO,
     *否则影响地图内部的手势处理
     */
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.delegate = self;
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.cancelsTouchesInView = NO;
    doubleTap.delaysTouchesEnded = NO;
    
    [self.view addGestureRecognizer:doubleTap];
    
    /*
     *注意：
     *添加自定义手势时，必须设置UIGestureRecognizer的属性cancelsTouchesInView 和 delaysTouchesEnded 为NO,
     *否则影响地图内部的手势处理
     */
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    singleTap.delaysTouchesEnded = NO;
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [self.view addGestureRecognizer:singleTap];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)theSingleTap {
    /*
     *do something
     */
    NSLog(@"my handleSingleTap");
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)theDoubleTap {
    /*
     *do something
     */
    NSLog(@"my handleDoubleTap");
}


#pragma mark mapViewDelegate 代理方法
- (void)mapView:(BMKMapView *)mapView1 didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    BMKCoordinateRegion region;
    region.center.latitude  = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta  = 0.2;
    region.span.longitudeDelta = 0.2;
    if (_mapView)
    {
        
        _mapView.region = region;
        NSLog(@"当前的坐标是: %f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    }
}

-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    BMKCoordinateRegion region;
    region.center.latitude  = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta  = 0.001;
    region.span.longitudeDelta = 0.001;
    if (_mapView)
    {
        //放入大头针
        pointAnnotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        self.currentCoor = coor;
        coor.latitude = userLocation.location.coordinate.latitude;
        coor.longitude = userLocation.location.coordinate.longitude;
        pointAnnotation.coordinate = coor;
        pointAnnotation.title = @"我在此处";
        [_mapView addAnnotation:pointAnnotation];
    
        _search = [[BMKGeoCodeSearch alloc]init];
        
        //反编码自己的位置获取街道
        BMKReverseGeoCodeOption *coorOption = [[BMKReverseGeoCodeOption alloc]init];
        coorOption.reverseGeoPoint = coor;
        BOOL flag = [_search reverseGeoCode:coorOption];
        _search.delegate=self;
        if (flag) {
            _mapView.showsUserLocation=NO;//不显示自己的位置
        }
        //*******************
        
        //
//        BMKCloudNearbySearchInfo *cloudNearbySearch = [[BMKCloudNearbySearchInfo alloc]init];
//        cloudNearbySearch.ak = @"8MHdEBMaHv5v3GTdC7X0zdsh";
//        cloudNearbySearch.geoTableId = 98915;
//        cloudNearbySearch.pageIndex = 0;
//        cloudNearbySearch.pageSize = 10;
//        cloudNearbySearch.location = [NSString stringWithFormat:@"%f,%f",coor.latitude,coor.longitude];
//        cloudNearbySearch.radius = 10;
//        cloudNearbySearch.keyword = @"街";
//        _cloudSearch = [[BMKCloudSearch alloc]init];
//        _cloudSearch.delegate = self;
//        BOOL flag2 = [_cloudSearch nearbySearchWithSearchInfo:cloudNearbySearch];
//        if(flag2)
//        {
//            NSLog(@"周边云检索发送成功");
//        }
//        else
//        {
//            NSLog(@"周边云检索发送失败");
//        }
        
        //初始化检索对象
        _poiSearch =[[BMKPoiSearch alloc]init];
        _poiSearch.delegate = self;
        //发起检索
        BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
        option.pageIndex = 0;
        option.pageCapacity = 10;
        option.location = coor;
        option.keyword = self.searchName;
        BOOL flag2 = [_poiSearch poiSearchNearBy:option];
        if(flag2)
        {
            NSLog(@"周边检索发送成功");
        }
        else  
        {  
            NSLog(@"周边检索发送失败");  
        }
        
//        pointAnnotation.subtitle = @"此Annotation可拖拽!";
        _mapView.region = region;
        NSLog(@"当前的坐标是: %f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    }
}

#pragma mark - BMKGeoCodeSearchDelegate
//反地理编码
-(void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error==0) {
        BMKPointAnnotation *item=[[BMKPointAnnotation alloc] init];
        NSLog(@"%@",result.address);
        
        
        //		CLGeocoder *geocoder=[[CLGeocoder alloc] init];
        //		CLGeocodeCompletionHandler handle=^(NSArray *palce,NSError *error){
        //			for (CLPlacemark *placemark in palce) {
        //				NSLog(@"%@1-%@2-%@3-%@4-%@5-%@6-%@7-%@8-%@9-%@10-%@11-%@12",placemark.name,placemark.thoroughfare,placemark.subThoroughfare,placemark.locality,placemark.subLocality,placemark.administrativeArea,placemark.postalCode,placemark.ISOcountryCode,placemark.country,placemark.inlandWater,placemark.ocean,placemark.areasOfInterest);
        //				break;
        //			}
        //		};
        //		CLLocation *loc = [[CLLocation alloc] initWithLatitude:locaLatitude longitude:locaLongitude];
        //		[geocoder reverseGeocodeLocation:loc completionHandler:handle];
    }
}

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    NSLog(@"%@",result.address);
}

-(void)didFailToLocateUserWithError:(NSError *)error{
    
}

#pragma mark - BMKCloudSearchDelegate
- (void)onGetCloudPoiResult:(NSArray*)poiResultList searchType:(int)type errorCode:(int)error{
    NSLog(@"%@",poiResultList);
}

- (void)onGetCloudPoiDetailResult:(BMKCloudPOIInfo*)poiDetailResult searchType:(int)type errorCode:(int)error{
    
}

- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode{
    // 清楚屏幕中所有的annotation
//    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//    [_mapView removeAnnotations:array];
    
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        for (int i = 0; i < poiResult.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [poiResult.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [self.locationMessageArray addObject:poi];
            [_mapView addAnnotation:item];
            if(i == 0)
            {
                //将第一个点的坐标移到屏幕中央
                _mapView.centerCoordinate = poi.pt;
            }
        }
    } else if (errorCode == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
    [self popBack];
}

- (void)onGetPoiDetailResult:(BMKPoiSearch*)searcher result:(BMKPoiDetailResult*)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//-(void)setAnimation:(id<BMKAnnotation>)Annotation{
//    // 生成重用标示identifier
//    NSString *AnnotationViewID = @"xidanMark";
//    
//    // 检查是否有重用的缓存
//    BMKAnnotationView* annotationView = [_mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
//    
//    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
//    if (annotationView == nil) {
//        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:Annotation reuseIdentifier:AnnotationViewID];
//        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
//        // 设置重天上掉下的效果(annotation)
//        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
//    }
//    
//    // 设置位置
//    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
//    annotationView.annotation = Annotation;
//    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
//    annotationView.canShowCallout = YES;
//    
//    // 设置是否可以拖拽
//    annotationView.draggable = NO;
//}

-(void)popBack{
    NSMutableArray *array = [NSMutableArray array];
    NSLog(@"%@",self.locationMessageArray);
    for (BMKPoiInfo *pInfo in self.locationMessageArray) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:pInfo.name forKey:@"locationName"];
        [dic setObject:pInfo.address forKey:@"locationAdress"];
        if([pInfo.phone isKindOfClass:[NSString class]]){
            [dic setObject:pInfo.phone forKey:@"locationPhone"];
        }
        [dic setObject:[NSString stringWithFormat:@"%f",pInfo.pt.latitude] forKey:@"locationX"];
        [dic setObject:[NSString stringWithFormat:@"%f",pInfo.pt.longitude] forKey:@"locationY"];
        BMKMapPoint mp1 = BMKMapPointForCoordinate(pInfo.pt);
        BMKMapPoint mp2 = BMKMapPointForCoordinate(self.currentCoor);
        CLLocationDistance dis = BMKMetersBetweenMapPoints(mp1, mp2);
        [dic setObject:[NSString stringWithFormat:@"%f",dis] forKey:@"locationDistance"];
        [array addObject:dic];
    }
    if([self.delegate2 respondsToSelector:@selector(popBackWith:)]){
        [self.delegate2 popBackWith:array];
    }
    
}
@end

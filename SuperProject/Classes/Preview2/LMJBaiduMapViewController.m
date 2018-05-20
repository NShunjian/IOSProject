//
//  LMJBaiduMapViewController.m
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "LMJBaiduMapViewController.h"
//百度地图定位
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BMKLocationkit/BMKLocationComponent.h>
//POI收索
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

// 百度地图
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

#import "LMJBaiduPointAnnotation.h"
#import "LMJCoordinateModel.h"
#import "LMJAnnotationCustomPopView.h"
#include <stdio.h>
#include <malloc/malloc.h>
#import "MyLocation.h"
@interface LMJBaiduMapViewController ()<BMKGeneralDelegate, BMKMapViewDelegate,BMKLocationManagerDelegate,BMKLocationServiceDelegate, BMKRouteSearchDelegate,BMKPoiSearchDelegate,CLLocationManagerDelegate>{
    BMKPoiSearch* _poisearch;
    int curPage;
}
/** <#digest#> */
@property (nonatomic, strong) BMKMapManager *mapManager;

/** <#digest#> */
@property (weak, nonatomic) BMKMapView *baiduMapView;

/** <#digest#> */
@property (nonatomic, strong) BMKLocationService *locationService;

/** <#digest#> */
@property (nonatomic, strong) BMKRouteSearch *routesearch;

/** <#digest#> */
@property (nonatomic, strong) NSMutableArray<LMJCoordinateModel *> *coordinates;

/** <#digest#> */
@property (assign, nonatomic) CLLocationCoordinate2D targetLocationCoordinate;

//位置管理者
@property (nonatomic, strong) CLLocationManager *mgr;

@property (nonatomic,assign)float coordinate_latitude;

@property(assign,nonatomic)float coordinate_longitude;

@property(nonatomic, strong) BMKLocationManager *locationManager;
@property(nonatomic, copy) BMKLocatingCompletionBlock completionBlock;
@end

@implementation LMJBaiduMapViewController


#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.fd_interactivePopDisabled = YES;
    //    LMJWeakSelf(self);
    //    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    //    BOOL ret = [self.mapManager start:LMJThirdSDKBaiduMapKey  generalDelegate:weakself];
    //    if (!ret) {
    //
    //        [MBProgressHUD showError:@"manager start failed!" ToView:self.view];
    //
    //    }
    //
    [self initBlock];
    [self initLocation];
    self.baiduMapView.showsUserLocation = YES;
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
//    displayParam.isRotateAngleValid = true;//跟随态旋转角度是否生效
    displayParam.isAccuracyCircleShow = false;//精度圈是否显示
//    displayParam.locationViewImgName= @"icon";//定位图标名称
//    displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
//    displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
    [_baiduMapView updateLocationViewWithParam:displayParam];
     [_baiduMapView setZoomLevel:13];
    _baiduMapView.isSelectedAnnotationViewFront = YES;
}

-(void)initLocation
{
    _locationManager = [[BMKLocationManager alloc] init];
    
    _locationManager.delegate = self;
    
    _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    _locationManager.allowsBackgroundLocationUpdates = YES;
    _locationManager.locationTimeout = 10;
    _locationManager.reGeocodeTimeout = 10;
    
}
- (void)addLocToMapView:(MyLocation *)loc
{
    
    [_baiduMapView updateLocationData:loc];
    [_baiduMapView setCenterCoordinate:loc.location.coordinate animated:YES];
}
-(void)initBlock
{
    __weak LMJBaiduMapViewController *weakSelf = self;
    self.completionBlock = ^(BMKLocation *location, BMKLocationNetworkState state, NSError *error)
    {
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
        }
        
        if (location.location) {//得到定位信息，添加annotation
            
            NSLog(@"LOC = %@",location.location);
            BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
            
            pointAnnotation.coordinate = location.location.coordinate;
            pointAnnotation.title = @"单次定位";
            if (location.rgcData) {
                pointAnnotation.subtitle = [location.rgcData description];
            } else {
                pointAnnotation.subtitle = @"rgc = null!";
            }
            
            NSLog(@"%@",[NSString stringWithFormat:@"当前位置信息： \n经纬度：%.6f,%.6f \n地址信息：%@ \n网络状态：%d  \n定位ID：%@",location.location.coordinate.latitude, location.location.coordinate.longitude, [location.rgcData description], state, location.locationID]);
        }
        LMJBaiduMapViewController *strongSelf = weakSelf;
        MyLocation * loc = [[MyLocation alloc]initWithLocation:location.location withHeading:nil];
        [strongSelf addLocToMapView:loc];
        /*
        ///国家名字属性
        @property(nonatomic, copy, readonly) NSString *country;
        
        ///国家编码属性
        @property(nonatomic, copy, readonly) NSString *countryCode;
        
        ///省份名字属性
        @property(nonatomic, copy, readonly) NSString *province;
        
        ///城市名字属性
        @property(nonatomic, copy, readonly) NSString *city;
        
        ///区名字属性
        @property(nonatomic, copy, readonly) NSString *district;
        
        ///街道名字属性
        @property(nonatomic, copy, readonly) NSString *street;
        
        ///街道号码属性
        @property(nonatomic, copy, readonly) NSString *streetNumber;
        
        ///城市编码属性
        @property(nonatomic, copy, readonly) NSString *cityCode;
        
        ///行政区划编码属性
        @property(nonatomic, copy, readonly) NSString *adCode;
        
        ///位置语义化结果的定位点在什么地方周围的描述信息
        @property(nonatomic, copy, readonly) NSString *locationDescribe;

        ///位置语义化结果的属性，该定位点周围的poi列表信息
        @property(nonatomic, retain, readonly) NSArray<BMKLocationPoi *> *poiList;
        */
        if (location.rgcData) {
            NSLog(@"rgc = %@",[location.rgcData description]);
            NSLog(@"country = %@",location.rgcData.country);
            NSLog(@"countryCode = %@",location.rgcData.countryCode);
            NSLog(@"province = %@",location.rgcData.province);
            NSLog(@"city = %@",location.rgcData.city);
            NSLog(@"district = %@",location.rgcData.district);
            NSLog(@"street = %@",location.rgcData.street);
            NSLog(@"streetNumber = %@",location.rgcData.streetNumber);
            NSLog(@"cityCode = %@",location.rgcData.cityCode);
            NSLog(@"adCode = %@",location.rgcData.adCode);
            NSLog(@"locationDescribe = %@",location.rgcData.locationDescribe);
            NSLog(@"poiList = %@",location.rgcData.poiList);
        }
        NSLog(@"netstate = %d",state);
    };
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.baiduMapView viewWillAppear];
    
    self.baiduMapView.delegate = self;
    self.locationService.delegate = self;
    self.routesearch.delegate = self;
    _poisearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    [_locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:self.completionBlock];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self addptAnnotations];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.baiduMapView viewWillDisappear];
    
    self.baiduMapView.delegate = nil;
    self.locationService.delegate = nil;
    self.routesearch.delegate = nil;
    _poisearch.delegate = nil; // 不用时，置nil
}
- (void)viewDidUnload {
    [super viewDidUnload];
    [_locationManager stopUpdatingLocation];
    _locationManager.delegate = nil;
}

- (void)addptAnnotations
{
    [self.coordinates enumerateObjectsUsingBlock:^(LMJCoordinateModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        LMJBaiduPointAnnotation *annotation = [[LMJBaiduPointAnnotation alloc] init];
        
        /** <#digest#> */
        //        @property (assign, nonatomic) NSInteger type; // <0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点 100:自定义视图点
        
        
        /** <#digest#> */
        //@property (assign, nonatomic) NSInteger degree;
        
        ///// 要显示的标题
        //@property (copy) NSString *title;
        ///// 要显示的副标题
        //@property (copy) NSString *subtitle;
        
        ///该点的坐标
        //@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
        
        annotation.type = 100;
        annotation.title = obj.coordinate_title;
        annotation.subtitle = obj.coordinate_comments;
        annotation.coordinate = CLLocationCoordinate2DMake(obj.coordinate_latitude, obj.coordinate_longitude);
        annotation.selectedIndex = idx;
        
        [self.baiduMapView addAnnotation:annotation];
        
        [self.baiduMapView selectAnnotation:annotation animated:YES];
        
        if (idx == 0) {
            
            BMKCoordinateRegion region;
            
            region.center = annotation.coordinate;
            
            region.span.latitudeDelta = 0.002;//数值越小地图放大越多
            region.span.longitudeDelta = 0.002;
            
            [self.baiduMapView setRegion:region];
        }
        
    }];
    
}


#pragma mark - BMKLocationServiceDelegate 定位
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
//{
//    [_baiduMapView updateLocationData:userLocation];
//    NSLog(@"heading is %@",userLocation.heading);
//}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    self.coordinate_latitude = userLocation.location.coordinate.latitude;
//    self.coordinate_longitude = userLocation.location.coordinate.longitude;
    BMKPlanNode *start = [[BMKPlanNode alloc] init];
    start.pt = userLocation.location.coordinate;
    
    
    BMKPlanNode *end = [[BMKPlanNode alloc] init];
    end.pt =  self.targetLocationCoordinate;
    
    
    BMKWalkingRoutePlanOption *walkingRoutePlanOption = [[BMKWalkingRoutePlanOption alloc] init];
    
    walkingRoutePlanOption.from = start;
    walkingRoutePlanOption.to = end;
    
    if ([self.routesearch walkingSearch:walkingRoutePlanOption]) {
        
        [self.locationService stopUserLocationService];
    }else
    {
        NSLog(@"检索失败");
        [self addptAnnotations];
    }
    
    
}


#pragma mark - BMKRouteSearchDelegate
- (void)onGetWalkingRouteResult:(BMKRouteSearch *)searcher result:(BMKWalkingRouteResult *)result errorCode:(BMKSearchErrorCode)error
{
    [self.baiduMapView removeAnnotations:self.baiduMapView.annotations];
    [self.baiduMapView removeOverlays:self.baiduMapView.overlays];
    
    if (error != BMK_SEARCH_NO_ERROR) {
        return;
    }
    
    BMKWalkingRouteLine *plan = (BMKWalkingRouteLine *)result.routes.firstObject;
    __block NSInteger planPointCounts = 0;
    
    [plan.steps enumerateObjectsUsingBlock:^(BMKWalkingStep  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == 0) {
            LMJBaiduPointAnnotation *annotation = [[LMJBaiduPointAnnotation alloc] init];
            annotation.selectedIndex = idx;
            annotation.type = 0;
            
            
            /** <#digest#> */
            //            @property (assign, nonatomic) NSInteger type; // <0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点 100:自定义视图点
            
            
            /** <#digest#> */
            //            @property (assign, nonatomic) NSInteger selectedIndex; // 当前的索引
            
            /** <#digest#> */
            //@property (assign, nonatomic) NSInteger degree;
            
            ///// 要显示的标题
            //@property (copy) NSString *title;
            ///// 要显示的副标题
            //@property (copy) NSString *subtitle;
            
            
            
            ///该点的坐标
            //@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
            
            annotation.title = @"起点";
            annotation.subtitle = @"起点副标题";
            annotation.coordinate = plan.starting.location;
            
            [self.baiduMapView addAnnotation:annotation];
            
        } else if (idx == plan.steps.count - 1) {
            
            LMJBaiduPointAnnotation *annotation = [[LMJBaiduPointAnnotation alloc] init];
            annotation.selectedIndex = idx;
            annotation.type = 1;
            
            
            /** <#digest#> */
            //            @property (assign, nonatomic) NSInteger type; // <0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点 100:自定义视图点
            
            
            /** <#digest#> */
            //            @property (assign, nonatomic) NSInteger selectedIndex; // 当前的索引
            
            /** <#digest#> */
            //@property (assign, nonatomic) NSInteger degree;
            
            
            
            ///// 要显示的标题
            //@property (copy) NSString *title;
            ///// 要显示的副标题
            //@property (copy) NSString *subtitle;
            
            
            
            ///该点的坐标
            //@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
            
            annotation.title = @"终点";
            annotation.subtitle = @"终点副标题";
            annotation.coordinate = plan.terminal.location;
            
            [self.baiduMapView addAnnotation:annotation];
            
        }
        
        
        planPointCounts += obj.pointsCount;
        
    }];
    
    
    [self addptAnnotations];
    
    // 设置起点, 为中心点
    BMKUserLocation *userLocation = self.locationService.userLocation;
    BMKCoordinateRegion region;
    region.center = userLocation.location.coordinate;
    region.span.latitudeDelta = 0.2;
    region.span.longitudeDelta = 0.2;
    [self.baiduMapView setRegion:region];
    
    
    BMKMapPoint *temppoints = (BMKMapPoint *)malloc(sizeof(BMKMapPoint) * planPointCounts);
    
    __block NSInteger j = 0;
    [plan.steps enumerateObjectsUsingBlock:^(BMKWalkingStep  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        for (NSInteger i = 0; i < obj.pointsCount; i++) {
            
            temppoints[j].x = obj.points[i].x;
            temppoints[j].y = obj.points[i].y;
            
            j++;
        }
        
    }];
    
    // 通过points构建BMKPolyline
    BMKPolyline *polyline = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
    
    
    [self.baiduMapView addOverlay:polyline];
    
    free(temppoints);
}





#pragma mark - BMKMapViewDelegate
/**
 *根据overlay生成对应的View
 *@param mapView 地图View
 *@param overlay 指定的overlay
 *@return 生成的覆盖物View
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        
        BMKPolylineView *polylineView = [[BMKPolylineView alloc] initWithPolyline:(BMKPolyline *)overlay];
        
        polylineView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
        polylineView.strokeColor = [[UIColor greenColor] colorWithAlphaComponent:0.4];
        polylineView.lineWidth = 2.0;
        return polylineView;
    }
    
    return nil;
}





#pragma mark - BMKMapViewDelegate mapView


/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    BMKAnnotationView *pinAnnotationView = nil;
    
    if ([annotation isKindOfClass:[LMJBaiduPointAnnotation class]]) {
        
        LMJBaiduPointAnnotation *myAnnotation = (LMJBaiduPointAnnotation *)annotation;
        
        pinAnnotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:[NSStringFromClass([BMKAnnotationView class]) stringByAppendingFormat:@"Type_%zd", myAnnotation.type]];
        
        
        
        //        test_BaiDu_centerPoint
        //        test_BaiDu_endPoint
        //        test_BaiDu_green
        //        test_BaiDu_red
        //        test_BaiDu_StartPoint
        //        test_BaiDu_wayPoint
        
        //        <0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点 100:自定义视图点
        
        NSInteger type = myAnnotation.type;
        
        switch (type) {
            case 0:
            {
                
                if (!pinAnnotationView) {
                    
                    pinAnnotationView = [[BMKAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:[NSStringFromClass([BMKAnnotationView class]) stringByAppendingFormat:@"Type_%zd", myAnnotation.type]];
                    pinAnnotationView.image = [UIImage imageNamed:@"test_BaiDu_StartPoint"];
                    pinAnnotationView.centerOffset = CGPointMake(0, -pinAnnotationView.lmj_height * 0.5);
                    pinAnnotationView.canShowCallout = YES;
                }
                
                
                pinAnnotationView.annotation = annotation;
            }
                break;
            case 1:
            {
                if (!pinAnnotationView) {
                    
                    pinAnnotationView = [[BMKAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:[NSStringFromClass([BMKAnnotationView class]) stringByAppendingFormat:@"Type_%zd", myAnnotation.type]];
                    
                    pinAnnotationView.image = [UIImage imageNamed:@"test_BaiDu_endPoint"];
                    pinAnnotationView.centerOffset = CGPointMake(0, -pinAnnotationView.lmj_height * 0.5);
                    pinAnnotationView.canShowCallout = YES;
                }
                
                pinAnnotationView.annotation = annotation;
            }
                break;
            default:
            {
                
                if (!pinAnnotationView) {
                    
                    pinAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:[NSStringFromClass([BMKAnnotationView class]) stringByAppendingFormat:@"Type_%zd", myAnnotation.type]];
                    
                    
                    pinAnnotationView.image = [UIImage imageNamed:@"test_BaiDu_green"];
                }
                
                
                NSInteger selectedIndex = myAnnotation.selectedIndex;
                
                LMJCoordinateModel *coordinateModel = self.coordinates[selectedIndex];
                
                LMJAnnotationCustomPopView *popView = [LMJAnnotationCustomPopView popView];
                popView.frame = CGRectMake(0, 0, 150, 100);
                
                // 设置数据
                popView.titleLabel.text = coordinateModel.coordinate_title;
                popView.subTitleLabel.text = coordinateModel.coordinate_comments;
                popView.gotoButton.tag = selectedIndex;
                [popView.gotoButton addTarget:self action:@selector(gotoThisPlaceAndLocation:) forControlEvents:UIControlEventTouchUpInside];
                
                
                // 添加自定义的 View
                BMKActionPaopaoView *paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:popView];
                
                paopaoView.frame = CGRectMake(0, 0, 150, 100);
                
                
                // 添加泡泡 View
                BMKPinAnnotationView *newPinAnnotationView = (BMKPinAnnotationView *)pinAnnotationView;
                
                [newPinAnnotationView.paopaoView  removeFromSuperview];
                newPinAnnotationView.paopaoView = nil;
                newPinAnnotationView.paopaoView = paopaoView;
                
                
                
            }
                break;
        }
        
    }
    
    return pinAnnotationView;
}


#pragma mark - 用户去到的位置
- (void)gotoThisPlaceAndLocation:(UIButton *)btn
{
    
    [self.locationService startUserLocationService];
    self.baiduMapView.showsUserLocation = NO;
    
    self.baiduMapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    
    self.baiduMapView.showsUserLocation = YES;
    
    LMJCoordinateModel *endModel = self.coordinates[btn.tag];
    
    
    self.targetLocationCoordinate = CLLocationCoordinate2DMake(endModel.coordinate_latitude, endModel.coordinate_longitude);
}


#pragma mark - BMKGeneralDelegate判断是否成功
/**
 *返回网络错误
 *@param iError 错误号
 */
- (void)onGetNetworkState:(int)iError
{
    if (iError) {
        [MBProgressHUD showError:@"返回网络错误" ToView:self.view];
    }
    
}

/**
 *返回授权验证错误
 *@param iError 错误号 : 为0时验证通过，具体参加BMKPermissionCheckResultCode
 */
- (void)onGetPermissionState:(int)iError
{
    
    if (iError) {
        
        [MBProgressHUD showError:@"返回授权验证错误" ToView:self.view];
    }
}
#pragma mark - getter


- (BMKMapManager *)mapManager
{
    if(_mapManager == nil)
    {
        _mapManager = [[BMKMapManager alloc] init];
        
        
    }
    return _mapManager;
}

- (BMKMapView *)baiduMapView
{
    if(_baiduMapView == nil)
    {
        
        BMKMapView *baiduMapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
        
        baiduMapView.mapType = BMKMapTypeStandard;
        
        baiduMapView.compassPosition = CGPointMake(kScreenWidth - 10 - baiduMapView.compassSize.width, 20);
        
        
        [self.view addSubview:baiduMapView];
        
        _baiduMapView = baiduMapView;
        
        [baiduMapView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.view);
            
        }];
        
    }
    return _baiduMapView;
}



- (BMKRouteSearch *)routesearch
{
    if(_routesearch == nil)
    {
        _routesearch = [[BMKRouteSearch alloc] init];
    }
    return _routesearch;
}

- (BMKLocationService *)locationService
{
    if(_locationService == nil)
    {
        _locationService = [[BMKLocationService alloc] init];
    }
    return _locationService;
}

- (NSMutableArray<LMJCoordinateModel *> *)coordinates
{
    if(_coordinates == nil)
    {
        _coordinates = [NSMutableArray array];
        
        LMJCoordinateModel *coordinate = [[LMJCoordinateModel alloc] init];
        
        
        //        //纬度
        //        @property(assign,nonatomic)float coordinate_latitude;
        //        //经度
        //        @property(assign,nonatomic)float coordinate_longitude;
        //        //业务标题
        //        @property(strong,nonatomic)NSString *coordinate_title;
        //        //业务注解
        //        @property(strong,nonatomic)NSString *coordinate_comments;
        //        //业务ID
        //        @property(assign,nonatomic)long coordinate_objID;
        
        coordinate.coordinate_latitude = 40.004773;
        //        40.004773;
        //        self.coordinate_latitude;
        coordinate.coordinate_longitude = 116.495340;
        //        116.495340;
        //        self.coordinate_longitude;
        coordinate.coordinate_title = @"我是第一个点";
        coordinate.coordinate_comments = @"我是第一个点的描述";
        coordinate.coordinate_objID = 1;
        
        
        [_coordinates addObject:coordinate];
        
        
        LMJCoordinateModel *coordinate1 = [[LMJCoordinateModel alloc] init];
        
        
        coordinate1.coordinate_latitude = 40.08837786972531;
        coordinate1.coordinate_longitude = 116.3658035640757;
        coordinate1.coordinate_title = @"我是第二个点";
        coordinate1.coordinate_comments = @"我是第二个点的描述";
        coordinate1.coordinate_objID = 2;
        
        
        
        [_coordinates addObject:coordinate1];
        
    }
    return _coordinates;
}


- (void)dealloc
{
    if (_baiduMapView) {
        _baiduMapView = nil;
    }
    if (_poisearch != nil) {
        _poisearch = nil;
    }
    _locationService = nil;
    _routesearch = nil;
    _locationManager = nil;
    _completionBlock = nil;
    
}

#pragma mark - LMJNavUIBaseViewControllerDataSource

- (UIColor *)lmjNavigationBackgroundColor:(LMJNavigationBar *)navigationBar
{
    return [UIColor clearColor];
}

- (BOOL)lmjNavigationIsHideBottomLine:(LMJNavigationBar *)navigationBar
{
    return YES;
}

- (NSMutableAttributedString *)lmjNavigationBarTitle:(LMJNavigationBar *)navigationBar
{
    return nil;
}

/** 导航条左边的按钮 */
- (UIImage *)lmjNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(LMJNavigationBar *)navigationBar
{
    [leftButton setImage:[UIImage imageNamed:@"NavgationBar_white_back"] forState:UIControlStateHighlighted];
    
    return [UIImage imageNamed:@"NavgationBar_blue_back"];
}

#pragma mark - LMJNavUIBaseViewControllerDelegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(LMJNavigationBar *)navigationBar
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end


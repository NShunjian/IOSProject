//
//  LMJBaiduPointAnnotation.h
//  SuperProject
//
//  Created by NShunJian on 2018/4/20.
//  Copyright © 2018年 superMan. All rights reserved.
//   

#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface LMJBaiduPointAnnotation : BMKPointAnnotation

/** <#digest#> */
@property (assign, nonatomic) NSInteger type; // <0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点 100:自定义视图点


/** <#digest#> */
@property (assign, nonatomic) NSInteger selectedIndex; // 当前的索引

/** <#digest#> */
//@property (assign, nonatomic) NSInteger degree;



///// 要显示的标题
//@property (copy) NSString *title;
///// 要显示的副标题
//@property (copy) NSString *subtitle;



///该点的坐标
//@property (nonatomic, assign) CLLocationCoordinate2D coordinate;


@end

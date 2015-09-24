//
//  MapViewController.h
//  MyMapTest2
//
//  Created by 杨 国俊 on 15/9/17.
//  Copyright (c) 2015年 sdzy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"
@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@property(strong,nonatomic)MKMapView *mapView;
@property(strong,nonatomic) NSArray *annotations;

@property(strong,nonatomic) CLLocationManager *locationManager;
@end

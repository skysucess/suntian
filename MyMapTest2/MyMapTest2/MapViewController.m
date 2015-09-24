//
//  MapViewController.m
//  MyMapTest2
//
//  Created by 杨 国俊 on 15/9/17.
//  Copyright (c) 2015年 sdzy. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView=[[MKMapView alloc] initWithFrame:self.view.frame];
    self.mapView.delegate=self;
//    [self.mapView setZoomEnabled:NO];
    [self.view addSubview:self.mapView];
    
    [self loadMap];
    
  //  NSLog(@"%@",self.annotations);
}

-(void)loadMap
{
    CLLocationCoordinate2D center=CLLocationCoordinate2DMake(32.465027,119.939618);
    if (self.annotations.count==1) {
        id<MKAnnotation> annotation =[self.annotations lastObject];
        center = annotation.coordinate;
    }
    
    MKCoordinateSpan span=MKCoordinateSpanMake(0.005, 0.005);
    MKCoordinateRegion region=MKCoordinateRegionMake(center, span);
    [self.mapView setRegion:region animated:YES];
    [self performSelector:@selector(showAnnotation) withObject:nil afterDelay:0.2];
}


-(void)showAnnotation
{
    if (self.annotations) {
       // NSLog(@"%ld",self.annotations.count);
        
        [self.mapView addAnnotations:self.annotations];
        if (self.annotations.count==1) {
            [self.mapView selectAnnotation:[self.annotations lastObject] animated:YES];
        }
        else if (self.annotations.count>1)
        {
            
//            NSLog(@"Location Services: %@", [CLLocationManager locationServicesEnabled]?@"YES":@"NO");
//            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
//            NSLog(@"Authorization: %d", status);
            
            if ([CLLocationManager locationServicesEnabled]) {
                self.mapView.showsUserLocation=YES;
            }
            
            CLLocationManager *locationManager=[[CLLocationManager alloc] init];
            locationManager.delegate=self;
            
            self.locationManager=locationManager;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            self.locationManager.distanceFilter = 500;

            [self.locationManager requestAlwaysAuthorization];
            [self.locationManager startUpdatingLocation];
        }
        
    }
}
#pragma mark  mapView delegate show annotationView
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    else if ([annotation isKindOfClass:[MyAnnotation class]])
    {
        static NSString  *identity =@"myannotation";
        MKAnnotationView *annotationView= [mapView dequeueReusableAnnotationViewWithIdentifier:identity];
        if (annotationView==nil) {
            annotationView=[[MKAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier:identity];
        }
        annotationView.annotation=annotation;
        
        MyAnnotation *myannotation=(MyAnnotation *)annotation;
        annotationView.image=myannotation.annotationImage;
        annotationView.canShowCallout=YES;
        return annotationView;
        
    }
    else
    {
        static NSString *identity=@"locationView";
        MKPinAnnotationView *annotationView=(MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identity];
        if (annotationView==nil) {
            annotationView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identity];
        }
        annotationView.annotation=annotation;
        
        if (self.annotations.count==1) {
            annotationView.animatesDrop=YES;
        }
        annotationView.canShowCallout=YES;
        return annotationView;
        
    }
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"location %f,%f",userLocation.coordinate.longitude,userLocation.coordinate.latitude);
//    设置移动的显示区域
    [self.mapView setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(0.001, 0.001)) animated:YES];
    [mapView selectAnnotation: userLocation animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma core location did updateloc
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (locations) {
        CLLocation *location=[locations lastObject];
        NSLog(@"%f",location.coordinate.longitude);
        self.mapView.showsUserLocation=YES;
    }
    [manager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
    [manager stopUpdatingLocation];
}

- (void)requestWhenInUseAuthorization
{
    NSLog(@"request");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

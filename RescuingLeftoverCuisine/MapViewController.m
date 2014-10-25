//
//  MapViewController.m
//  RescuingLeftoverCuisine
//
//  Created by Jamal E. Kharrat on 10/25/14.
//  Copyright (c) 2014 Jamal E. Kharrat. All rights reserved.
//

#import "MapViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "AnnotationDelegate.h"



@interface MapViewController () <CLLocationManagerDelegate,MKMapViewDelegate>{
    CLLocationManager *locationManager;
    CLLocation        *userLocation2;
    NSMutableArray    *locationsArray;
    int                x ;

}

@end

@implementation MapViewController




- (void)viewDidLoad {
    x = 0 ;
    [super viewDidLoad];
    [self getMaps];
    _placesMapView.delegate = self ;
    _placesMapView.showsUserLocation = YES ;
    
    locationManager = [[CLLocationManager alloc]init];
    [locationManager requestWhenInUseAuthorization];
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    
    locationManager.delegate = self ;
    
    locationManager.desiredAccuracy =  kCLLocationAccuracyBest;

    [locationManager startUpdatingLocation];

    // Do any additional setup after loading the view.
}


-(void)getMaps{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    
    [manager GET:@"http://ec2-54-204-111-5.compute-1.amazonaws.com:5000/request/getEvents" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *trip in responseObject) {
            CLLocationCoordinate2D coordinate = {[(NSString*)[trip valueForKey:@"restaurantLat"]doubleValue] , [(NSString*)[trip valueForKey:@"restaurantLng"]doubleValue] };
            MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
            point.title = [trip valueForKey:@"restaurantName"];
            point.coordinate = coordinate ;
            
            [_placesMapView addAnnotation:point];

            
            
//            [locationsArray addObject:restInfoDic];
        }
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}





#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        if (x == 0) {
            MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 1800, 1800);
            [_placesMapView setRegion:[_placesMapView regionThatFits:region] animated:YES];
        }
        x = 1 ;

        userLocation2 = currentLocation;
        NSLog(@"%@ \n %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude],[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude] );
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{


  
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

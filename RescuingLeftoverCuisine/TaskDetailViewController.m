//
//  TaskDetailViewController.m
//  RescuingLeftoverCuisine
//
//  Created by Jamal E. Kharrat on 10/24/14.
//  Copyright (c) 2014 Jamal E. Kharrat. All rights reserved.
//

#import "TaskDetailViewController.h"
#import "LocationTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
@interface TaskDetailViewController () <MKMapViewDelegate>{
    NSString *addressNew;
}

@end

@implementation TaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _locationMap.delegate = self;
    _locationMap.showsUserLocation = YES;
    _daskDetailsTableView.rowHeight = UITableViewAutomaticDimension;
    _daskDetailsTableView.estimatedRowHeight = 78.0;
    [self zoomInToMyLocation];
    [_daskDetailsTableView reloadData];
    
    // Do any additional setup after loading the view.
}




-(void)zoomInToMyLocation
{
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = [[_dictionaryPassed valueForKey:@"restaurantLat"]doubleValue];
    region.center.longitude = [[_dictionaryPassed valueForKey:@"restaurantLng"]doubleValue];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc]init];
    CLLocationCoordinate2D coordinate = {[(NSString*)[_dictionaryPassed valueForKey:@"restaurantLat"]doubleValue] , [(NSString*)[_dictionaryPassed valueForKey:@"restaurantLng"]doubleValue] };
    point.coordinate = coordinate;
    
    [_locationMap addAnnotation:point];
    
    point.title = [_dictionaryPassed valueForKey:@"restaurantName"];
    
    region.span.longitudeDelta = 0.15f;
    region.span.latitudeDelta = 0.15f;
    [_locationMap setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"tripDistCell";
    LocationTableViewCell *cell = (LocationTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"LocationTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
        cell = [[LocationTableViewCell alloc]init];
    }
    if (indexPath.row == 0) {
        cell.fromLabel.text = @"From";
        cell.fromLabel.tintColor = [UIColor greenColor];
    }
    else{
        cell.fromLabel.text = @"To";
        cell.fromLabel.tintColor = [UIColor redColor];
    }
    cell.nameLabel.text = [_dictionaryPassed valueForKey:@"restaurantName"];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    CLLocationCoordinate2D coordinate = {[(NSString*)[_dictionaryPassed valueForKey:@"restaurantLat"]doubleValue] , [(NSString*)[_dictionaryPassed valueForKey:@"restaurantLng"]doubleValue] };
    CLLocation *location = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSLog(@"\nCurrent Location Detected\n");
             NSLog(@"placemark %@",placemark);
             NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             NSString *address = [[NSString alloc]initWithString:locatedAt];
             cell.addressLabel.text = address ;
             NSString *Area = [[NSString alloc]initWithString:placemark.locality];
             NSString *Country = [[NSString alloc]initWithString:placemark.country];
             NSString *CountryArea = [NSString stringWithFormat:@"%@, %@", Area,Country];
             NSLog(@"%@",CountryArea);
         }
         else
         {
             NSLog(@"Geocode failed with error %@", error);
             NSLog(@"\nCurrent Location Not Detected\n");
             //return;
             //             CountryArea = NULL;
         }

     }];

    
    
    
    return cell ;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"I was selected");
}



-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  2 ;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addButtonPressed:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://ec2-54-204-111-5.compute-1.amazonaws.com:5000/request/signUpForEvent" parameters:@{@"email" : @"jamal7@me.com",
                                                                                                              @"eventId" : [_dictionaryPassed valueForKey:@"uniqueId"]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                                                                  [[[UIAlertView alloc]initWithTitle:@"Success" message:@"You have signed up for the event ,see you there " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show ];
                                                                                                                  
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (IBAction)shareButtonPressed:(id)sender {
    NSString *string = [NSString stringWithFormat:@"Come and join me at %@, at %@",[_dictionaryPassed valueForKey:@"restaurantName"], [_dictionaryPassed valueForKey:@"time"]];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[string] applicationActivities:nil];
    [self presentViewController:controller animated:YES completion:nil];
}
@end

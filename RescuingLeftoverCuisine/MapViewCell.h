//
//  MapViewCell.h
//  RescuingLeftoverCuisine
//
//  Created by Jamal E. Kharrat on 10/25/14.
//  Copyright (c) 2014 Jamal E. Kharrat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

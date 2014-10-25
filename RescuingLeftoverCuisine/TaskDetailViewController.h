//
//  TaskDetailViewController.h
//  RescuingLeftoverCuisine
//
//  Created by Jamal E. Kharrat on 10/24/14.
//  Copyright (c) 2014 Jamal E. Kharrat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapViewCell.h"

@interface TaskDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *daskDetailsTableView;
@property (weak, nonatomic) IBOutlet MKMapView *locationMap;
- (IBAction)addButtonPressed:(id)sender;
- (IBAction)shareButtonPressed:(id)sender;
@property (weak, nonatomic)          NSDictionary *dictionaryPassed;
@end

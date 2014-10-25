//
//  MainViewController.h
//  RescuingLeftoverCuisine
//
//  Created by Jamal E. Kharrat on 10/24/14.
//  Copyright (c) 2014 Jamal E. Kharrat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *placesTableView;
- (IBAction)addButtonPressed:(id)sender;
- (IBAction)profileButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *noItemsView;

@end
